// ignore_for_file: avoid_print, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_fonts.dart';
import 'package:picspeak_front/views/widgets/custom_title.dart';
import '../widgets/custom_button.dart';
import '../widgets/multi_select_tags.dart';
import 'language_selection_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/configuration_service.dart';

class InterestSelectionScreen extends StatelessWidget {
  const InterestSelectionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          CustomTitle(
            headingText: 'Intereses',
            styles: AppFonts.heading1Style,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: 16.0,
                top: 16.0,
                left: 16.0,
                right: 16.0,
              ),
              child: Column(
                children: [
                  MainContent(),
                ],
              ),
            ),
          ),
        ],
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
  List<String> allTags = [];
  List<String> selectedTags = [];
  //['Animales', 'Música', 'Cine', 'Futbol', 'Comedia', 'Tecnologia', 'Idiomas', 'Electronica', 'Lectura'];

  @override
  void initState() {
    super.initState();
    _getInterests().then((tags) {
      setState(() {
        allTags = tags;
      });
    });
  }

  Future<List<String>> _getInterests() async {
    final response = await getInterests();
    final List<String> result = [];
    if (response != null) {
      for (final interest in response) {
        result.add(interest['name']);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 20),
      const CustomTitle(
          headingText: '¿Qué tipo de intereses tienes?',
          styles: AppFonts.heading2Style),
      MultiSelectTags(
        tags: allTags,
        selectedTags: selectedTags,
        onSelectionChanged: (tags) {
          setState(() {
            selectedTags = tags;
            print(selectedTags);
          });
        },
      ),
      FooterContent(selectedTags: selectedTags),
    ]);
  }
}

class FooterContent extends StatelessWidget {
  final List<String> selectedTags;
  const FooterContent({super.key, required this.selectedTags});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 30),
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
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              print("user id: ${pref.getInt('userId')}");
              print("tags seleccionados en FooterContent: $selectedTags");
              //  print("contexto: ${MainContent.selectedTags}");
              final response =
                  await setInterestUser(pref.getInt('userId'), selectedTags);

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
