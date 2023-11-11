import 'package:flutter/material.dart';
import 'package:picspeak_front/config/theme/app_colors.dart';
import 'package:picspeak_front/config/theme/app_fonts.dart';
import 'package:picspeak_front/views/widgets/custom_button.dart';
import 'package:picspeak_front/views/widgets/custom_title.dart';
import 'package:picspeak_front/views/widgets/dropdown_button_options.dart';
import 'customer_content_screen.dart';

class NationalityScreen extends StatelessWidget {
  const NationalityScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        height: double.infinity,
        color: AppColors.primaryColor,
        child: Column(
          children: [
            const CustomTitle(
                headingText: 'Ayúdanos a configurar tu perfil',
                styles: AppFonts.heading1Style),
            const MainContent(),
            Expanded(child: Container()),
            const FooterContent()
          ],
        ),
      ),
    );
  }
}

// Constante temporal en vez de consumir API de nacionalidades y lengua materna
const List<String> list = <String>[
  'Boliviana',
  'Argentina',
  'Peruana',
  'Alemana',
  'chilena'
];

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Column(children: [
        SizedBox(height: 20),
        CustomTitle(
            headingText: '¿Cuál es tu nacionalidad?',
            styles: AppFonts.heading2Style),
        SizedBox(
          height: 10,
        ),
        DropdownButtonOptions(
          myObjectList: list,
        ),
        CustomTitle(
            headingText: 'Selecciona tu lengua materna',
            styles: AppFonts.heading2Style),
        SizedBox(
          height: 10,
        ),
        DropdownButtonOptions(
          myObjectList: list,
        ),
      ]),
    );
  }
}

class FooterContent extends StatelessWidget {
  const FooterContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 50, right: 20),
          child: CustomButton(
            alignment: MainAxisAlignment.spaceBetween,
            text: 'CONTINUAR',
            icon: Icons.arrow_forward_ios_outlined,
            color: AppColors.bgSecondaryColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CustomerContentScreen()),
              );
            },
          ),
        ),
      ],
    );
  }
}
