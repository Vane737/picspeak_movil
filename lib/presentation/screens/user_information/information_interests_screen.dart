 import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_fonts.dart';



class InformationInterestsScreen extends StatelessWidget {
  const InformationInterestsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
  final List<String> selectedInterests = ['Opción 1', 'Opción 2', 'Opción 3', 'Opción 4', 'Opción 5'];
  final List<String> interestsOptions = ['Opción 1', 'Opción 2', 'Opción 3', 'Opción 4', 'Opción 5', 'Opción 6', 'Opcion 7', 'Opcion 8'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Intereses', style: AppFonts.heading2Style.copyWith(color: AppColors.primaryColor)),
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
        child:  Column(
          children: [
            MainContent( selectedOptions : selectedInterests, interestsOptions: interestsOptions  ),

          ],
        ),
      ),
    );
  }
}

class MainContent extends StatefulWidget {
  final List<String> selectedOptions;
  final List<String> interestsOptions;

  const MainContent({Key? key, required this.selectedOptions, required this.interestsOptions}) : super(key: key);

  @override
  State<MainContent> createState() => _MainContentState( );
}

class _MainContentState extends State<MainContent> {

  // Modal para registrar un nuevo estado
  List<String> selectedInterests = [];

  @override
  void initState() {
    super.initState();
    // Filtra las opciones de intereses seleccionadas
    selectedInterests = widget.interestsOptions.where((interest) {
      return widget.selectedOptions.contains(interest);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Interés personal',
                  style: AppFonts.smallTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                Wrap(
                  spacing: 2.0,
                  runSpacing: 2.0,
                  children: selectedInterests.map((interest) {
                    return RawChip(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      label: Text(interest),
                      avatar: const Icon(Icons.check, color: AppColors.bgYellow),
                      onDeleted: () {
                        setState(() {
                          selectedInterests.remove(interest);
                        });
                      },
                      deleteIcon: const Icon(Icons.cancel, color: AppColors.bgPrimaryColor),
                      backgroundColor: AppColors.bgYellow,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const Divider(
            color: AppColors.colorGrayLight,
            thickness: 1,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 10, left: 16, right: 10, bottom: 10),
            child: Text(
              'Intereses',
              style: AppFonts.smallTextStyle.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: List<Widget>.generate(widget.interestsOptions.length, (index) {
                final state = widget.interestsOptions[index];
                final isSelected = selectedInterests.contains(state);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedInterests.remove(state);
                      } else {
                        selectedInterests.add(state);
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state,
                          style: isSelected
                            ? AppFonts.smallTextStyle.copyWith(color: AppColors.colorGrayLight)
                            : AppFonts.smallTextStyle.copyWith(color: AppColors.colorGrayLight),
                        ),
                        if (isSelected)
                          const Icon(Icons.check, color: AppColors.bgYellow),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

