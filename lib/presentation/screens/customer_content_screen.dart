import 'package:flutter/material.dart';
import 'package:picspeak_front/presentation/screens/interest_selection_screen.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/app_fonts.dart';

import 'package:picspeak_front/presentation/widgets/custom_title.dart';

import '../widgets/custom_button.dart';
import '../widgets/multi_select_tags.dart';
import '../../api/services/configuration_service.dart';

class CustomerContentScreen extends StatelessWidget {
  const CustomerContentScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          color: AppColors.primaryColor, // No establezcas una altura aquí
          child: Column(
            children: [
              const CustomTitle(
                  headingText: 'Ayúdanos a configurar tu perfil',
                  styles: AppFonts.heading1Style),
              const MainContent(),
              // No es necesario el Expanded aquí
             // const FooterContent(selectedTags: []),
            ],
          ),
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
  List<String> allTags = [];
  List<String> selectedTags = [];

  @override
  void initState() {
    super.initState();
    _getInappropriateContents().then((tags) {
      setState(() {
        allTags = tags;
      });
    });
  }

  Future<List<String>> _getInappropriateContents() async {
    final ConfigurationService configurationService = ConfigurationService();
    final response = await configurationService.getInappropriateContents();
    final List<String> result = [];
    if (response != null) {
      for (final contenido in response) {
        result.add(contenido['name']);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 20),
      const CustomTitle(
          headingText: '¿Qué contenido no quieres recibir?',
          styles: AppFonts.heading2Style),
      MultiSelectTags(
        tags: allTags,
        selectedTags: selectedTags,
        onSelectionChanged: (tags) {
          setState(() {
              print("ANTES tags seleccionados: ${selectedTags}");
            selectedTags = tags;
            print("DESPUÉS tags seleccionados: ${selectedTags}");
          });
        },
      ),
       FooterContent(selectedTags:selectedTags),
    ]);
  }
}

class FooterContent extends StatelessWidget {
  final List<String> selectedTags;
  const FooterContent({super.key, required this.selectedTags});

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
            onPressed: () async{
              print("tags seleccionados en FooterContent: $selectedTags");
              //  print("contexto: ${MainContent.selectedTags}");
              final ConfigurationService configurationService = ConfigurationService();
              final response = await configurationService.setInappropiateContentUser(2, selectedTags);

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const InterestSelectionScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
