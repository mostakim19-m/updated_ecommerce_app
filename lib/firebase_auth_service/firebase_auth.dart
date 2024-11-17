import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseAuthService{

  FirebaseAuth auth=FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email,String password,String conformPassword)async{
    try {
      UserCredential credential=await auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException  catch(e){
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'The account already exists for that email',
            backgroundColor:Colors.indigo,textColor: Colors.white);
      }else if(e.code == 'weak-password'){
        Fluttertoast.showToast(msg: 'The password provided is too weak.',
            backgroundColor:Colors.indigo,textColor: Colors.white);
      }
      return null;
    }
  }


  Future<User?> signInWithEmailAndPassword(String email,String password)async{
    try {
      UserCredential credential=await auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }on FirebaseAuthException catch(e){
      if(e.code == 'wrong-password'){
        Fluttertoast.showToast(msg: 'Password Invalid',
            backgroundColor:Colors.indigo,textColor: Colors.white);
      }else if(e.code == 'user-not-found'){
        Fluttertoast.showToast(msg: 'No user found for that email',
            backgroundColor:Colors.indigo,textColor: Colors.white);
      }
      return null;
    }

  }

}