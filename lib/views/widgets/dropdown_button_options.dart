import 'package:flutter/material.dart';
import 'package:picspeak_front/views/interfaces/dropdown_object.dart';

import '../../config/theme/app_text_style.dart';

class DropdownButtonOptions extends StatefulWidget {
  final List<DropdownObject> myObjectList;
  final ValueNotifier<int?>
      selectedValueNotifier; // Notificador del valor seleccionado

  const DropdownButtonOptions({
    Key? key,
    required this.myObjectList,
    required this.selectedValueNotifier,
  }) : super(key: key);

  @override
  State<DropdownButtonOptions> createState() => _DropdownButtonOptionsState();
}

class _DropdownButtonOptionsState extends State<DropdownButtonOptions> {
  late int? _dropdownValue;

  @override
  void initState() {
    super.initState();
    _dropdownValue = null;
    widget.selectedValueNotifier.addListener(_valueNotifierListener);
  }

  void _valueNotifierListener() {
    setState(() {
      _dropdownValue = widget.selectedValueNotifier.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<DropdownObject>(
      hint: const Text("Seleccionar"),
      isExpanded: true,
      borderRadius: BorderRadius.circular(5),
      style: AppTextStyles
          .inputLightTextStyle, // Asegúrate de definir AppTextStyles
      onChanged: (DropdownObject? selectedObject) {
        widget.selectedValueNotifier.value = selectedObject?.id;
      },
      value: widget.myObjectList.firstWhere((obj) => obj.id == _dropdownValue,
          orElse: () => widget.myObjectList.first),
      items: widget.myObjectList.map<DropdownMenuItem<DropdownObject>>(
        (DropdownObject obj) {
          return DropdownMenuItem<DropdownObject>(
            value: obj,
            child: Text(obj.name),
          );
        },
      ).toList(),
    );
  }
}
