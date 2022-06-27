import 'package:flutter/material.dart';
import 'package:friends_and_family/screens/login_screen.dart';
import 'package:friends_and_family/screens/utils/shared_prefrence.dart';

class HomeScreen extends StatefulWidget {

 var username, name, phone_number, address, token;

 HomeScreen({
   this.username,
   this.name,
   this.phone_number,
   this.address,
   this.token
 });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: (){
              Constants.preferences!.setBool("loggedIn", false);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (ctx)=> SignInScreen()));
            },
            icon: Icon(Icons.logout, color: Colors.white, size: 20,),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Username is :" + widget.username),
          Text("Name is :" + widget.name),
          Text("Phone Number is : " + widget.phone_number),
          Text("Address is :" +widget.address),
          Text("Token is :" + widget.token),
        ],
      ),
    );
  }
}
