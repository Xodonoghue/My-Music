import 'package:flutter/material.dart';
import 'package:mymusic/main.dart';
import 'package:mymusic/views/login_screen.dart';
import 'package:mymusic/auth/auth_controller.dart';
import 'package:mymusic/constants.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController email = TextEditingController();

  final TextEditingController username = TextEditingController();

  final TextEditingController password = TextEditingController();

  final AuthController auth = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text("Sign Up", style: TextStyle(fontSize: 25,fontWeight: FontWeight.w800, color: Colors.white)),
          const SizedBox(height: 10),
          Center(
            child: Container(
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width - 80,
              child: Center(child: TextField(
                style: TextStyle(color: Colors.white),
                controller: email, 
                decoration: InputDecoration(prefixIcon: Icon(Icons.email), prefixIconColor: Colors.white, labelText: "Email", 
                labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontFamily: "Cera Pro"), 
                enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 1.0)),
                ),
                )
              )
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width - 80,
              child: Center(child: TextField(
                style: TextStyle(color: Colors.white),
                controller: username, 
                decoration: InputDecoration(prefixIcon: Icon(Icons.person), prefixIconColor: Colors.white, labelText: "Username", 
                labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontFamily: "Cera Pro"), 
                enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 1.0)),
                ),
                )
              )
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Container(
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width - 80,
              child: TextField(
              style: TextStyle(color: Colors.white),
              controller: password, 
              decoration: InputDecoration(prefixIcon: Icon(Icons.lock), 
              prefixIconColor: Colors.white, labelText: "Password", 
              labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontFamily: "Cera Pro"), 
              enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 1.0)),),)
              ),
          ),
          SizedBox(height: 15),
          InkWell(
            onTap: () => authController.registerUser(email.text.trim(), username.text.trim(), password.text.trim()),
            child: Container(
              height: 45, width: MediaQuery.of(context).size.width - 240, 
              decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(15)), 
              child: Center(
                child: Text("Register", 
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 21),)),),
          ),
          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text("Already have an account?", style: TextStyle(color: Colors.white, fontSize: 15),), SizedBox(width: 5), InkWell(child: Text("Log in here", style: TextStyle(color: Colors.white, fontSize: 15)), onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen())),)],),
        ],),
      ),
    );
  }
}