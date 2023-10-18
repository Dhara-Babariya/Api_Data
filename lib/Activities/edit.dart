import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/notes_model.dart';

class Edit extends StatefulWidget {
  NotesModel jsondata;

  var refreshCallback;
  Edit({super.key, required this.jsondata, required this.refreshCallback});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleC = TextEditingController();
  late TextEditingController descriptionC = TextEditingController();


  void editData() async {
    final response = await http.patch(
        Uri.parse("http://192.168.29.226:8080/v1/notes/${widget.jsondata.id}"),
        body: jsonEncode(<String, dynamic>{
          'title': titleC.text,
          'description': descriptionC.text
        }));
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      print('Data added');
      print(data);

      widget.refreshCallback();
    } else {
      print('Data not added');
    }
  }



  @override
  void initState() {
    titleC.text = widget.jsondata.title!;
    descriptionC.text = widget.jsondata.description!;
    print(widget.jsondata.toJson());
    // editData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 10,
          leading: IconButton(
              color: Colors.deepPurple.shade900, onPressed: () {
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_ios_outlined,)
          ),
          backgroundColor: Colors.deepPurple[200],
          title: Text('Edit Notes',
            style: TextStyle(
              color: Colors.deepPurple[900],
            ),),
        ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(width: 1,color: Colors.deepPurple.shade900),
              ),
              padding: const EdgeInsets.fromLTRB(35, 35, 35, 0),
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter title';
                      } else {
                        return null;
                      }
                    },
                    controller: titleC,
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
                      suffixIcon: IconButton(
                        onPressed: () {
                          titleC.clear();
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.deepPurple[900],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 17),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter description';
                        } else {
                          return null;
                        }
                      },
                      controller: descriptionC,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,color: Colors.deepPurple.shade900,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),

                        labelText: 'Descripion',
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
                            descriptionC.clear();
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.deepPurple[900],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Container(
                      height: 50,
                      width: 250,
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
                        onPressed: () async {

                            if (_formKey.currentState!.validate()) {
                              editData();
                              Navigator.pop(context);

                            }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text('Submit',
                            style:  TextStyle(
                              fontSize: 22,
                              color: Colors.deepPurple,
                            ),),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}