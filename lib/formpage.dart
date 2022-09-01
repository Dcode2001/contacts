import 'package:contacts/DbHelper.dart';
import 'package:contacts/viewpage.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class formpage extends StatefulWidget {

  int? a;
  Map? m;


  formpage({required this.a, this.m});

  @override
  State<formpage> createState() => _formpageState();
}

class _formpageState extends State<formpage> {

  TextEditingController tname = TextEditingController();
  TextEditingController tcontact = TextEditingController();
  Database? db;

  @override
  void initState() {

      super.initState();
       DbHelper().createDatabase().then((value) {
        db = value;

       });

       if(widget.a==1)
         {
           tname.text = widget.m!['name'];
           tcontact.text = widget.m!['contact'];
         }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Contact"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(children: [
          SizedBox(height:15,),
          TextField(
            controller: tname,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            labelText:"Enter Name",
            prefixIcon: Icon(Icons.account_circle_rounded),
            ),
          ),

          SizedBox(height:15,),

          TextField(
            controller: tcontact,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              labelText: "Enter Mobile Number",

              prefixIcon: Icon(Icons.phone)
              )
          ),

          // SizedBox(height:15,),

          Center(
            child: (widget.a==0) ? ElevatedButton(onPressed: () async{

              String name = tname.text;
              String contact = tcontact.text;

              String qry = "insert into Test (name,contact) values('$name','$contact')";

              int  a = await db!.rawInsert(qry);
              print(a);

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return viewpage();
              },));
            }, child: Text("Save",style: TextStyle(fontSize: 20),)) : ElevatedButton(onPressed: () async{

              String name = tname.text;
              String contact = tcontact.text;

              int id = widget.m!['id'];

              String qry = "update Test set name='$name',contact='$contact' where id = '$id'";

               db!.rawUpdate(qry);

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return viewpage();
              },));
            }, child: Text("Update",style: TextStyle(fontSize: 20),))
          )
        ],),
        
      ),
    );
  }
}
