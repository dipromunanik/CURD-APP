import 'package:flutter/material.dart';
import 'package:flutter_curd/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 final Future<FirebaseApp> _initialize =Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialize,
      builder: (context,snapshot)
    {
      if (snapshot.hasError) {
        print('Something went wrong');
      }
      if (snapshot.connectionState == ConnectionState.done) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        );
      }
      return CircularProgressIndicator();
      },);
  }
}
