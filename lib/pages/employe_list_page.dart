import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_curd/pages/update_employe_page.dart';

class StudentListPage extends StatefulWidget {
  const StudentListPage({Key? key}) : super(key: key);

  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  final Stream<QuerySnapshot> employeStream =
      FirebaseFirestore.instance.collection('Employe').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: employeStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedoc = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedoc.add(a);
            a['id'] = document.id;
          }).toList();

          return Column(
            children: [
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.center,
                  child: Text(
                'EMPLOYE LIST',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              )),
              const SizedBox(height: 5),
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 20.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Table(
                    border: TableBorder.all(),
                    columnWidths: const <int, TableColumnWidth>{
                      1: FixedColumnWidth(140)
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(children: [
                        TableCell(
                            child: Container(
                          color: Colors.green,
                          child: Center(
                            child: Text(
                              'Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                          ),
                        )),
                        TableCell(
                            child: Container(
                          color: Colors.green,
                          child: Center(
                            child: Text(
                              'Email',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                          ),
                        )),
                        TableCell(
                            child: Container(
                          color: Colors.green,
                          child: Center(
                            child: Text(
                              'Action',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                          ),
                        ))
                      ]),
                      for (var i = 0; i < storedoc.length; i++) ...[
                        TableRow(children: [
                          TableCell(
                              child: Center(
                            child: Text(
                              storedoc[i]['name'],
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          )),
                          TableCell(
                              child: Center(
                            child: Text(
                              storedoc[i]['email'],
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          )),
                          TableCell(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UpdateStudent(
                                                id: storedoc[i]['id'])));
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.deepOrangeAccent,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    deleteUser(storedoc[i]['id']);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.deepOrangeAccent,
                                  )),
                            ],
                          ))
                        ]),
                      ]
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  CollectionReference employe =
      FirebaseFirestore.instance.collection('Employe');

  Future<void> deleteUser(id) {
    return employe
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((e) => print('Failed to Delete user: $e'));
  }
}
