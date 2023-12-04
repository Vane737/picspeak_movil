// ignore_for_file: file_names, use_key_in_widget_constructors, use_build_context_synchronously

import 'package:flutter/material.dart'
    show
        BorderRadius,
        BorderSide,
        BuildContext,
        Center,
        Color,
        Colors,
        Column,
        Container,
        EdgeInsets,
        InputDecoration,
        MainAxisAlignment,
        MaterialPageRoute,
        Navigator,
        OutlineInputBorder,
        Scaffold,
        ScaffoldMessenger,
        SnackBar,
        Text,
        TextAlign,
        TextField,
        TextStyle,
        UnderlineInputBorder,
        Widget;
import 'package:flutter/widgets.dart';
import 'package:picspeak_front/config/theme/app_colors.dart';
import 'package:picspeak_front/models/api_response.dart';
import 'package:picspeak_front/models/user.dart';
import 'package:picspeak_front/services/auth_service.dart';
import 'package:picspeak_front/views/screens/nationalitity_screen.dart';
import 'package:picspeak_front/views/widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ValidateEmailScreen extends StatefulWidget {
  @override
  State<ValidateEmailScreen> createState() => _ValidateEmailScreen();
}

class _ValidateEmailScreen extends State<ValidateEmailScreen> {
  TextEditingController txtCodeEmail = TextEditingController();
  bool loading = false;

  void _verifyEmail() async {
    ApiResponse response = await verifyEmail(txtCodeEmail.text);
    if (response.error == null) {
      _saveAndRedirectToNext(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _saveAndRedirectToNext(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const NationalityScreen(),
        ),
        (route) => false);
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
                  'Verifica tu correo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: AppColors.textColor,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              const Text(
                'Porfavor, ingresa el código de verificación que enviamos a tu correo electrónico',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.textColor,
                  fontFamily: 'Inter',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: txtCodeEmail,
                  obscureText: false,
                  autofocus: true,
                  style: const TextStyle(
                      fontSize: 22.0, color: Color.fromARGB(255, 5, 5, 6)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Código de verificación',
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
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 80, right: 50, left: 50),
                child: CustomButton(
                  alignment: MainAxisAlignment.center,
                  icon: null,
                  text: 'VERIFICAR',
                  color: AppColors.bgPrimaryColor,
                  onPressed: () {
                    setState(() {
                      loading = true;
                    });
                    _verifyEmail();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
