// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:picspeak_front/config/theme/app_colors.dart';
import 'package:picspeak_front/config/theme/app_fonts.dart';
import 'package:picspeak_front/models/api_response.dart';
import 'package:picspeak_front/models/user.dart';
import 'package:intl/intl.dart';
import 'package:picspeak_front/services/auth_service.dart';
import 'package:picspeak_front/services/configuration_service.dart';
import 'package:picspeak_front/views/widgets/seleted_tags_display.dart';

class ViewProfileScreen extends StatefulWidget {
  final int? id;
  const ViewProfileScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  List<String> selectedTags = [];

  User user = User();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _getInterests().then((tags) {
      setState(() {
        selectedTags = tags;
      });
    });

    await _getProfileUser().then((profile) {
      print("Este es el id: ${profile.id}");
      setState(() {
        user.id = profile.id;
        user.photourl = profile.photourl;
        user.name = profile.name;
        user.lastname = profile.lastname;
        user.username = profile.username;
        user.birthDate = profile.birthDate;
        user.email = profile.email;
      });
    });

    // Ahora puedes imprimir los datos actualizados de user
    print("Nombre del usuario: ${user.username}");
  }

  Future<List<String>> _getInterests() async {
    print("id user profile: ${widget.id}");
    final response = await getInterestsUser(widget.id);
    // String? tokenizer = await getTokenFromLocalStorage();
    // print("Esto es el token desde getInterest: ${tokenizer}");
    final List<String> result = [];
    if (response != null) {
      // print("Esto devuelve {$response}");
      for (final interestUser in response) {
        print(
            "Esto es un objeto del array : ${interestUser['interest']['name']}");
        result.add(interestUser['interest']['name']);
      }
    }
    return result;
  }

  Future<User> _getProfileUser() async {
    // ApiResponse response = await getUserDetail();
    ApiResponse response = await getUser(widget.id);
    print("EL RESPONSE DEL _getProfileUsear: $response");
    User result = User(); // Inicializa un nuevo objeto User

    if (response.data != null) {
      dynamic responseData = response.data;

      if (responseData is User) {
        // Si responseData ya es una instancia de User, úsala directamente
        result.id = responseData.id;
        result.photourl = responseData.photourl;
        result.name = responseData.name;
        result.lastname = responseData.lastname;
        result.username = responseData.username;
        result.birthDate = responseData.birthDate;
        result.email = responseData.email;
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

  void _mostrarMensaje(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 58, 156, 189),
          // title: Text('Pregunta'),
          content: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8), // Bordes redondeados
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // Color de la sombra
                  spreadRadius: 1, // Cuánto se extiende la sombra
                  blurRadius: 2, // Suavidad de la sombra
                  offset: const Offset(0, 2), // Desplazamiento de la sombra
                ),
              ],
            ),
            child: const Text('¿Desear eliminar a este amigo?',
                style: AppFonts.smallTextStyle),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el cuadro de diálogo
                // Acción al cancelar
                print('Cancelado');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    AppColors.bgPrimaryColor), // Color de fondo rojo
              ),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {//SI LE DÁ A ACEPTAR ELIMINAR CONTACTO
                Navigator.of(context).pop(); // Cierra el cuadro de diálogo
                // Acción al aceptar
                print('Guardado');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    AppColors.bgYellow), // Color de fondo verde
              ),
              child: const Text(
                'Aceptar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name ?? 'Cargando...',
            style:
                AppFonts.heading2Style.copyWith(color: AppColors.primaryColor)),
        backgroundColor: AppColors.colorBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () {
            // Agrega aquí la lógica para manejar la acción de retroceso
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navegar a la pantalla de edición de perfil
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => EditProfileScreen()),
              // );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Puedes agregar aquí los elementos de la pantalla de perfil
            // Por ejemplo, la imagen del perfil, información del usuario, etc.
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 10, top: 20),
                child: Stack(children: [
                  CircleAvatar(
                    radius: 80.0,
                    backgroundImage: NetworkImage(user.photourl ??
                            'https://cdn-icons-png.flaticon.com/512/147/147142.png' // Reemplaza con la URL de la imagen del perfil
                        ),
                  ),
                  Positioned(
                    // top: 0,
                    bottom: 0,
                    right: 0,
                    left: 150,
                    child: IconButton(
                      icon: const Icon(
                        Icons.flag_sharp,
                        color: AppColors.colorBlue,
                        size: 50,
                      ),
                      onPressed: () {
                        // _imgFromCamera();
                      },
                    ),
                  ),
                ]),
              ),
            ),
            Container(
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
                      style: AppFonts.smallTextStyle
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const UserInformation(
                      //       // initialUserStatus: user.userStatus,
                      //     ),
                      //   ),
                      // );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Nombre',
                      style: TextStyle(
                          fontSize: 22.0,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold)),
                  Text(user.name ?? 'Cargando datos...',
                      style: const TextStyle(
                          fontSize: 18.0, color: AppColors.textColor)),
                  const SizedBox(height: 15),
                  const Text('Nickname',
                      style: TextStyle(
                          fontSize: 22.0,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold)),
                  Text(user.username ?? 'Cargando...',
                      style: const TextStyle(
                          fontSize: 18.0, color: AppColors.textColor)),
                  const SizedBox(height: 15),
                  const Text('Correo',
                      style: TextStyle(
                          fontSize: 22.0,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold)),
                  Text(user.email ?? 'Cargando...',
                      style: const TextStyle(
                          fontSize: 18.0, color: AppColors.textColor)),
                  const SizedBox(height: 15),
                  const Text('Cumpleaños',
                      style: TextStyle(
                          fontSize: 22.0,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold)),
                  Text(
                      DateFormat('dd/MM/yyyy')
                          .format(user.birthDate ?? DateTime(1990, 5, 15)),
                      style: const TextStyle(
                          fontSize: 18.0, color: AppColors.textColor)),
                  const SizedBox(height: 15),
                  const Text('Intereses',
                      style: TextStyle(
                          fontSize: 22.0,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  SelectedTagsDisplay(selectedTags: selectedTags)
                  // const SizedBox(height: 15),
                  // Column(children: [
                  //   const SizedBox(height: 20),
                  // ])
                ],
              ),
            ),
            // Agrega más información del perfil según sea necesario
          ],
        ),
      ),
      persistentFooterButtons: [
        Center(
          child: TextButton(
              onPressed: () {
                _mostrarMensaje(context);
              },
              style: ButtonStyle(
                // radius: MaterialStateProperty.all<Radius>(Radius.circular(10.0)),
                foregroundColor:
                    MaterialStateProperty.all<Color>(AppColors.textColor),
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColors.colorGrayLight),
              ),
              child: Text(
                'Eliminar Contacto',
                style: AppFonts.heading3Style
                    .copyWith(fontWeight: FontWeight.bold),
              )),
        )
      ],
    );
  }
}
