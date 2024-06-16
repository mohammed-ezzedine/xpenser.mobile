import 'dart:convert';

import 'package:flutter/cupertino.dart';

class ExpenseCategory {
  final String id;
  final String name;
  final String icon;

  const ExpenseCategory({
    required this.id,
    required this.name,
    required this.icon
  });

  factory ExpenseCategory.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "id": String id,
        "name": String name,
        "icon": String icon,
      } => ExpenseCategory(id: id, name: name, icon: icon),
      _ => throw Exception("Failed to parse the value of an expense category")
    };
  }

  IconData iconData() {
    var metadata = jsonDecode(icon) as Map<String, dynamic>;
    return IconData(metadata["codePoint"] as int, fontFamily: metadata["fontFamily"]);
  }
}