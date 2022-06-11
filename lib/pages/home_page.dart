import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_curd/pages/add_employe_page.dart';
import 'package:flutter_curd/pages/employe_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('CURD-APP',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
           IconButton(onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>AddStudentPage()));
           }, icon: Icon(Icons.person,size: 20,))
          ],
        ),
      ),
      body: StudentListPage(),
    );
  }
}
