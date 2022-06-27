// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Container(
//               height: 270,
//               width: 280,
//               decoration: BoxDecoration(
//                   gradient: RadialGradient(
//                       center: Alignment.topRight,
//                       radius: 2,
//                       colors: [
//                         Color(0xffF0B27A),
//                         Color(0xffA569BD),
//                       ]
//                   ),
//                   borderRadius: BorderRadius.only(bottomRight: Radius.circular(200))
//               ),
//             ),
//             Align(
//               alignment: Alignment.topLeft,
//               child: Container(
//                 child: Image.asset("assets/images/solars.png", fit: BoxFit.fill,),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:friends_and_family/screens/provider/shopkeeper.dart';
import 'package:friends_and_family/screens/utils/shared_prefrence.dart';
import 'package:friends_and_family/screens/widgets/loading.dart';
import 'package:http/http.dart';

import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}


class _SignInScreenState extends State<SignInScreen> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  login(String username, password)async{
    try{
      var response = await post(
          Uri.parse('http://192.168.100.240:8000/api/login/'),
          body: {
            "username": username,
            "password": password,
          });
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data);
        data["username"];
        print(data["name"]);
        print(data["phone_number"]);
        print(data["address"]);
        print(data["token"]);
        print("Login Successfully");
        setState(() => isLoading = true);
        Constants.preferences!.setBool("loggedIn", true);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=> HomeScreen(
              username: data["username"],
              name: data["name"],
              phone_number: data["phone_number"],
              address: data["address"],
              token: data["token"],
            )));
      }else{
        print("Failed");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Failed")));
      }
      setState(() {
        isLoading = false;
      });
    }catch(e){
      print(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

   // kPrimaryColor = Color(0XFF6A62B7);
   // kBackgroundColor = Color(0XFFE5E5E5);

  @override
  Widget build(BuildContext context) {

    return isLoading ? Loading() :
    Scaffold(
      backgroundColor: const Color(0XFFE5E5E5),
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.deepPurple,
        backgroundColor: Colors.deepPurple,
        title: const Text("Login Screen"),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 120.0, left: 20),
              child: Text(
                "Here You Can",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5.0, left: 20),
              child: Text(
                "Login !",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const SizedBox(
              height: 55.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: usernameController,
                validator: (val) {
                  if(val.toString().isEmpty){
                    return "Please Enter Your Name";
                  } else if(val.toString().length < 3){
                    return "Name is too small";
                  } else{
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  hintText: "Enter Your Username",
                  labelText: "Username",
                  prefixIcon: Icon(Icons.email),
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                validator: (val) {
                  if(val.toString().isEmpty){
                    return "Please Enter Your Password";
                  } else if(val.toString().length < 4){
                    return "Password is too small";
                  } else{
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  hintText: "Enter Your Password",
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10.0,),
            GestureDetector(
              onTap: (){},
              child: Padding(
                padding: const EdgeInsets.only(right: 14.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 1.0),
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            GestureDetector(
              onTap: (){
                if(formKey.currentState!.validate()){
                  // ignore: void_checks
                  return login(
                      usernameController.text.toString(),
                      passwordController.text.toString()
                  );
                } else{
                  return null;
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0XFF6A62B7),
                        Colors.deepPurple
                      ]
                    ),
                  ),
                  child: const Center(
                      child: Text(
                        "LOG IN",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                      ),
                  ),
                ),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     const Text(
            //       "Sign In",
            //       style: TextStyle(
            //         color: Colors.deepPurple,
            //         fontWeight: FontWeight.w700,
            //         fontSize: 18,
            //         letterSpacing: 0.4,
            //       ),
            //     ),
            //     CircleAvatar(
            //       radius: 27,
            //       backgroundColor: Colors.deepPurple,
            //       child: IconButton(
            //           onPressed: () {
            //             // // if(formKey.currentState!.validate()){
            //             // //   return login(emailController.text.toString(), passwordController.text.toString());
            //             // }
            //             // // else{
            //             // //   return null;
            //             // // }
            //           }, icon: Icon(Icons.arrow_forward, color: Colors.white,)),
            //     )
            //   ],
            // ),
            const SizedBox(
              height: 35.0,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 45.0),
              child: Text(
                "If you don't have account! Register Yourself",
                style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 25.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: const RadialGradient(
                    radius: 3.0,
                      colors: [
                        Color(0XFF6A62B7),
                        // Colors.deepPurple,
                        Colors.black87,
                      ]
                  ),
                ),
                child: const Center(
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                ),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         // Navigator.pushReplacement(
            //         //     context, MaterialPageRoute(builder: (ctx) => SignUpScreen()));
            //       },
            //       child: Container(
            //         padding: const EdgeInsets.only(bottom: 4.0),
            //         decoration: const BoxDecoration(
            //             border: Border(
            //                 bottom: BorderSide(
            //                   color: Colors.purple,
            //                   width: 2.3,
            //                 ))),
            //         child: const Text(
            //           "Sign Up",
            //           style: TextStyle(
            //             color: Colors.deepPurple,
            //             fontWeight: FontWeight.w700,
            //             fontSize: 18,
            //             letterSpacing: 0.4,
            //           ),
            //         ),
            //       ),
            //     ),
            //     GestureDetector(
            //       onTap: (){},
            //       child: Container(
            //         padding: const EdgeInsets.only(bottom: 4.0),
            //         decoration: const BoxDecoration(
            //             border: Border(
            //                 bottom: BorderSide(
            //                   color: Colors.purple,
            //                   width: 2.3,
            //                 ))),
            //         child: const Text(
            //           "Forgot Password?",
            //           style: TextStyle(
            //             color: Colors.deepPurple,
            //             fontWeight: FontWeight.w700,
            //             fontSize: 16,
            //             letterSpacing: 0.4,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
