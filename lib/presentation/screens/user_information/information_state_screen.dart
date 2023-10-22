 import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_fonts.dart';



class InformationStateScreen extends StatelessWidget {
  const InformationStateScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> defaultStates = [
    '¡Hola estoy usando PicSpeak!',
    'Disponible',
    'Ocupado',
    'Trabajando',
    // Agrega más opciones aquí
  ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Estado', style: AppFonts.heading2Style.copyWith(color: AppColors.primaryColor)),
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
            MainContent( defaultStates : defaultStates ),

          ],
        ),
      ),
    );
  }
}

class MainContent extends StatefulWidget {
  final List<String> defaultStates;
  const MainContent({Key? key, required this.defaultStates}) : super(key: key);

  @override
  State<MainContent> createState() => _MainContentState( );
}

class _MainContentState extends State<MainContent> {
  final TextEditingController _statusController = TextEditingController();
  String _currentStatus = '¡Hola estoy usando PicSpeak!';


  int selectedOptionIndex = 0;

  // Modal para registrar un nuevo estado

  void _showStatusEditor(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            color: AppColors.colorBlue,
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 20, left: 20, right: 20),
            child: Column(
              children: [
                TextField(
                  controller: _statusController,
                  decoration: const InputDecoration(
                    hintText: 'Introduce tu estado',
                    hintStyle:  TextStyle(color: AppColors.colorGrayLight, fontFamily: AppFonts.primaryFontFamily ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.colorGrayLight), // Color de la línea cuando no está enfocado
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.colorGrayLight), // Color de la línea cuando está enfocado
                    ),
                  ),
                  style: AppFonts.smallTextStyle.copyWith(color: AppColors.colorGrayLight),
                  cursorColor: AppColors.colorGrayDark, // Color del cursor
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_statusController.text.isNotEmpty) {
                          setState(() {
                            widget.defaultStates.insert(0, _statusController.text);
                            _currentStatus = _statusController.text;
                            selectedOptionIndex = 0;
                          });
                        }
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                      textStyle: MaterialStateProperty.all<TextStyle>(AppFonts.smallTextStyle),
                      backgroundColor: MaterialStateProperty.all<Color>(AppColors.bgYellow), // Cambia el color de fondo
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Cambia el color del texto
                      ),
                      child:  const Text('Guardar'),
                    ),
                    const SizedBox(width: 10.0),
                    ElevatedButton(
                      // style:  ButtonStyle(textStyle: AppFonts.smallTextStyle),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                      textStyle: MaterialStateProperty.all<TextStyle>(AppFonts.smallTextStyle),
                      backgroundColor: MaterialStateProperty.all<Color>(AppColors.bgPrimaryColor), // Cambia el color de fondo
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Cambia el color del texto
                      ),
                      child: const Text('Cancelar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Estado actual',
                  style:  AppFonts.smallTextStyle.copyWith( fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                ),
                GestureDetector(
                  onTap: () {
                    _showStatusEditor(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _currentStatus,
                        style: AppFonts.smallTextStyle.copyWith(color: AppColors.colorGrayLight),
                      ),
                      const Icon(
                        Icons.edit,
                        color: Colors.yellow,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Divider(
            color: AppColors.colorGrayLight,
            thickness: 1,
          ),
          
          // Seleccion de estados por defecto
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 16, left: 16),
                child: Text('Estados por defecto',
                    style: AppFonts.smallTextStyle.copyWith(
                        fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
              ),
              Column(
                children: List<Widget>.generate(widget.defaultStates.length, (index) {
                  final state = widget.defaultStates[index];
                  final isSelected = index == selectedOptionIndex;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOptionIndex = index;
                        _currentStatus = state;
                        _statusController.text = state;
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
                                ? AppFonts.smallTextStyle
                                    .copyWith(color: AppColors.colorGrayLight)
                                : AppFonts.smallTextStyle
                                    .copyWith(color: AppColors.colorGrayLight),
                          ),
                          if (isSelected)
                            const Icon(Icons.check, color: AppColors.bgYellow),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

