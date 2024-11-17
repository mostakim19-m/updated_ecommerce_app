import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:practice_projects/custom_widgets/custom_appbar.dart';
import 'package:practice_projects/custom_widgets/custom_button.dart';
import 'package:practice_projects/custom_widgets/custom_text.dart';
import 'package:practice_projects/firebase_auth_service/firebase_auth.dart';
import 'package:practice_projects/pages/login_screen.dart';
import '../custom_widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  bool obscure = true;

  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final conformPasswordController=TextEditingController();

  final FirebaseAuthService auth=FirebaseAuthService();
  bool signing=false;


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    conformPasswordController.dispose();
    super.dispose();
  }

  saveData()async{
    CollectionReference collectionRef=FirebaseFirestore.instance.collection('Users');
    return collectionRef.doc(emailController.text).set({
      'email':emailController.text,
      'password':passwordController.text,
      'conformPass':conformPasswordController.text
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CustomText(
                    title: 'Register Here',
                    subtitle: 'Welcome Our Register Screen\n Next Press Now'),
                const SizedBox(
                  height: 40,
                ),
                Form(
                  key: formKey,
                    child:
                Column(
                  children: [
                     CustomTextField(
                       controller: emailController,
                      hintText: 'Enter Email',
                      labelText: 'Email',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                      controller: passwordController,
                      hintText: 'Enter Password',
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                        icon: obscure == true
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                      obscureText: obscure,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                      controller: conformPasswordController,
                      hintText: 'Conform Password',
                      labelText: 'Conform Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                        icon: obscure == true
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                      obscureText: obscure,
                    ),
                  ],
                )),
                const SizedBox(
                  height: 80,
                ),
              signing ? CircularProgressIndicator(color: Colors.white,):CustomButton(
                  title:'Sign Up',
                  onTap: () {
                   if(formKey.currentState!.validate()){
                     saveData();
                   }
                   if(passwordController.text!=conformPasswordController.text){
                     Fluttertoast.showToast(msg: 'Do Not Matched Password',
                         backgroundColor:Colors.indigo,textColor: Colors.white);
                   }else{
                     signUp();
                   }
                  },
                ),
                 CustomButton(
                  title: 'Already you Have an Account',
                  textColor: Colors.black,
                  backgroundColor: Colors.white,
                  onTap: () {
                    Get.to(()=>const LoginScreen());
                  } ,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  signUp()async{

    setState(() {
      signing=true;
    });
    String email=emailController.text;
    String password=passwordController.text;
    String conformPassword=conformPasswordController.text;

    User?user=await auth.signUpWithEmailAndPassword(email, password, conformPassword);

    setState(() {
      signing=false;
    });
    if(user!=null){
      Fluttertoast.showToast(msg: 'User is Register Successfully done',
          backgroundColor:Colors.indigo,textColor: Colors.white);
      Get.to(()=>LoginScreen());
    }else{
      print('Something is wrong');
    }
  }

}
