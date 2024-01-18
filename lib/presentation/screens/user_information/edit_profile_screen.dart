// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:picspeak_front/models/api_response.dart';
import 'package:picspeak_front/presentation/screens/user_information/information_state_screen.dart';
import 'package:picspeak_front/services/auth_service.dart';
import 'package:picspeak_front/views/chat/chat_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../../../config/theme/app_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:picspeak_front/config/theme/app_colors.dart';
import 'package:picspeak_front/models/user.dart';
import 'package:picspeak_front/views/widgets/custom_button.dart';

class EditProfileScreen extends StatefulWidget {

  const EditProfileScreen({super.key});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  User user = User();
  File? _image;
  bool loading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  EditProfileScreenState();

  @override
  void initState() {
    super.initState();
    _initializeData();
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

    Future<String> compressImage(File imageFile) async {
    final Uint8List? result = await FlutterImageCompress.compressWithFile(
      imageFile.absolute.path,
      quality: 20, 
    );

    if (result != null && result.isNotEmpty) {
      return base64Encode(Uint8List.fromList(result));
    } else {
      return '';
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

  // Añadir función para actualizar el perfil
  void _updateProfile() async {
    String? compressedImage =
        _image == null ? user.photourl : await compressImage(_image!);
    String formattedBirthday =
        _selectedDate != null ? _selectedDate!.toIso8601String() : user.birthDate!.toIso8601String();

    String name = _nameController.text;
    String lastname = _lastnameController.text;
    String username = _usernameController.text;

    String? email = user.email ;
    print("Email despues de pasar a otra variable $email");
    ApiResponse response = await updateUser(
      name,
      lastname,
      username,
      formattedBirthday,
      compressedImage,
      email,
    );

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

  Future<void> _initializeData() async {

    await _getProfileUser().then((profile) {
      print("Este es el id: ${profile.photourl}");
      setState(() {
        user.photourl = profile.photourl ?? '';
        _nameController.text = profile.name ?? '';
        _lastnameController.text = profile.lastname ?? '';
        _usernameController.text = profile.username ?? '';
        _selectedDate = profile.birthDate ?? DateTime.now();
      });
    });

    // Ahora puedes imprimir los datos actualizados de user
    print("Nombre del usuario: ${user.username}");
  }

  void _saveAndRedirectToHome(User user) async {
    if (mounted) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('token', user.token ?? '');
      await pref.setInt('userId', user.id ?? 0);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => ChatList(),
          ),
          (route) => false);
    }
  }

  Future<User> _getProfileUser() async {
    print("ingresa a getProfileUser");
    ApiResponse response = await getUserDetail();
    User result = User(); // Inicializa un nuevo objeto User

    if (response.data != null) {
      print("EL RESPONSE ES DISTINTO DE NULL");
      dynamic responseData = response.data;

      if (responseData is User) {
        // Si responseData ya es una instancia de User, úsala directamente
        result.photourl = responseData.photourl;
        result.name = responseData.name;
        result.lastname = responseData.lastname;
        result.username = responseData.username;
        result.birthDate = responseData.birthDate;
        result.nationality = responseData.nationality;
        result.gender = responseData.gender;
        result.email = responseData.email;
        user.birthDate = responseData.birthDate;
        user.email = responseData.email;

        // Asigna otros campos según sea necesario
        print("Datos del perfil del usuario: $result");
      } else {
        // Manejar el caso en el que la respuesta no es del tipo esperado
        print("Error: La respuesta no es del tipo esperado.");
      }
    }
    print("Este es el result: $result");
    return result;
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
            child: Form(
              key: formKey,
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
                              : ClipOval(
                                  child: Image.network(
                                    user.photourl ?? 'https://cdn-icons-png.flaticon.com/512/147/147142.png',
                                    width: 140,
                                    height: 140,
                                    fit: BoxFit.cover,
                                  ),
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
                      // Agrega aquí la lógica para manejar la acción de tocar
                      // el widget que muestra la información del usuario.
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
                              '¡Hola, estoy usando PicSpeak!',
                              style: AppFonts.smallTextStyle.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const InformationStateScreen(),
                                ),
                              );
                              // Agrega aquí la lógica para manejar la acción de tocar
                              // el botón de edición.
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
                          controller: _nameController,
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
                          controller: _lastnameController,
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
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: _usernameController,
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
                    padding: const EdgeInsets.only(bottom: 10, right: 50, left: 50),
                    child: CustomButton(
                      alignment: MainAxisAlignment.center,
                      icon: null,
                      text: 'Guardar',
                      color: AppColors.bgPrimaryColor,
                      onPressed: () async {
                         if (formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        _updateProfile();
                      }
                        // Llamar a la función para actualizar el perfil al presionar el botón
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}