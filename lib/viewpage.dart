import 'package:contacts/DbHelper.dart';
import 'package:contacts/formpage.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class viewpage extends StatefulWidget {
  const viewpage({Key? key}) : super(key: key);

  @override
  State<viewpage> createState() => _viewpageState();
}

class _viewpageState extends State<viewpage> {
  // List<Map<String, Object?>> l = List.empty(growable: true);
  Database? db;
  bool status = false;

  List<Map> temp = [];
  List<Map> rem = [];
  bool search = false;

  List<Color> colorlist = [
    Colors.blueGrey.shade200,
    Colors.red.shade200,
    Colors.green.shade200,
    Colors.blue.shade200,
    Colors.lime.shade200,
    Colors.orange.shade200,
    Colors.brown.shade200,
    Colors.purple.shade200,
    Colors.yellow.shade200,
    Colors.indigo.shade200,
    Colors.redAccent.shade200,
    Colors.orangeAccent.shade200,
    Colors.green.shade400,
    Colors.grey.shade200,
    Colors.teal.shade200,
    Colors.pinkAccent.shade200,
    Colors.blueGrey.shade200,
    Colors.red.shade200,
    Colors.green.shade200,
    Colors.blue.shade200,
    Colors.lime.shade200,
    Colors.orange.shade200,
    Colors.brown.shade200,
    Colors.purple.shade200,
    Colors.yellow.shade200,
    Colors.indigo.shade200,
    Colors.redAccent.shade200,
    Colors.orangeAccent.shade200,
    Colors.green.shade400,
    Colors.grey.shade300,
    Colors.teal.shade200,
    Colors.pinkAccent.shade200,
  ];

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    db = await DbHelper().createDatabase();

    String qry = "select * from Test";

    List<Map<String, Object?>> l1 = await db!.rawQuery(qry);

    temp = l1;
    return l1;
    /*l.addAll(l1);

    status = true;
    setState(() {
      print(l);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: search
          ? AppBar(
          title: TextField(
            onChanged: (value) {
              // print(value);

              // List<Map> conct = widget.;
              rem = [];
              if (value.isEmpty) {
                rem = temp;
              } else {
                for (int i = 0; i < temp.length; i++) {
                  if (temp[i]['name']
                      .toString()
                      .toLowerCase()
                      .contains(value.toLowerCase()) ||
                      temp[i]['contact'].toString().contains(value)) {
                    rem.add(temp[i]);
                  };
                }
              }
              setState(() {});
            },
            autofocus: true,
            cursorColor: Colors.black,
            // decoration: InputDecoration(
            //   prefix:
            // ),
          ),
          leading: IconButton(
              onPressed: () {
                // setState(() {
                search = false;
                rem = [];
                setState(() {});
                // });
              },
              icon: Icon(Icons.arrow_back)))
          : AppBar(
        title: Text("Contact Page"),
        actions: [
          IconButton(
              onPressed: () {
                  search = true;
                  rem = temp;
                  setState(() {});
              },
              icon: Icon(Icons.search_rounded))
        ],
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<Map<String, Object?>> l = snapshot.data as List<Map<String, Object?>>;

              l = List.from(l);
              l.sort((a, b) => a['name'].toString().compareTo(b['name'].toString()),);

              rem = List.from(rem);
              rem.sort((a, b) => a['name'].toString().compareTo(b['name'].toString()),);

              return search ? (l.length > 0)
                  ? ListView.builder(
                itemCount: rem.length,
                itemBuilder: (context, index) {
                  Map m = rem[index];
                  return ListTile(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(
                            builder: (context) {
                              return formpage(a: 1, m: m);
                            },
                          ));
                    },

                    onLongPress: () {
                      showDialog(
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Delete"),
                            content: Text(
                                "Delete this contact? \n\nAre You Sure To Delete ${m['name']} Permantally?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600))),
                              TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);

                                    int id = m['id'];

                                    String qry =
                                        "DELETE FROM Test WHERE id = '$id'";

                                    await db!.rawDelete(qry);

                                    setState(() {});
                                  },
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red),
                                  )),
                            ],
                          );
                        },
                        context: context,
                      );
                    },
                    leading: Container(
                      height: 55,
                      width: 55,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: colorlist[index],
                          shape: BoxShape.circle),
                      child: Text("${m['name'].toString().split("")[0]}",style: TextStyle(fontSize: 20,fontWeight:FontWeight.w600)),
                    ),
                    title: Text("${m['name']}"),
                    subtitle: Text("${m['contact']}"),
                    // trailing: Icon(Icons.edit),
                  );
                },
              )
                  : Center(child: Text("No Data Found.....")) : (l.length > 0)
                  ? ListView.builder(
                itemCount: l.length,
                itemBuilder: (context, index) {
                  Map m = l[index];
                  return ListTile(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(
                            builder: (context) {
                              return formpage(a: 1, m: m);
                            },
                          ));
                    },

                    onLongPress: () {
                      showDialog(
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Delete"),
                            content: Text(
                                "Delete this contact? \n\nAre You Sure To Delete ${m['name']} Permantally?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600))),
                              TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);

                                    int id = m['id'];

                                    String qry =
                                        "DELETE FROM Test WHERE id = '$id'";

                                    await db!.rawDelete(qry);

                                    setState(() {});
                                  },
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red),
                                  )),
                            ],
                          );
                        },
                        context: context,
                      );
                    },
                    leading: Container(
                      height: 55,
                      width: 55,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: colorlist[index],
                          shape: BoxShape.circle),
                      child: Text("${m['name'].toString().split("")[0]}",style: TextStyle(fontSize: 20,fontWeight:FontWeight.w600),),
                    ),
                    title: Text("${m['name']}"),
                    subtitle: Text("${m['contact']}"),
                    // trailing: Icon(Icons.edit),
                  );
                },
              )
                  : Center(child: Text("No Data Found....."));
            } else {
              return Center(child: Text("No Data Hear..."));
            }
          }
          return Center(child: CircularProgressIndicator());
        },
        future: getData(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return formpage(a: 0);
            },
          ));
        },
        child: Icon(Icons.add, size: 40),
      ),
    ), onWillPop: goback);
  }

  Future<bool> goback()
  {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return viewpage();
      },));
      return Future.value();
  }
}
