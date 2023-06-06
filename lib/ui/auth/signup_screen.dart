
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sample_flutter_project/Weather_app_/mainscreen.dart';
import 'package:sample_flutter_project/ui/auth/login_screen.dart';
import 'package:sample_flutter_project/utils/utils.dart';
import 'package:sample_flutter_project/widgets/round_button.dart';

class SignUpscreen extends StatefulWidget {
  const SignUpscreen({super.key});

  @override
  State<SignUpscreen> createState() => _SignUpscreenState();
}

class _SignUpscreenState extends State<SignUpscreen> {

  bool loading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose

    emailController.dispose();
    passwordController.dispose();
  }

  void signUp() {
    setState(() {
      loading = true;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Center(child: Text('Sign Up')),
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


            RoundButton(title: 'Sign up',
              onTap: (){
                if(_formkey.currentState!.validate()){
                  signUp();
                 _auth.createUserWithEmailAndPassword(
                     email: emailController.text.toString(),
                     password: passwordController.text.toString()).then((value) {
                   setState(() {
                     loading = false;
                   });
                        
                 }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                  setState(() {
                    loading = false;

                  });
                 });
                }
              },),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Loginscreen()));

                }, child: Text('Login'))
              ],
            )
          ],
        ),
      ),
    );
  }
}