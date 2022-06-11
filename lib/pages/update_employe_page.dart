import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UpdateStudent extends StatefulWidget {

  final String id;
  UpdateStudent({Key? key,required this.id}) : super(key: key);

  @override
  _UpdateStudentState createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {

  final _formKey = GlobalKey<FormState>();

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
        title: Text('Update',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      ),
      body: Form(
        key: _formKey,
        child: FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
    future: FirebaseFirestore.instance
    .collection('Employe')
    .doc(widget.id)
    .get(),
    builder: (_,snapshot){
      if(snapshot.hasError){
        print('Something went worng');
    }
      if(snapshot.connectionState==ConnectionState.waiting){

        return Center(child: CircularProgressIndicator());
    }
      var data= snapshot.data!.data();
      var name =data!['name'];
      var email =data['email'];
      var password =data['password'];
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
        child: ListView(
          children: [
            Lottie.network('https://assets7.lottiefiles.com/packages/lf20_gesnvxtv.json'),
            TextFormField(
              autofocus: false,
              initialValue: name,
              decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(fontSize: 18),
                  border: OutlineInputBorder(),
                  errorStyle:
                  TextStyle(color: Colors.pink, fontSize: 15)),
              onChanged: (value)=>name=value,
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
              initialValue: email,
              decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(fontSize: 18),
                  border: OutlineInputBorder(),
                  errorStyle:
                  TextStyle(color: Colors.pink, fontSize: 15)),
              onChanged: (value)=>email=value,
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
                initialValue: password,
                decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(fontSize: 18),
                    border: OutlineInputBorder(),
                    errorStyle:
                    TextStyle(color: Colors.pink, fontSize: 15)),
                onChanged: (value)=>password=value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter password';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      updateUser(widget.id,name,email,password);
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                          'UPDATE',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(1, 2),
                          blurRadius: 2,
                          spreadRadius: 1.0,
                        )
                      ],
                    ),
                  ),
                ),

                InkWell(
                  onTap: (){
                   clearText();
                  },
                  child: Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                          'RESET',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                    height: 40,
                    width: 100,
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
            )
          ],
        ),
      );
    },
    )

      ),
    );
  }
  CollectionReference employe =FirebaseFirestore.instance.collection('Employe');

  Future<void> updateUser(id,name,email,password) {
    return employe
        .doc(id)
        .update({'name':name,'email':email,'password':password})
        .then((value) => print('User data updated'))
        .catchError((e)=>print('User data failed updated$e'));
  }

  void clearText() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }
}
