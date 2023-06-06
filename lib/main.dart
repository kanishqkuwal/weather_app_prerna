// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// void main() {
//   runApp(const MaterialApp(
//     home: Home(),
//   ));
// }
//
// final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: [
//       'email'
//     ]
// );
//
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//
//   GoogleSignInAccount? _currentUser;
//
//   @override
//   void initState() {
//     _googleSignIn.onCurrentUserChanged.listen((account) {
//       setState(() {
//         _currentUser = account;
//       });
//     });
//     _googleSignIn.signInSilently();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter Google Sign in'),
//       ),
//       body: Container(
//         alignment: Alignment.center,
//         child: _buildWidget(),
//       ),
//     );
//   }
//
//   Widget _buildWidget(){
//     GoogleSignInAccount? user = _currentUser;
//     if(user != null){
//       return Padding(
//         padding: const EdgeInsets.fromLTRB(2, 12, 2, 12),
//         child: Column(
//           children: [
//             ListTile(
//               leading: GoogleUserCircleAvatar(identity: user),
//               title:  Text(user.displayName ?? '', style: TextStyle(fontSize: 22),),
//               subtitle: Text(user.email, style: TextStyle(fontSize: 22)),
//             ),
//             const SizedBox(height: 20,),
//             const Text(
//               'Signed in successfully',
//               style: TextStyle(fontSize: 20),
//             ),
//             const SizedBox(height: 10,),
//             ElevatedButton(
//                 onPressed: signOut,
//                 child: const Text('Sign out')
//             )
//           ],
//         ),
//       );
//     }else{
//       return Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             const SizedBox(height: 20,),
//             const Text(
//               'You are not signed in',
//               style: TextStyle(fontSize: 30),
//             ),
//             const SizedBox(height: 10,),
//             ElevatedButton(
//                 onPressed: signIn,
//                 child: const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text('Sign up', style: TextStyle(fontSize: 30)),
//                 )
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   void signOut(){
//     _googleSignIn.disconnect();
//   }
//
//   Future<void> signIn() async {
//     try{
//       await _googleSignIn.signIn();
//     }catch (e){
//       print('Error signing in $e');
//     }
//   }
//
// }












import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_flutter_project/Weather_app_/login_screen.dart';
import 'package:sample_flutter_project/Weather_app_/mainscreen.dart';
import 'package:sample_flutter_project/Weather_app_/utils/themes/customthemes.dart';
import 'package:sample_flutter_project/firebase_services/splash_services.dart';
import 'package:sample_flutter_project/ui/splash_screen.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: CustomThemes.lightTheme,
      darkTheme: CustomThemes.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      title: "Weather App",
    );

  }
}
