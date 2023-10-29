import 'package:flutter/material.dart';
import 'package:picspeak_front/config/theme/app_text_style.dart';

class DropdownButtonOptions extends StatefulWidget {
  final List<String> myObjectList; // Cambia MyObject por el tipo de tus objetos

  const DropdownButtonOptions({
    Key? key,
    required this.myObjectList,
  }) : super(key: key);

  @override
  State<DropdownButtonOptions> createState() => _DropdownButtonOptionsState();
}

class _DropdownButtonOptionsState extends State<DropdownButtonOptions> {
  late String? _dropdownValue;

  @override
  void initState() {
    super.initState();
    _dropdownValue = null; // Inicializa el valor como nulo para mostrar el hint
  }

  @override
  Widget build(BuildContext context) {
    // Accede a la lista de objetos a través de widget.myObjectList

    return DropdownButton<String>(
      hint: const Text("Seleccionar"),
      isExpanded: true,
      borderRadius: BorderRadius.circular(5),
      style: AppTextStyles.inputLightTextStyle,
      onChanged: (String? value) {
        setState(() {
          _dropdownValue = value;
        });
      },
      value: _dropdownValue,
      items: widget.myObjectList.map<DropdownMenuItem<String>>((String text) {
        return DropdownMenuItem<String>(
          value: text,
          child: Text(text),
        );
      }).toList(),
    );
  }
}