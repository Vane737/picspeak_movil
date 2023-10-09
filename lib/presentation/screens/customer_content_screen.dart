 import 'package:flutter/material.dart';
import 'package:picspeak_front/presentation/screens/interest_selection_screen.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/app_fonts.dart';

import 'package:picspeak_front/presentation/widgets/custom_title.dart';

import '../widgets/custom_button.dart';
import '../widgets/multi_select_tags.dart';




class CustomerContentScreen extends StatelessWidget {
  const CustomerContentScreen({
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
            
            const CustomTitle(headingText: 'Ayúdanos a configurar tu perfil', styles: AppFonts.heading1Style),
      
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


  const MainContent({
    super.key
  });

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  List<String> allTags = ['Violencia', 'Armas', 'Desnudez', 'Pornografía', 'Drogas', 'Gore', 'Accidentes', 'Gestos ofensivos'];

  List<String> selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return  Column(
          children: [
              const SizedBox(height: 50),
              const CustomTitle(headingText: '¿Qué contenido no quieres recibir?', styles: AppFonts.heading2Style),
              
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    alignment: MainAxisAlignment.spaceBetween,
                    icon: Icons.arrow_back_ios, 
                    color: AppColors.bgSecondaryColor, 
                    width: 55, 
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),       
                  CustomButton(
                    alignment: MainAxisAlignment.spaceBetween,
                    text: 'CONTINUAR', 
                    icon: Icons.arrow_forward_ios, 
                    color: AppColors.bgSecondaryColor, 
                    width: 150, 
                    onPressed: (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const InterestSelectionScreen()),
                    );
                    },
                  ),       
                ],
              ),
    );
  }
}
