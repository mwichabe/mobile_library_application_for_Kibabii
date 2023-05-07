import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/authentication.dart';

class SignUpScreen extends StatefulWidget {

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _schoolController = TextEditingController();

  final TextEditingController _programmeController = TextEditingController();

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _surNameController = TextEditingController();

  final TextEditingController _registrationNumberController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  //final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _confirmPassController = TextEditingController();

  //form key
  final _formKey = GlobalKey<FormState>();

  //firebase
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      TextFormField(
                        controller: _schoolController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          hintText: 'Faculty (SCAI,FEES...)',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value)
                        {
                          if(value!.isEmpty){
                            return ("Required");
                          }
                        },

                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _programmeController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          hintText: 'Department',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value)
                        {
                          if(value!.isEmpty){
                            return ("Required");
                          }
                          //regEx for Department
                          if(!RegExp("^[A-Z][a-z]+( [A-Z][a-z]+)" ).hasMatch(value))
                            {
                              return("Enter a valid department name in Kibabii University");
                            }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _firstNameController,
                        keyboardType: TextInputType.name,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: 'First name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value)
                        {
                          if(value!.isEmpty){
                            return ("Required");
                          }
                          //regEx for First name
                          if(!RegExp("^[A-Z][a-z]").hasMatch(value))
                          {
                            return("First letter should be capital");
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _surNameController,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          hintText: 'Sur name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value)
                        {
                          if(value!.isEmpty){
                            return ("Required");
                          }
                          if(!RegExp("^[A-Z][a-z]").hasMatch(value))
                          {
                            return("First letter should be capital");
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _registrationNumberController,
                        keyboardType: TextInputType.text,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: 'Registration number',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value)
                        {
                          if(value!.isEmpty){
                            return ("Required");
                          }
                                                  },
                      ),
                      //const SizedBox(height: 20),
                      /*TextFormField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'Phone number',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value)
                        {
                          if(value!.isEmpty){
                            return ("Required");
                          }
                        },
                      ),*/
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: 'School email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return ("Email field cannot be empty.");
                          }
                          //regEx for email validator
                          if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)){return("Please Enter a valid school email");}
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value){
                          RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!$@#&*~]).{6,}$');
                          if(value!.isEmpty){
                            return ("Password is required");
                          }
                          if(!regex.hasMatch(value)){
                            return ('''Password must be at least 6 characters\n
                                      Include: uppercase,number & symbol.''');
                          }
                        },
                        onSaved: (value){_passwordController.text = value!;},
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _confirmPassController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Confirm Password',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return ("Please confirm your password");
                          }
                          if(value != _passwordController.text) {
                            return 'Your password does not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          //CircularProgressIndicator()
                          //Navigator.pushReplacementNamed(context,'home');
                          register(_emailController.text,_passwordController.text);
                        },
                        child: const Text('REGISTER'),
                      ),
                      const SizedBox(height: 10,),
                      Row
                        (
                        children:
                        [
                          const Text('Already have an account? '),
                          const SizedBox(width: 8,),
                          GestureDetector(
                              child:
                              const Text('Log in', style:
                              TextStyle(
                                  fontWeight: FontWeight.bold,fontSize: 28, color: Colors.lightBlue),),
                          onTap: ()
                          {
                            Navigator.pushReplacementNamed(context,'login');
                          }
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  postDetailsToFirestore()async
  {
    // calling firestore
    FirebaseFirestore firebaseFirestore= FirebaseFirestore.instance;
    User? user= _auth.currentUser;
    //calling usermodel
    UserModelOne userModel=UserModelOne();
    // sending content
    userModel.email=user!.email;
    userModel.uid=user.uid;
    //userModel.phoneNumber= _phoneNumberController.text as int?;
    userModel.school=_schoolController.text;
    userModel.programme=_programmeController.text;
    userModel.firstName=_firstNameController.text;
    userModel.surName=_surNameController.text;
    userModel.registrationNumber=_registrationNumberController.text;
    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: 'Validating be patient...');
    Navigator.pushReplacementNamed(
        (context), 'trial');
    Fluttertoast.showToast(msg: 'Account created successfully',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      timeInSecForIosWeb: 1,
      fontSize: 16,);
  }

  void register(String email,String password) async
  {
    if (_formKey.currentState!.validate())
    {
      await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text)
          .then((value) => {
        postDetailsToFirestore()
      }).catchError((e)
      {print(e!.message);
        Fluttertoast.showToast(msg: e!.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        timeInSecForIosWeb: 1,
        fontSize: 16,);
      });

    }
  }
}
