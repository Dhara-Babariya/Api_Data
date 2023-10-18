import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fproject/Activities/DisplayNote.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

TextEditingController _title = TextEditingController();
TextEditingController _description = TextEditingController();


class _AddNotesState extends State<AddNotes> {
  setdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final datatitle = prefs.getStringList('listtitle') ?? [];
    datatitle.add(_title.text);
    prefs.setStringList('listtitle', datatitle);

    final datadesc = prefs.getStringList('listdesc') ?? [];
    datadesc.add(_description.text);
    prefs.setStringList('listdesc', datadesc);
  }

  @override
  void initState() {
    // TODO: implement initState
    _title.clear();
    _description.clear();
    super.initState();
  }

  void addData(String title, description) async {
    final response = await http.post(
        Uri.parse("http://192.168.29.226:8080/v1/notes"),
        body: jsonEncode(
            {'title': _title.text, 'description': _description.text}));
    if (response.statusCode == 201) {
      print('Data added');
      print(response.body);
    } else {
      print('Data not added');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.deepPurple.shade900, onPressed: () {
            Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_outlined,)
        ),
        backgroundColor: Colors.deepPurple[200],
        title: Text('Write Notes',
        style: TextStyle(
          color: Colors.deepPurple[900],
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 250,
          decoration: BoxDecoration(
            border: Border.all(width: 1,color: Colors.deepPurple),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text('Title : ',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.deepPurple[900],
                      ),),
                    ),
                    SizedBox(width: 40),
                    Expanded(
                      child: TextFormField(
                        controller: _title,
                        style: TextStyle(
                          color: Colors.deepPurple[900],
                        ),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,color: Colors.deepPurple.shade900,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),

                          labelText: 'Title',
                          labelStyle: TextStyle(
                            color: Colors.deepPurple[900],
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,color: Colors.deepPurple.shade900,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            ),
                          // hintText: "title",
                          suffixIcon: IconButton(
                            onPressed: () {

                              _title.clear();
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.deepPurple[900],
                            ),
                          ),
                        ),

                        ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Row(
                    children: [
                      Text('Description : ',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.deepPurple[900],
                        ),),
                      // SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _description,
                          style: TextStyle(
                            color: Colors.deepPurple[900],
                          ),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,color: Colors.deepPurple.shade900,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),

                            labelText: 'Description',
                            labelStyle: TextStyle(
                              color: Colors.deepPurple[900],
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,color: Colors.deepPurple.shade900,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {

                                _title.clear();
                              },
                              icon: Icon(
                                Icons.close,
                                color: Colors.deepPurple[900],
                              ),
                            ),
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>( Colors.deepPurple.shade100),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(color: Colors.deepPurple.shade900)
                            )
                        )
                    ),
                    onPressed: () {
                      setdata();
                      addData(_title.text.toString(), _description.text.toString());
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return DisplayNotes(
                            description: _description.text,
                            title: _title.text,
                          );
                        }),
                            (route) => false,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text('Submit',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.deepPurple[900],
                      ),),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}













// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class AddData extends StatefulWidget {
//   const AddData({Key? key}) : super(key: key);
//
//   @override
//   State<AddData> createState() => _AddDataState();
// }
//
// class _AddDataState extends State<AddData> {
//   final _formkey = GlobalKey<FormState>();
//   String title = "";
//   String description = "";
//   TextEditingController titleC = TextEditingController();
//   TextEditingController descriptionC = TextEditingController();
//
//   void addData() async {
//     final response = await http.post(
//         Uri.parse("http://192.168.29.37:8080/v1/notes"),
//         body: jsonEncode(
//             {'title': titleC.text, 'description': descriptionC.text}));
//     if (response.statusCode == 201) {
//       print('Data added');
//       print(response.body);
//     } else {
//       print('Data not added');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0.0,
//         title: const Text(
//           'ADD DATA',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.blue,
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formkey,
//           child: Container(
//             padding: const EdgeInsets.fromLTRB(35, 35, 35, 0),
//             child: Column(
//               children: [
//                 TextFormField(
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Enter title';
//                     } else {
//                       return null;
//                     }
//                   },
//                   controller: titleC,
//                   decoration: InputDecoration(
//                       labelText: 'Title',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       )),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 17),
//                   child: TextFormField(
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Enter description';
//                       } else {
//                         return null;
//                       }
//                     },
//                     controller: descriptionC,
//                     decoration: InputDecoration(
//                         labelText: 'Description',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         )),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 17),
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       maximumSize: const Size(100, 60),
//                       textStyle: const TextStyle(fontSize: 20),
//                     ),
//                     child: const Text('Submit'),
//                     onPressed: () {
//                       setState(() {
//                         title = titleC.text;
//                         description = descriptionC.text;
//                         Navigator.pop(context);
//                         addData();
//                       });
//                     },
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
