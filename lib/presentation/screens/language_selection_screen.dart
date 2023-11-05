import 'package:flutter/material.dart';
import 'package:picspeak_front/api/services/configuration_service.dart';
import 'package:picspeak_front/config/theme/app_text_style.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/app_fonts.dart';

import 'package:picspeak_front/presentation/widgets/custom_title.dart';

import '../widgets/custom_button.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      padding: const EdgeInsets.only(
        bottom: 16.0,
        top: 50,
        left: 16.0,
        right: 16.0,
      ),
      width: double.infinity,
      height: double.infinity,
      color: AppColors.primaryColor,
      child: Center(
        child: Column(
          children: [
            const CustomTitle(
              headingText: 'Idiomas',
              styles: AppFonts.heading1Style,
            ),
            const MainContent(),
            // FooterContent(),
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
  bool valuebool = false;
  List<String> selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      SizedBox(height: 50),
      CustomTitle(
          headingText: 'Elige tus idiomas preferidos',
          styles: AppFonts.heading2Style),
      DropdownTagSelector(),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            alignment: MainAxisAlignment.center,
            icon: null,
            text: 'TERMINAMOS',
            color: AppColors.bgPrimaryColor,
            // width: 200,
            onPressed: () async {
              print("lenguajes seleccionados: $selectedTags");

              final ConfigurationService configurationService =
                  ConfigurationService();
              final response =
                  await configurationService.setLanguagesUser(2, selectedTags);
              print("RESPUESTA LANGUAGE USER: $response");
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const LanguageSelectionScreen()),
              // );
            },
          ),
        ],
      ),
    );
  }
}

class DropdownTagSelector extends StatefulWidget {
  const DropdownTagSelector({super.key});

  @override
  DropdownTagSelectorState createState() => DropdownTagSelectorState();
}

class DropdownTagSelectorState extends State<DropdownTagSelector> {
  List<String> selectedOptions = [];
  List<String> availableOptions = [];
  @override
  void initState() {
    super.initState();
    _getLanguages().then((tags) {
      setState(() {
        availableOptions = tags;
      });
    });
  }

  Future<List<String>> _getLanguages() async {
    final ConfigurationService configurationService = ConfigurationService();
    final response = await configurationService.getLanguage();
    final List<String> result = [];
    if (response != null) {
      for (final language in response) {
        result.add(language['name']);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButton<String>(
          hint: const Text("Seleccionar"),
          isExpanded: true,
          style: AppTextStyles.inputLightTextStyle,
          value: null,
          onChanged: (String? selectedOption) {
            if (selectedOption != null &&
                !selectedOptions.contains(selectedOption)) {
              setState(() {
                selectedOptions.add(selectedOption);
              });
              print("valor seleccionado: $selectedOption");
            }
          },
          items: availableOptions.map((option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
        ),
        SizedBox.fromSize(
          size: const Size.fromHeight(20.0),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: selectedOptions.map((option) {
            return RawChip(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    20.0), // Ajusta el radio según tus preferencias
              ),
              tapEnabled: true,
              label: Text(option),
              onDeleted: () {
                setState(() {
                  selectedOptions.remove(option);
                });
              },
              deleteIcon:
                  const Icon(Icons.cancel, color: AppColors.bgPrimaryColor),
              backgroundColor: AppColors.bgYellow,
            );
          }).toList(),
        ),
        FooterContent(selectedTags: selectedOptions)
      ],
    );
  }
}
