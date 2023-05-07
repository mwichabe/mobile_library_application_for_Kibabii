import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_library/ContentPage/Books/History.dart';
import 'package:mobile_app_library/ContentPage/Books/borroweBooks.dart';
import 'package:mobile_app_library/ContentPage/Books/favouriteBooks.dart';
import 'package:mobile_app_library/ContentPage/HomePage.dart';
import 'package:mobile_app_library/logins/loginScreen.dart';
import 'package:mobile_app_library/logins/resetPassword.dart';
import 'package:mobile_app_library/logins/signUp.dart';


import 'logins/deleteAcc.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    theme: ThemeData.light(),
    //darkTheme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login': (context) => LoginScreen(),
      'resetPass': (context)=> const ResetPassword(),
      'trial': (context)=> Content_Home_Page(),
      'signUp' : (context)=> const SignUpScreen(),
      'deleteAcc': (context)=> const DeleteAccountPermanently(),
      //home page
      'search' : (context)=> SearchPage(),
      'notification': (context)=> NotificationsPage(),
      'profile': (context)=> ProfilePage(),
      'favouriteBooks': (context)=>const KibabiiLibraryPage(),
      'borrowedBooks': (context)=> BorrowedList(),
      'historyOfBooks': (context)=>NewBooks()


    },
  ));
}