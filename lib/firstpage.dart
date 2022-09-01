import 'package:contacts/formpage.dart';
import 'package:contacts/viewpage.dart';
import 'package:flutter/material.dart';

class firstpage extends StatefulWidget {
  const firstpage({Key? key}) : super(key: key);

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return viewpage();
            },));
      },
      child: Icon(Icons.add,size: 40),),
    );
  }
}
