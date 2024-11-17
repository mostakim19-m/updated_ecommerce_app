import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:practice_projects/custom_widgets/custom_button.dart';
import 'package:practice_projects/custom_widgets/custom_text.dart';
import 'package:practice_projects/custom_widgets/custom_text_field.dart';
import 'package:practice_projects/firebase_auth_service/firebase_auth.dart';
import 'package:practice_projects/pages/bottom_navbar.dart';
import 'package:practice_projects/pages/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool obscure = true;

  final emailController=TextEditingController();
  final passwordController=TextEditingController();

  final FirebaseAuthService auth=FirebaseAuthService();
  bool login=false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 11,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const CustomText(title: 'Login Here',
                subtitle: 'Welcome our Login Page\n Next Press Now',),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: formKey,
                  child: Column(
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
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forget Your Password',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                   login?CircularProgressIndicator(color: Colors.white,): CustomButton(
                      title: 'Login Now',
                      onTap: () {
                       if( formKey.currentState!.validate()){
                         signIn();
                       }
                      },
                    ),
                     CustomButton(
                      title: 'Create New Account',
                      textColor: Colors.black,
                      backgroundColor: Colors.white,
                      onTap: () {
                        Get.to(()=>const RegisterScreen());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  signIn()async{

    setState(() {
      login=true;
    });
    String email=emailController.text;
    String password=passwordController.text;

    User?user=await auth.signInWithEmailAndPassword(email, password);

    setState(() {
      login=false;
    });
    if(user!=null){
      Fluttertoast.showToast(msg: 'Login Successfully done',
          backgroundColor:Colors.indigo,textColor: Colors.white);
      Get.offAll(()=>BottomNavbar());
    }else{
      Fluttertoast.showToast(msg: 'Email Or Password Invalid',
          backgroundColor:Colors.indigo,textColor: Colors.white);
    }
  }
}
