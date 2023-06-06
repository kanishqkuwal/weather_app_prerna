
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sample_flutter_project/Weather_app_/mainscreen.dart';
import 'package:sample_flutter_project/ui/auth/signup_screen.dart';
import 'package:sample_flutter_project/utils/utils.dart';
import 'package:sample_flutter_project/widgets/round_button.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {

  bool loading = false;


  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

    final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose

    emailController.dispose();
    passwordController.dispose();
  }

  void login(){
    setState(() {
      loading = true;
    });
    _auth.signInWithEmailAndPassword(
        email:emailController.text,
        password: passwordController.text.toString()).then((value) {
          Utils().toastMessage(value.user!.email.toString());
          Navigator.push(context,MaterialPageRoute(builder: (context)=>WeatherApp1()));

          setState(() {
            loading = false;
          });


    }).onError((error, stackTrace) {
            debugPrint(error.toString());
         Utils().toastMessage(error.toString());
            setState(() {
              loading = false;
            });

    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('Login')),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formkey,
                child: Column(
                  children: [

                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController ,
                      decoration: InputDecoration(
                          hintText:  'Email',
                          prefixIcon: Icon(Icons.alternate_email)
                      ),
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return 'Enter email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20,),

                    TextFormField(
                      keyboardType: TextInputType.emailAddress,

                      controller: passwordController ,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText:  'password',

                          prefixIcon: Icon(Icons.lock)
                      ),
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return 'Enter password';
                        }
                        return null;
                      },
                    ),

                  ],
                )
            ),
            SizedBox(height: 50,),


            RoundButton(title: 'Login',
              onTap: (){
                if(_formkey.currentState!.validate()){
                   login();
                }
              },),
            SizedBox(height: 30,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text("Don't have an account?"),
                   TextButton(onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpscreen()));
                   },
                       child: Text('Sign up'))
                 ],
               ),

          ],
        ),
      ),
    );
  }
}