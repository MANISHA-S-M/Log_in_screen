import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled/ui/auth/login_with_phone_number.dart';
import 'package:untitled/ui/splash_screen.dart';
import 'package:untitled/widgets/round_button.dart';
import 'package:untitled/ui/auth/signup_screen.dart';

class LoginScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }

}

class LoginScreenState extends State<LoginScreen>
{
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuth _auth=FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(child: Text("Login",style: TextStyle(color: Colors.white),)),
          backgroundColor: Colors.deepPurple,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.alternate_email),

                      ),
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return 'Enter Email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return 'Enter Email';
                        }
                        return null;
                      },
                    ),
                  ],
                ),

              ),
              const SizedBox(height: 50,),
              RoundButton(
                title: 'Login',
                onTap: () async {
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: emailController.text, password: passwordController.text);
                    Get.to(SplashScreen());
                    if (kDebugMode) {
                      print(emailController.text);
                    }
                    if (kDebugMode) {
                      print(passwordController.text);
                    }
                  } catch (e) {
                    print(e);
                    Get.snackbar('error', "$e");
                  }


                }, loading: false,
              ),
              const SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                  }, child: Text("Sign up"))
                ],
              ),
              const SizedBox(height: 30,),
              InkWell(
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginWithPhone()));
                },
               child: Container(
                height: 50,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(50),
                 border: Border.all(
                   color: Colors.black,
                 )
                 ),
                   child: Center(
                       child: Text('login with phonnumber'),
                                                             ),
                                                          )
              )
                                       ],
                     ),
                   ),
               ),
    );
  }

}