import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:picspeak_front/presentation/interfaces/DropdownObject.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/app_fonts.dart';

import '../widgets/dropdown_button_options.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_title.dart';

import 'customer_content_screen.dart';
import '../../api/services/configuration_service.dart';

class NationalityScreen extends StatefulWidget {
  const NationalityScreen({
    super.key,
  });
  @override
  State<NationalityScreen> createState() => _NationalityState();
}

class _NationalityState extends State<NationalityScreen> {
  final List<DropdownObject> nationalityList = [];
  final List<DropdownObject> languageList = [];
  final ValueNotifier<int?> selectedNationality = ValueNotifier<int?>(null);
  final ValueNotifier<int?> selectedLanguage = ValueNotifier<int?>(null);
  static final Logger logger = Logger();
  Future<List<DropdownObject>>? nationalityFuture; // Nuevo
  Future<List<DropdownObject>>? languageFuture;
  Future<dynamic>? nationalities;

  @override
  void initState() {
    super.initState();
    nationalityFuture = _getNacionalidades();
    // nationalityFuture?.then((list) {
    //   if (list.isNotEmpty) {
    //     nationalityList.addAll(list);
    //     selectedNationality.value = list[0].id;
    //     languageFuture = _getLanguages(list[0].id);
    //     languageFuture?.then((val) {
    //       if (val.isNotEmpty) {
    //         logger.e("está es perando a los languages");
    //         //  logger.e("cantidad de lenguages: ${languageList.length}");
    //         selectedLanguage.value = val[0].id;
    //       }
    //     });
    //   }
    // });
  }

  Future<List<DropdownObject>> _getNacionalidades() async {
    final ConfigurationService nationalityService = ConfigurationService();
    final response = await nationalityService.getNacionalidades();
    final List<DropdownObject> result = [];
    if (response != null) {
      for (final nacionalidad in response) {
        result.add(
            DropdownObject(id: nacionalidad['id'], name: nacionalidad['name']));
      }
    }
    selectedNationality.value = result.first.id;
    languageList.addAll(await _getLanguages(result.first.id));
    selectedLanguage.value = languageList.first.id;
    nationalityList.addAll(result);
    return result;
  }

  Future<List<DropdownObject>> _getLanguages(int id) async {
    final ConfigurationService nationalityService = ConfigurationService();
    final response = await nationalityService.getLanguage(id);
    final List<DropdownObject> result = [];
    if (response != null) {
      for (final language in response) {
        result.add(DropdownObject(
            id: language['language']['id'],
            name: language['language']['name']));
      }
    }
    return result;
  }

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
            const CustomTitle(
                headingText: 'Ayúdanos a configurar tu perfil',
                styles: AppFonts.heading1Style),
            FutureBuilder<List<DropdownObject>>(
              // Usar FutureBuilder
              future: nationalityFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Muestra un indicador de carga mientras se obtienen los datos
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // Maneja errores
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  // Los datos se han cargado con éxito, ahora puedes mostrarlos
                  // nationalityList.clear();
                  // nationalityList.addAll(snapshot.data!);
                  // logger.e("entra al future");
                  return MainContent(
                      selectedNationality: selectedNationality,
                      selectedLanguage: selectedLanguage,
                      nationalityList: nationalityList,
                      languageList: languageList);
                } else {
                  // En caso de otro estado, muestra un mensaje genérico
                  return Text('Esperando carga');
                }
              },
            ),
            Expanded(child: Container()),
            ValueListenableBuilder<int?>(
              valueListenable: selectedNationality,
              builder: (context, selectedNationalityValue, child) {
                if (selectedNationalityValue != null) {
                  _getLanguages(selectedNationalityValue).then((result) {
                    if (result.isNotEmpty) {
                      languageList.clear();
                      languageList.addAll(result);
                      // También puedes seleccionar el primer elemento si lo deseas
                      selectedLanguage.value = result.first.id;
                    }
                  });
                }

                return FooterContent(
                  text:
                      'Nationality ID: $selectedNationalityValue, Language ID: ${selectedLanguage.value}',
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  final ValueNotifier<int?> selectedNationality;
  final ValueNotifier<int?> selectedLanguage;
  final List<DropdownObject> nationalityList;
  final List<DropdownObject> languageList;

  const MainContent(
      {Key? key,
      required this.selectedNationality,
      required this.selectedLanguage,
      required this.nationalityList,
      required this.languageList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 20),
      const CustomTitle(
          headingText: '¿Cuál es tu nacionalidad?',
          styles: AppFonts.heading2Style),
      DropdownButtonOptions(
          myObjectList:
              nationalityList, // Reemplaza nationalityList por tu lista de objetos
          selectedValueNotifier: selectedNationality),
      const CustomTitle(
          headingText: 'Selecciona tu lengua materna',
          styles: AppFonts.heading2Style),
      DropdownButtonOptions(
        myObjectList:
            languageList, // Reemplaza languageList por tu lista de objetos
        selectedValueNotifier: selectedLanguage,
      ),
    ]);
  }
}

class FooterContent extends StatelessWidget {
  final String text;

  const FooterContent({
    super.key,
    required this.text,
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
            onPressed: () {
              print(text);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CustomerContentScreen()),
              );
            },
          ),
        ),
      ],
    );
  }
}
