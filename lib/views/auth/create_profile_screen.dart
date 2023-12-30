// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:picspeak_front/config/constants/api_routes.dart';
import 'package:picspeak_front/models/api_response.dart';
import 'package:picspeak_front/models/user.dart';
import 'package:picspeak_front/services/auth_service.dart';
import 'package:picspeak_front/views/auth/validate_email_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:picspeak_front/config/theme/app_colors.dart';
import 'package:picspeak_front/views/widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateProfileScreen extends StatefulWidget {
  final String userEmail;
  final String userPassword;

  const CreateProfileScreen(
      {required this.userPassword, required this.userEmail});

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<CreateProfileScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController txtNameController = TextEditingController();
  TextEditingController txtLastnameController = TextEditingController();
  TextEditingController txtUsernameController = TextEditingController();

  bool loading = false;
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

  void _registerUser() async {
    String? image = _image == null ? null : getStringImage(_image);
    String formattedBirthday =
        _selectedDate != null ? _selectedDate!.toIso8601String() : '';
    ApiResponse response = await register(
        txtNameController.text,
        txtLastnameController.text,
        txtUsernameController.text,
        formattedBirthday,
        widget.userEmail,
        widget.userPassword,
        image);

    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    userId = user.id ?? 0;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => ValidateEmailScreen(),
        ),
        (route) => false);
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
              child: Form(
            key: formKey,
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
                              _imgFromCamera();
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
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: txtNameController,
                        obscureText: false,
                        autofocus: true,
                        validator: (val) => val!.isEmpty
                            ? 'El campo no puede estar vacío'
                            : null,
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
                      TextFormField(
                        controller: txtLastnameController,
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        autofocus: false,
                        validator: (val) => val!.isEmpty
                            ? 'El campo no puede estar vacío'
                            : null,
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
                      TextFormField(
                        controller: txtUsernameController,
                        obscureText: false,
                        autofocus: false,
                        validator: (val) => val!.length < 3
                            ? 'Se requieren al menos 3 caracteres'
                            : null,
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
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        _registerUser();
                      }
                    },
                  ),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
