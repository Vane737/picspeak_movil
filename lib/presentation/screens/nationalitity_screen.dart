 import 'package:flutter/material.dart';

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
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          height: double.infinity,
          color: AppColors.primaryColor,
          child: const Column( 
          children: [
            
            CustomTitle(headingText: 'Ayúdanos a configurar tu perfil', styles: AppFonts.heading1Style),

            MainContent(),

            FooterContent()

          ],
        ),
      ),
    );
  }
}


// Constante temporal en vez de consumir API de nacionalidades y lengua materna
const List<String> list = <String>['Boliviana', 'Argentina', 'Peruana', 'Alemana']; 

class MainContent extends StatelessWidget {

  
   const MainContent({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
          children: [
              SizedBox(height: 60),
              CustomTitle(headingText: '¿Cuál es tu nacionalidad?', styles: AppFonts.heading2Style),
              DropdownButtonOptions(myObjectList: list,),
              CustomTitle(headingText: 'Selecciona tu lengua materna', styles: AppFonts.heading2Style),
              DropdownButtonOptions(myObjectList: list,),
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
    return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: CustomButton(
                    alignment: MainAxisAlignment.spaceBetween,
                    text: 'CONTINUAR', 
                    icon: Icons.arrow_forward_ios_outlined, 
                    color: AppColors.bgSecondaryColor, 
                    width: 150, 
                    onPressed: (){
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




