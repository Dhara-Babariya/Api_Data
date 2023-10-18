// // // ignore_for_file: use_build_context_synchronously

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:fproject/Activities/AddNotes.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import '../Models/notes_model.dart';
//
// class DisplayNotes extends StatefulWidget {
//   String title, description;
//
//   DisplayNotes({this.title = "", this.description = ''});
//
//   @override
//   State<DisplayNotes> createState() => _DisplayNotesState();
// }
//
// class _DisplayNotesState extends State<DisplayNotes> {
//   List<String> datatitle = [];
//   List<String> datadesc = [];
//
//   getdata() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     datatitle = prefs.getStringList('listtitle') ?? [];
//     datadesc = prefs.getStringList('listdesc') ?? [];
//
//     setState(() {});
//     print(datatitle);
//     print(datadesc);
//   }
//
//   cleardata(int index) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Column(
//             children: [
//               Text('Alert !!'),
//             ],
//           ),
//           content: Text('Are You Sure Delete This note ?'),
//           actions: [
//             TextButton(
//               child: const Text("No"),
//               onPressed: () {
//                 Navigator.of(context).pop(DisplayNotes);
//               },
//             ),
//             Expanded(
//               child: TextButton(
//                 child: const Text("Yes"),
//                 onPressed: () {
//                   setState(() {
//                     datatitle.removeAt(index);
//                     datadesc.removeAt(index);
//                     prefs.setStringList('listtitle', datatitle);
//                     prefs.setStringList('listdesc', datadesc);
//                   });
//                   Navigator.of(context).pop(DisplayNotes);
//                 },
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//
//   List<NotesModel> todos = [];
//
//   @override
//   void initState() {
//     getdata();
//     fetchTodos();
//     String idToDelete = "";
//     Delete(idToDelete);
//     super.initState();
//   }
//
//   Future<void> fetchTodos() async {
//     final response =
//     await http.get(Uri.parse('http://192.168.29.226:8080/v1/notes'));
//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       setState(() {
//         todos = data.map((todo) => NotesModel.fromJson(todo)).toList();
//         print('successfully');
//       });
//     } else {
//       print('Failed to load data');
//       // throw Exception('Failed to load data');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: Icon(Icons.arrow_back_ios_outlined,
//           color: Colors.deepPurple.shade900,),
//         backgroundColor: Colors.deepPurple[200],
//         title: Text(
//           'Your Notes',
//           style: TextStyle(
//             color: Colors.deepPurple[900],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => AddNotes()));
//         },
//         child: Icon(Icons.add, size: 40, color: Colors.deepPurple.shade50),
//         backgroundColor: Colors.deepPurple.shade900,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(bottom: 10),
//           ),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: todos.length,
//                     itemBuilder: (context, index) {
//                       final todo = todos[index];
//                       return Slidable(
//                         startActionPane: ActionPane(
//                           motion: ScrollMotion(),
//                           children: [
//                             SlidableAction(
//                               onPressed: (c) {
//                                 Delete(todos[index].id.toString());
//                                 setState(() {});
//                               },
//                               icon: Icons.delete,
//
//                               backgroundColor: Colors.red,
//                               autoClose: true,
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                           ],
//                         ),
//                         endActionPane: ActionPane(
//                           motion: ScrollMotion(),
//                           children: [
//                             SlidableAction(
//                               onPressed: (context) {
//                                 onEdit(index);
//                               },
//                               icon: Icons.edit,
//                               backgroundColor: Colors.deepPurple.shade900,
//                               autoClose: true,
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                           ],
//                         ),
//                         child: Container(
//                           width: 400,
//                           decoration: BoxDecoration(
//                               color: Colors.deepPurple.shade50,
//                               borderRadius: BorderRadius.all(
//                                   Radius.circular(50)),
//                               border: Border.all(
//                                   width: 1.5, color: Colors.deepPurple.shade900)
//                           ),
//                           margin: EdgeInsets.all(10),
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 20),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: RichText(
//                                     text: TextSpan(
//                                       text: 'Id : ',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                         color: Colors.deepPurple.shade900,
//                                       ),
//                                       children: [
//                                         TextSpan(
//                                             text: todo.id.toString(),
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 color: Colors.deepPurple
//                                                     .shade600
//                                             )),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: RichText(
//                                     text: TextSpan(
//                                       text: 'Title : ',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                         color: Colors.deepPurple.shade900,
//                                       ),
//                                       children: [
//                                         TextSpan(
//                                             text: todo.title.toString(),
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 color: Colors.deepPurple
//                                                     .shade600
//                                             )),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 8, right: 8, top: 8, bottom: 13),
//                                   child: RichText(
//                                     text: TextSpan(
//                                       text: 'Description : ',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                         color: Colors.deepPurple.shade900,
//                                       ),
//                                       children: [
//                                         TextSpan(
//                                             text: todo.description.toString(),
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 color: Colors.deepPurple
//                                                     .shade600
//                                             )),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                     shrinkWrap: true,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void onEdit(int index) async {
//     String editedTitle = '';
//     String editedDesc = '';
//
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         String currentTitle = datatitle[index];
//         String currentDesc = datadesc[index];
//
//         TextEditingController editTitleController =
//         TextEditingController(text: currentTitle);
//         TextEditingController editDescController =
//         TextEditingController(text: currentDesc);
//
//         return AlertDialog(
//           title: const Text("Edit Note"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: editTitleController,
//                 decoration: InputDecoration(labelText: 'Title'),
//               ),
//               TextField(
//                 controller: editDescController,
//                 decoration: InputDecoration(labelText: 'Description'),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               child: const Text("Save"),
//               onPressed: () {
//                 editedTitle = editTitleController.text;
//                 editedDesc = editDescController.text;
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//
//     if (editedTitle != null && editedDesc != null) {
//       setState(() {
//         datatitle[index] = editedTitle;
//         datadesc[index] = editedDesc;
//         saveValue();
//       });
//     }
//   }
//
//   void saveValue() async {
//     final SharedPreferences pref = await SharedPreferences.getInstance();
//     pref.setStringList('listtitle', datatitle);
//     pref.setStringList('listdesc', datadesc);
//   }
//
//
//   void Delete(String id) async {
//     var url = Uri.parse('http://192.168.29.226:8080/v1/notes/$id');
//     var response = await http.delete(url);
//     if (response.statusCode == 200) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(id)));
//       setState(() {});
//     }
//   }
// }
//
//

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fproject/Activities/AddNotes.dart';
import 'package:fproject/Activities/edit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Models/notes_model.dart';

class DisplayNotes extends StatefulWidget {
  String title, description;

  DisplayNotes({this.title = "", this.description = ''});

  @override
  State<DisplayNotes> createState() => _DisplayNotesState();
}

class _DisplayNotesState extends State<DisplayNotes> {
  // List<String> datatitle = [];
  // List<String> datadesc = [];
  //
  // getdata() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   datatitle = prefs.getStringList('listtitle') ?? [];
  //   datadesc = prefs.getStringList('listdesc') ?? [];
  //
  //   setState(() {});
  //   print(datatitle);
  //   print(datadesc);
  // }

  // cleardata(int index) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Column(
  //           children: [
  //             Text('Alert !!'),
  //           ],
  //         ),
  //         content: Text('Are You Sure Delete This note ?'),
  //         actions: [
  //           TextButton(
  //             child: const Text("No"),
  //             onPressed: () {
  //               Navigator.of(context).pop(DisplayNotes);
  //             },
  //           ),
  //           Expanded(
  //             child: TextButton(
  //               child: const Text("Yes"),
  //               onPressed: () {
  //                 setState(() {
  //                   datatitle.removeAt(index);
  //                   datadesc.removeAt(index);
  //                   prefs.setStringList('listtitle', datatitle);
  //                   prefs.setStringList('listdesc', datadesc);
  //                 });
  //                 Navigator.of(context).pop(DisplayNotes);
  //               },
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  List<NotesModel> todos = [];

  @override
  void initState() {
    fetchTodos();
    String idToDelete = "";
    super.initState();
  }

  // Future<List<NotesModel>> getData() async {
  //   final response =
  //   await http.get(Uri.parse('http://192.168.29.226:8080/v1/notes'));
  //   var data = jsonDecode(response.body.toString());
  //   if (response.statusCode == 200) {
  //     final list = data as List;
  //     todos = list.map((e) => NotesModel.fromJson(e)).toList();
  //     return todos;
  //   } else {
  //     return todos;
  //   }
  // }
  Future<void> fetchTodos() async {
    final response =
        await http.get(Uri.parse('http://192.168.29.226:8080/v1/notes'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        todos = data.map((todo) => NotesModel.fromJson(todo)).toList();
        print('successfully');
      });
    } else {
      print('Failed to load data');
      // throw Exception('Failed to load data');
    }
  }

  void refreshData() {
    fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.deepPurple[200],
        title: Text(
          'Your Notes',
          style: TextStyle(
            color: Colors.deepPurple[900],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNotes()));
        },
        child: Icon(Icons.add, size: 40, color: Colors.deepPurple.shade50),
        backgroundColor: Colors.deepPurple.shade900,
      ),
      body:
          // todos.isEmpty
          //     ? Center(
          //   child: Text(
          //     'No items',
          //     style: TextStyle(fontSize: 20),
          //   ),
          // )
          //     :
          Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return Slidable(
                        startActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (c) {
                                Delete(todos[index].id.toString());
                                setState(() {});
                              },
                              icon: Icons.delete,
                              backgroundColor: Colors.red,
                              autoClose: true,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Edit(
                                          jsondata: todos[index],
                                          refreshCallback: refreshData,
                                            )));
                                setState(() {});
                              },
                              icon: Icons.edit,
                              backgroundColor: Colors.deepPurple.shade900,
                              autoClose: true,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ],
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Container(
                            width: 400,
                            decoration: BoxDecoration(
                                color: Colors.deepPurple.shade50,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                border: Border.all(
                                    width: 1.5,
                                    color: Colors.deepPurple.shade900)),
                            margin: EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Id : ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.deepPurple.shade900,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: todo.id.toString(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors
                                                      .deepPurple.shade600)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Title : ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.deepPurple.shade900,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: todo.title.toString(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors
                                                      .deepPurple.shade600)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8, top: 8, bottom: 13),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Description : ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.deepPurple.shade900,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: todo.description.toString(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors
                                                      .deepPurple.shade600)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    shrinkWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //
  // void onEdit(int index) async {
  //   String editedTitle = '';
  //   String editedDesc = '';
  //
  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       String currentTitle = datatitle[index];
  //       String currentDesc = datadesc[index];
  //
  //       TextEditingController editTitleController =
  //           TextEditingController(text: currentTitle);
  //       TextEditingController editDescController =
  //           TextEditingController(text: currentDesc);
  //
  //       return AlertDialog(
  //         title: const Text("Edit Note"),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextField(
  //               controller: editTitleController,
  //               decoration: InputDecoration(labelText: 'Title'),
  //             ),
  //             TextField(
  //               controller: editDescController,
  //               decoration: InputDecoration(labelText: 'Description'),
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             child: const Text("Save"),
  //             onPressed: () {
  //               editedTitle = editTitleController.text;
  //               editedDesc = editDescController.text;
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  //
  //   if (editedTitle != null && editedDesc != null) {
  //     setState(() {
  //       datatitle[index] = editedTitle;
  //       datadesc[index] = editedDesc;
  //       saveValue();
  //     });
  //   }
  // }
  //
  // void saveValue() async {
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setStringList('listtitle', datatitle);
  //   pref.setStringList('listdesc', datadesc);
  // }

  void Delete(String id) async {
    var url = Uri.parse('http://192.168.29.226:8080/v1/notes/$id');
    var response = await http.delete(url);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(id)));
      fetchTodos();
    }
  }
}

