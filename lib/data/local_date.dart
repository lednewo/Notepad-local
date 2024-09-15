import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const stringListKey = 'stringListKey';

class LocalDate {
  static setListaString(List<String> lista) async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    await shared.setStringList(stringListKey, lista);
  }

  static Future<List<String>> getListString() async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    return shared.getStringList(stringListKey) ?? [];
  }
}