// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:picspeak_front/config/theme/app_colors.dart';
import 'package:picspeak_front/views/auth/create_profile_screen.dart';
import 'package:picspeak_front/views/widgets/custom_button.dart';

class SavePasswordScreen extends StatefulWidget {
  final String userEmail;

  const SavePasswordScreen({required this.userEmail});

  @override
  State<SavePasswordScreen> createState() => _SavePasswordScreenState();
}

class _SavePasswordScreenState extends State<SavePasswordScreen> {
  TextEditingController txtPasswordController = TextEditingController();
  TextEditingController txtConfirmPasswordController = TextEditingController();

  bool passwordVisibility = false;

  @override
  void initState() {
    super.initState();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.primaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 70.0),
                child: Text(
                  'Contraseña',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: AppColors.textColor,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              const Text(
                'Coloque una contraseña segura',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.textColor,
                  fontFamily: 'Inter',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                child: Column(children: [
                  TextField(
                    controller: txtPasswordController,
                    obscureText: !passwordVisibility,
                    autofocus: false,
                    style: const TextStyle(
                        fontSize: 22.0, color: Color.fromARGB(255, 5, 5, 6)),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Contraseña',
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                      ),
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
                  const SizedBox(height: 20),
                  TextField(
                    controller: txtConfirmPasswordController,
                    obscureText: !passwordVisibility,
                    autofocus: false,
                    style: const TextStyle(
                        fontSize: 22.0, color: Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Repite la contraseña',
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      suffixIcon: InkWell(
                          onTap: () => setState(
                                () => passwordVisibility = !passwordVisibility,
                              ),
                          focusNode: FocusNode(skipTraversal: true),
                          child: Icon(
                            passwordVisibility
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: const Color(0xFF95A1AC),
                            size: 22,
                          )),
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
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 80, right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      alignment: MainAxisAlignment.spaceBetween,
                      icon: Icons.arrow_back_ios,
                      color: AppColors.bgSecondaryColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    CustomButton(
                      alignment: MainAxisAlignment.spaceBetween,
                      text: 'CONTINUAR',
                      icon: Icons.arrow_forward_ios_outlined,
                      color: AppColors.bgSecondaryColor,
                      onPressed: () {
                        String userPassword = txtPasswordController.text;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateProfileScreen(userEmail: userEmail, userPassword: userPassword)),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
