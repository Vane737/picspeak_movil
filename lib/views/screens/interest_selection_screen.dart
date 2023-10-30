import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/app_fonts.dart';

import 'package:picspeak_front/views/widgets/custom_title.dart';

import '../widgets/custom_button.dart';
import '../widgets/multi_select_tags.dart';
import 'language_selection_screen.dart';

class InterestSelectionScreen extends StatelessWidget {
  const InterestSelectionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
            bottom: 16.0, top: 50, left: 16.0, right: 16.0),
        width: double.infinity,
        height: double.infinity,
        color: AppColors.primaryColor,
        child: Column(
          children: [
            const CustomTitle(
                headingText: 'Intereses', styles: AppFonts.heading1Style),
            const MainContent(),
            Expanded(child: Container()),
            const FooterContent(),
          ],
        ),
      ),
    );
  }
}

class MainContent extends StatefulWidget {
  const MainContent({super.key});

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  List<String> allTags = [
    'Animales',
    'Música',
    'Cine',
    'Futbol',
    'Comedia',
    'Tecnologia',
    'Idiomas',
    'Electronica',
    'Lectura'
  ];

  List<String> selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 20),
      const CustomTitle(
          headingText: '¿Qué tipo de intereses tienes?',
          styles: AppFonts.heading2Style),
      const SizedBox(
        height: 30,
      ),
      MultiSelectTags(
        tags: allTags,
        selectedTags: selectedTags,
        onSelectionChanged: (tags) {
          setState(() {
            selectedTags = tags;
            // print(selectedTags);
          });
        },
      ),
    ]);
  }
}

class FooterContent extends StatelessWidget {
  const FooterContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomButton(
            alignment: MainAxisAlignment.spaceBetween,
            icon: Icons.arrow_back_ios,
            color: AppColors.bgSecondaryColor,
            // width: 55,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CustomButton(
            alignment: MainAxisAlignment.spaceBetween,
            text: 'CONTINUAR',
            icon: Icons.arrow_forward_ios,
            color: AppColors.bgSecondaryColor,
            // width: 150,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LanguageSelectionScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
