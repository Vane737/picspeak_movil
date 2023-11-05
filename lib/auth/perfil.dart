// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:picspeak_front/auth/verificCorreo.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:picspeak_front/config/theme/app_colors.dart';
import 'package:picspeak_front/presentation/widgets/custom_button.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  DateTime? _selectedDate;
  File? _image;

  Future _imgFromCamera() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future _imgFromGallery() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Selecciona una fuente de imagen"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _imgFromCamera();
                Navigator.of(context).pop();
              },
              child: Text("Cámara"),
            ),
            TextButton(
              onPressed: () {
                _imgFromGallery();
                Navigator.of(context).pop();
              },
              child: Text("Galería"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = _selectedDate != null
        ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
        : '';

    return Scaffold(
      body: Container(
        color: AppColors.primaryColor,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 70.0),
                  child: Text(
                    'Tu perfil',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      color: AppColors.textColor,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
                const Text(
                  'En PicSpeak todos tenemos un nombre, dinos el tuyo :3',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.textColor,
                    fontFamily: 'Inter',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white,
                        child: _image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(70),
                                child: Image.file(
                                  _image!,
                                  width: 140,
                                  height: 140,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Image.network(
                                'https://cdn-icons-png.flaticon.com/512/147/147142.png',
                                width: 140,
                                height: 140,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25,
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt),
                            onPressed: () {
                              _showImageSourceDialog(); // Mostrar diálogo para elegir cámara o galería
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        obscureText: false,
                        autofocus: false,
                        style: const TextStyle(
                            fontSize: 22.0,
                            color: Color.fromARGB(255, 5, 5, 6)),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Nombres',
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 242, 237, 237)),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 232, 229, 229)),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        obscureText: false,
                        autofocus: false,
                        style: const TextStyle(
                            fontSize: 22.0,
                            color: Color.fromARGB(255, 0, 0, 0)),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Apellidos',
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        obscureText: false,
                        autofocus: false,
                        style: const TextStyle(
                            fontSize: 22.0,
                            color: Color.fromARGB(255, 0, 0, 0)),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Username',
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () => _selectDate(context), // Mostrar DatePicker
                        child: AbsorbPointer(
                          child: TextField(
                            obscureText: false,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Cumpleaños',
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 8.0, top: 8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                            ),
                            controller:
                                TextEditingController(text: formattedDate),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, right: 50, left: 50),
                  child: CustomButton(
                    alignment: MainAxisAlignment.center,
                    icon: null,
                    text: 'CREAR CUENTA',
                    color: AppColors.bgPrimaryColor,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerificCorreo()),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
