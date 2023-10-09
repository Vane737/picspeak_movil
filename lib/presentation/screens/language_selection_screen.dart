 import 'package:flutter/material.dart';
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
          padding: const EdgeInsets.only(bottom: 16.0, top: 50, left: 16.0, right: 16.0),
          width: double.infinity,
          height: double.infinity,
          color: AppColors.primaryColor,
          child:  Center(
            child: Column( 
            children: [
              
              const CustomTitle(headingText: 'Idiomas', styles: AppFonts.heading1Style),
                
              const MainContent(),
               
              Expanded(child: Container()),
              
              const FooterContent(),
          
            ],
                  ),
          ),
      ),
    );
  }
}


class MainContent extends StatefulWidget {


  const MainContent({
    super.key
  });

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  List<String> allTags = ['Animales', 'Música', 'Cine', 'Futbol', 'Comedia', 'Tecnologia', 'Idiomas', 'Electronica', 'Lectura'];
  bool valuebool = false;
  List<String> selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return  const Column(
          children: [
              SizedBox(height: 80),
              CustomTitle(headingText: 'Elige tus idiomas preferidos', styles: AppFonts.heading2Style),
              
              DropdownTagSelector(),    
          ]
        );
  }
}

class FooterContent extends StatelessWidget {
  const FooterContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 150),
      child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    alignment: MainAxisAlignment.center,
                    icon: null,
                    text: 'TERMINAMOS', 
                    color: AppColors.bgPrimaryColor, 
                    width: 200, 
                    onPressed: (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LanguageSelectionScreen()),
                    );
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
  List<String> availableOptions = ['Opción 1', 'Opción 2', 'Opción 3', 'Opción 4', 'Opción 5'];

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
          if (selectedOption != null && !selectedOptions.contains(selectedOption)) {
            setState(() {
              selectedOptions.add(selectedOption);
            });
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
                borderRadius: BorderRadius.circular(20.0), // Ajusta el radio según tus preferencias
              ),
              tapEnabled: true,
              label: Text(option),
              onDeleted: () {
                setState(() {
                  selectedOptions.remove(option);
                });
              },
              deleteIcon: const Icon(Icons.cancel, color: AppColors.bgPrimaryColor),
              backgroundColor: AppColors.bgYellow,
            );
          }).toList(),
        ),
      ],
    );
  }
}

