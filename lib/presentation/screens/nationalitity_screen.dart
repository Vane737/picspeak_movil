 import 'package:flutter/material.dart';
import 'package:picspeak_front/presentation/interfaces/DropdownObject.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/app_fonts.dart';

import '../widgets/dropdown_button_options.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_title.dart';

import 'customer_content_screen.dart';



class NationalityScreen extends StatelessWidget {


  const NationalityScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int?> selectedNationality = ValueNotifier<int?>(null);
    final ValueNotifier<int?> selectedLanguage = ValueNotifier<int?>(null);

    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          height: double.infinity,
          color: AppColors.primaryColor,
          child: Column( 
          children: [
            
            const CustomTitle(headingText: 'Ayúdanos a configurar tu perfil', styles: AppFonts.heading1Style),

            MainContent(selectedNationality: selectedNationality, selectedLanguage: selectedLanguage),
            Expanded(child: Container()),
                        ValueListenableBuilder(
              valueListenable: selectedNationality,
              builder: (context, int? selectedNationalityValue, child) {
                return ValueListenableBuilder(
                  valueListenable: selectedLanguage,
                  builder: (context, int? selectedLanguageValue, child) {
                    final textWithIDs = 'Nationality ID: $selectedNationalityValue, Language ID: $selectedLanguageValue';
                    return FooterContent(text: textWithIDs);
                  },
                  );
                }
              )
          ],
        ),
      ),
    );
  }
}


// Constante temporal en vez de consumir API de nacionalidades y lengua materna
final List<DropdownObject> languageList = [
  DropdownObject(id: 1, name: 'Español'),
  DropdownObject(id: 2, name: 'Inglés'),
  DropdownObject(id: 3, name: 'Francés'),
  // Agrega más idiomas según tus necesidades
];

final List<DropdownObject> nationalityList = [
  DropdownObject(id: 1, name: 'Boliviana'),
  DropdownObject(id: 2, name: 'Argentina'),
  DropdownObject(id: 3, name: 'Peruana'),
  // Agrega más nacionalidades según tus necesidades
];

class MainContent extends StatelessWidget {
final ValueNotifier<int?> selectedNationality;
  final ValueNotifier<int?> selectedLanguage;
  
  const MainContent({
    Key? key,
    required this.selectedNationality,
    required this.selectedLanguage,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Column(
          children: [
              const SizedBox(height: 20),
              const CustomTitle(headingText: '¿Cuál es tu nacionalidad?', styles: AppFonts.heading2Style),
              DropdownButtonOptions(
                myObjectList: nationalityList, // Reemplaza nationalityList por tu lista de objetos
                selectedValueNotifier: selectedNationality
              ),
              const CustomTitle(headingText: 'Selecciona tu lengua materna', styles: AppFonts.heading2Style),
              DropdownButtonOptions(
                myObjectList: languageList, // Reemplaza languageList por tu lista de objetos
                selectedValueNotifier: selectedLanguage,
              ),
          ]
        );
  }
}

class FooterContent extends StatelessWidget {
  final String text;
  
  const FooterContent({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: CustomButton(
                    alignment: MainAxisAlignment.spaceBetween,
                    text: 'CONTINUAR', 
                    icon: Icons.arrow_forward_ios_outlined, 
                    color: AppColors.bgSecondaryColor, 
                    // width: 150, 
                    onPressed: (){
                      print(text);
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CustomerContentScreen()),
                    );
                    },
                  ),
                ),       
              ],
            );
  }
}




