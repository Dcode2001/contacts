import 'package:contacts/firstpage.dart';
import 'package:contacts/viewpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: viewpage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.green),
  ));
}
