import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class IconPicker extends StatefulWidget {
  const IconPicker({super.key, required this.onChanged});

  final Function(String) onChanged;

  @override
  State<IconPicker> createState() => _IconPickerState();
}

class _IconPickerState extends State<IconPicker> {
  IconData? selectedIcon;

  _pickIcon() async {
    IconData? icon = await showIconPicker(
      context,
      adaptiveDialog: true,
      showTooltips: false,
      showSearchBar: true,
      iconPackModes: [IconPack.material],
    );

    if (icon != null) {
      selectedIcon = icon;
      widget.onChanged(jsonEncode({
        "codePoint": icon.codePoint,
        "fontFamily": icon.fontFamily
      }));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed: _pickIcon,
      child: selectedIcon != null
          ? Icon(IconData(selectedIcon!.codePoint, fontFamily: selectedIcon!.fontFamily))
          : const Text('Pick icon'),
    );
  }
}
