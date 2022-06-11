import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({Key? key}) : super(key: key);

  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formkey = GlobalKey<FormState>();

  var name = "";
  var email = "";
  var password = "";

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.grey,
          backgroundColor: Colors.pink,
          title: const Text(
            'ADD-Employe',
            style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
          ),
        ),
        body: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
              child: Expanded(
                child: ListView(
                  children: [
                    Lottie.network('https://assets7.lottiefiles.com/packages/lf20_4ee6sqxt.json'),
                    TextFormField(
                      autofocus: false,
                      decoration: const InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(fontSize: 18),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.pink, fontSize: 15)),
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      autofocus: false,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(fontSize: 18),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.pink, fontSize: 15)),
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Container(
                      child: TextFormField(
                        autofocus: false,
                        decoration: const InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(fontSize: 18),
                            border: OutlineInputBorder(),
                            errorStyle:
                                TextStyle(color: Colors.pink, fontSize: 15)),
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter password';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 2),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: (){
                        clearText();
                      }, child: Text('Reset',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20))),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: (){
                        if(_formkey.currentState!.validate()){
                          setState(() {
                            name =nameController.text;
                            email=emailController.text;
                            password=passwordController.text;
                            addUser();
                            clearText();
                          });
                        }
                      },
                      child: Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                              'REGISTRATION',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(1, 2),
                              blurRadius: 2,
                              spreadRadius: 1.0,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
  CollectionReference employe =FirebaseFirestore.instance.collection('Employe');

  Future<void> addUser() {
    return employe
        .add({'name':name,'email':email,'password':password})
        .then((value) => print('User Added'))
        .catchError((e)=>print('Failed to Add user: $e'));
  }

  void clearText() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }
}
