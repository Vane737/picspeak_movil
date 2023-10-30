import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import '../../../config/theme/app_fonts.dart';
import 'package:picspeak_front/config/theme/app_colors.dart';

import 'package:picspeak_front/models/user.dart';
import 'package:picspeak_front/presentation/screens/user_information/user_information.dart';
import 'package:picspeak_front/presentation/widgets/custom_button.dart';


class EditProfileScreen extends StatefulWidget {
  final User user = User(
    photourl: 'https://cdn-icons-png.flaticon.com/512/147/147142.png',
    name: 'John',
    lastname: 'Doe',
    username: 'johndoe123',
    birthDate: DateTime(1990, 5, 15),
  );
  
  EditProfileScreen({super.key});

  @override
  EditProfileScreenState createState() => EditProfileScreenState(user: user);
}

class EditProfileScreenState extends State<EditProfileScreen> {
  // DateTime? _selectedDate;
  // File? _image;
  // String userStatus = "Estado actual del usuario"; // Agrega el estado del usuario
  DateTime? _selectedDate;
  late User user;
  File? _image;

  EditProfileScreenState({required this.user});

  @override
  void initState() {
    super.initState();
    _selectedDate = user.birthDate;
  }

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

  @override
  Widget build(BuildContext context) {
    String formattedDate = _selectedDate != null
        ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
        : '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil', style: AppFonts.heading2Style.copyWith(color: AppColors.primaryColor)),
        backgroundColor: AppColors.colorBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () {
            // Agrega aquí la lógica para manejar la acción de retroceso
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: AppColors.primaryColor,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only( left: 20, right: 20, bottom: 10),
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
                        user.photourl?? 'https://cdn-icons-png.flaticon.com/512/147/147142.png', // Mostrar la imagen del usuario
                        width: 140,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: AppColors.bgPrimaryColor,
                          radius: 25,
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt, color: AppColors.primaryColor,),
                            onPressed: () {
                              _imgFromCamera();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserInformation(
                          // initialUserStatus: user.userStatus,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.amber, // Fondo amarillo para el estado
                      borderRadius: BorderRadius.circular(20.7), // Borde redondeado
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            user.userStatus?? '¡Hola, estoy usando PicSpeak!',
                            style: AppFonts.smallTextStyle.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserInformation(
                                  // initialUserStatus: user.userStatus,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
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
                        controller: TextEditingController(text: user.name),
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
                          contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                        ),
                        controller: TextEditingController(text: user.lastname),
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
                        controller: TextEditingController(text: user.username),
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
                  padding: const EdgeInsets.only(bottom: 10, right: 50, left: 50),
                  child: CustomButton(
                    alignment: MainAxisAlignment.center,
                    icon: null,
                    text: 'Guardar',
                    color: AppColors.bgPrimaryColor,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserInformation()),
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