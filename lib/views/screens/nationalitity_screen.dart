// ignore_for_file: avoid_print, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:picspeak_front/views/interfaces/dropdown_object.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_fonts.dart';
import '../widgets/dropdown_button_options.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_title.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/customer_content_screen.dart';
import '../../services/configuration_service.dart';

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
  Future<List<DropdownObject>>? nationalityFuture; // Nuevo
  Future<List<DropdownObject>>? languageFuture;
  Future<dynamic>? nationalities;

  @override
  void initState() {
    super.initState();
    nationalityFuture = _getNacionalidades();
  }

  Future<List<DropdownObject>> _getNacionalidades() async {
    try {
      print("ingresa a _getNacionalidades");
      final response = await getNacionalidades();
      final List<DropdownObject> result = [];

      if (response != null && response is List) {
        print("response != null");
        for (final nacionalidad in response) {
          if (nacionalidad is Map &&
              nacionalidad.containsKey('id') &&
              nacionalidad.containsKey('name')) {
            result.add(DropdownObject(
                id: nacionalidad['id'], name: nacionalidad['name']));
          }
        }

        if (result.isNotEmpty) {
          print("el result no está vacío");
          selectedNationality.value = result.first.id;
          languageList.addAll(await _getLanguages());
          print(
              'La longitud de la lista de language es: ${languageList.length}');
          selectedLanguage.value = languageList.first.id;
          print('El language seleccionado es: ${selectedLanguage.value}');
          nationalityList.addAll(result);
          return result;
        } else {
          // Manejar el caso en que la lista resultante esté vacía o no tenga el formato esperado.
          print('La lista de nacionalidades no tiene el formato esperado.');
          return [];
        }
      } else {
        // Manejar el caso en que la respuesta sea nula o no tenga el formato esperado.
        print(
            'La respuesta de getNacionalidades no tiene el formato esperado.');
        return [];
      }
    } catch (e) {
      // Manejar cualquier excepción que pueda ocurrir durante la ejecución.
      print('Error durante la obtención de nacionalidades: $e');
      return [];
    }
  }

  Future<List<DropdownObject>> _getLanguages() async {
    try {
      final response = await getLanguage();
      final List<DropdownObject> result = [];

      if (response != null && response is List) {
        for (final language in response) {
          if (language is Map &&
              language.containsKey('id') &&
              language.containsKey('name')) {
            result.add(
                DropdownObject(id: language['id'],name: language['name']));
          }
        }
      }
      return result;
    } catch (e) {
      // Manejar cualquier excepción que pueda ocurrir durante la ejecución.
      print('Error durante la obtención de idiomas: $e');
      return [];
    }
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
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // Maneja errores
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return MainContent(
                      selectedNationality: selectedNationality,
                      selectedLanguage: selectedLanguage,
                      nationalityList: nationalityList,
                      languageList: languageList);
                } else {
                  // En caso de otro estado, muestra un mensaje genérico
                  return const Text('Esperando carga');
                }
              },
            ),
            Expanded(child: Container()),
            ValueListenableBuilder(
                valueListenable: selectedNationality,
                builder: (context, int? selectedNationalityValue, child) {
                  print('Cambió la nacionalidad: $selectedNationalityValue');

                  return ValueListenableBuilder(
                    valueListenable: selectedLanguage,
                    builder: (context, int? selectedLanguageValue, child) {
                      final textWithIDs =
                          'Nationality ID: $selectedNationalityValue, Language ID: $selectedLanguageValue';
                      return FooterContent(
                          text: textWithIDs,
                          nationality_id: selectedNationalityValue,
                          language_id: selectedLanguageValue);
                    },
                  );
                })
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
  final int? nationality_id;
  final int? language_id;

  const FooterContent({
    super.key,
    required this.text,
    required this.nationality_id,
    required this.language_id,
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
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();

              print("usuario id: ${pref.getInt('userId')}");
              final response = await setLanguageNationalityUser(
                  pref.getInt('userId'), language_id, nationality_id);
              print("Response: $response");
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
