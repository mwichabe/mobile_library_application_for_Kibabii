import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/authentication.dart';
class DeleteAccountPermanently extends StatefulWidget {
  const DeleteAccountPermanently({Key? key}) : super(key: key);

  @override
  State<DeleteAccountPermanently> createState() => _DeleteAccountPermanentlyState();
}

class _DeleteAccountPermanentlyState extends State<DeleteAccountPermanently> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModelOne loggedInUser = UserModelOne();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value){
      loggedInUser= UserModelOne.fromMap(value.data());
      setState((){});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Container(
                decoration: const BoxDecoration
                  (
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 15,bottom: 15),
                        child: Text('Are you sure you want to delete your account permanently?',style: TextStyle
                          (
                            fontSize: 28,
                            fontWeight: FontWeight.w400
                        ),),
                      ),
                      const SizedBox(height: 15,),
                      Row(
                        children: [
                          ElevatedButton(onPressed: ()async
                          {
                            user?.delete().then((value)
                            {
                              Fluttertoast.showToast(msg: 'Account deleted successfully.',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.green,
                                timeInSecForIosWeb: 1,
                                fontSize: 16,);
                              Navigator.pushReplacementNamed(context, 'signUp');

                            });

                          },
                            style: ButtonStyle
                              (
                                backgroundColor: MaterialStateProperty.all(Colors.red[400])
                            ),
                            child:  const Text('Yes'),
                          ),
                          const SizedBox(width: 55,),
                          ElevatedButton(onPressed: ()
                          {
                            Navigator.pushReplacementNamed(context, 'trial');
                          },
                            style: ButtonStyle
                              (
                                backgroundColor: MaterialStateProperty.all(Colors.orange[400])
                            ),
                            child: const Text('No'),
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
}
