 import 'package:flutter/material.dart';
 import 'package:flutter_svg/flutter_svg.dart';
import 'package:picspeak_front/presentation/screens/user_information/information_interests_screen.dart';
import 'package:picspeak_front/presentation/screens/user_information/information_state_screen.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_fonts.dart';


class UserInformation extends StatelessWidget {
  const UserInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
        title: Text('Información', style: AppFonts.heading2Style.copyWith(color: AppColors.primaryColor)),
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
        width: double.infinity,
        height: double.infinity,
        color: AppColors.colorBluelight,
        child:  const Column(
          children: [
            MainContent( ),

          ],
        ),
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OptionItem(
          title: 'Estado',
          description: '¡Hola estoy usando PicSpeak!',
          icon: 'assets/info.svg', // Ruta de la imagen SVG
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const InformationStateScreen(),
              ),
            );
          },
        ),
        OptionItem(
          title: 'Intereses',
          description: 'Animales, comedia, lectura, idiomas',
          icon: 'assets/smile.svg', // Ruta de la imagen SVG
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const InformationInterestsScreen(),
              ),
            );
          },
        ),
        OptionItem(
          title: 'Idiomas',
          description: 'Español, inglés, portugués',
          icon: 'assets/language.svg', // Ruta de la imagen SVG
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const InformationInterestsScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class OptionItem extends StatelessWidget {
  final String title;
  final String description;
  final String icon;
  final void Function() onTap;

  const OptionItem({super.key, 
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        icon,
        width: 40, // Personaliza el tamaño de la imagen SVG
        height: 40,
      ),
      title: Text(title, style: AppFonts.textStyle.copyWith(color: AppColors.primaryColor, fontWeight: FontWeight.bold)),
      subtitle: Text(description, style: AppFonts.smallTextStyle.copyWith(color: AppColors.bgGray)),
      onTap: onTap,
    );
  }
}


