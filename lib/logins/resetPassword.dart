import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final emailEditingController=TextEditingController();
  @override
  void dispose() {
    emailEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator:(value){
        if(value!.isEmpty){
          return ('Please enter your email');
        }
        //reg expression
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
            .hasMatch(value)){return("Please Enter a valid email");}
        return null;
      },
      onSaved: (value)
      {
        emailEditingController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefix: const Icon(Icons.email,color: Colors.blue,),
        contentPadding: const EdgeInsets.fromLTRB(20,15,20,15),
        hintText: "Enter email",
        border: OutlineInputBorder(
            borderRadius:BorderRadius.circular(10)
        ),
      ),
    );
    // reset button
    final resetButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(50),
      color: Colors.lightBlueAccent,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20,15,20,15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            passwordReset();
          },

          child: const Text('RESET',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          )
      ),
    );
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                    key: _formKey,
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Text(' Enter your email and we will send you a password reset link'),
                        ),
                        const SizedBox(height: 25,),
                        emailField,
                        const SizedBox(height: 25,),
                        resetButton,
                        const SizedBox(height: 20,),
                        ElevatedButton(
                            onPressed:()
                            {
                              Navigator.pushReplacementNamed(context,'login');
                            },
                            child:Text('SIGN IN PAGE'))
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
  passwordReset()
  {
    try{
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailEditingController.text.trim());
      showDialog(
          context: context,
          builder: (context)
          {
            return const AlertDialog(
              content: Text('Password reset link sent check your email'),
            );
          });
      //Navigator.pushNamed(context, '/lg');
    } on FirebaseAuthException catch(e){
      print(e);
      showDialog(
          context: context,
          builder: (context)
          {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }

  }
}
