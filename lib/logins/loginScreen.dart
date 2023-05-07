import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;

  //form key
  final _formKey = GlobalKey<FormState>();
  bool isCheckedRememberMe = false;

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
                      Image.asset(
                        'images/KIBU-Logo.png',
                        //height: 100,
                        //width: 100,
                      ),
                      const SizedBox(height: 50),
                      TextFormField(
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Please enter your school email',
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
                        onSaved: (value){_emailController.text = value!;},
                        autocorrect: true,
                        autofocus: true,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        textInputAction: TextInputAction.done,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        validator:(value){
                          RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!$@#&*~]).{6,}$');
                          if(value!.isEmpty){
                            return ("Password is required");
                          }
                          if(!regex.hasMatch(value)){
                            return ('''Password must be at least 6 characters
                                    Include: uppercase,number & symbol.''');
                          }
                        },
                        onSaved: (value){_passwordController.text = value!;},
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          //CircularProgressIndicator()
                          //Navigator.pushReplacementNamed(context,'trial');
                          signIn(_emailController.text,_passwordController.text);
                        },
                        child: const Text('Login'),
                      ),
                      const SizedBox(height: 10,),
                      Row
                        (
                        children:
                        [
                          const Text('Do not have an account? '),
                          const SizedBox(width: 8,),
                          GestureDetector(
                              child:
                              Text('Register', style:
                              TextStyle(
                                  fontWeight: FontWeight.bold,fontSize: 18, color: Colors.orange[800]),),
                              onTap: ()
                              {
                                Navigator.pushReplacementNamed(context,'signUp');
                              }
                          )
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          Checkbox(
                            value: isCheckedRememberMe,
                            onChanged: (value) => setState(() => isCheckedRememberMe = value!),
                          ),
                          Text('Remember me'),
                        ],
                      ),
                      GestureDetector(
                          child:
                          const Text('Forgot Password?', style:
                          TextStyle(
                              fontWeight: FontWeight.bold,fontSize: 18, color: Colors.blue),),
                          onTap: ()
                          {
                            Navigator.pushReplacementNamed(context,'resetPass');
                          }
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

  void signIn(String email, String password) async
  {
    if(_formKey.currentState!.validate()){
      await _auth
          .signInWithEmailAndPassword(email: _emailController.text,password:_passwordController.text)
          .then((uid)=>{
        Navigator.pushReplacementNamed(context,'trial'),
        Fluttertoast.showToast(msg:'Login Successful',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          timeInSecForIosWeb: 1,
          fontSize: 16,),
        actionRemeberMe
      }).catchError((e)
      {
        print(e!.message);
        Fluttertoast.showToast(msg: e!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          timeInSecForIosWeb: 1,
          fontSize: 16,);
      });
    }
  }
  actionRemeberMe(bool value) {
    isCheckedRememberMe = value;
    SharedPreferences.getInstance().then(
          (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('email', _emailController.text);
        prefs.setString('password', _passwordController.text);
      },
    );
    setState(() {
      isCheckedRememberMe = value;
    });
  }
}
