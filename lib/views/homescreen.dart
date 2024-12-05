import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mymusic/models/Song.dart';
import 'package:mymusic/widgets/home_albums.dart';
import 'package:mymusic/widgets/song_view.dart';
import 'package:mymusic/controllers/home_controller.dart';
import 'package:mymusic/constants.dart';

class HomeScreen extends StatefulWidget {
  
  HomeScreen({
    super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = HomeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 1, bottom: 1),
          child: ListView(
            children: [
              Row(
                children: [Padding(
                  padding: EdgeInsets.all(15),
                  child: Text("Home", style: TextStyle(fontFamily: 'Cera Pro',
                      color: Colors.white, fontWeight: FontWeight.w900, fontSize: 25),
                      ),
                ), SizedBox(width: MediaQuery.of(context).size.width - 200,),Padding(
                  padding: EdgeInsets.all(15),
                  child: InkWell(
                    onTap: () => {authController.logoutUser()},
                    child: Text("Logout", 
                    style: TextStyle(color: Colors.white, fontFamily: 'Cera Pro', fontWeight: FontWeight.w800, fontSize: 16),),
                  )
                ),]
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("Songs For You", style: TextStyle(
                    fontFamily: 'Cera Pro', fontWeight: FontWeight.w800, fontSize: 20, color: Colors.white),
                    ),
                ),
              ),
              Container(
                height: 200,
                child: HomeController(),
                ),
            Center(
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("Albums For You", style: TextStyle(
                    fontFamily: 'Cera Pro', fontWeight: FontWeight.w800, fontSize: 20, color: Colors.white),
                    ),
                ),
            ),
            Container(
                height: 200,
                child: HomeAlbums(),         
            ),
            Center(
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("New Music", style: TextStyle(
                    fontFamily: 'Cera Pro', fontWeight: FontWeight.w800, fontSize: 20, color: Colors.white),
                    ),
                ),
            ),
            Container(
                height:200,
                child: HomeController(),          
              ),
              ],
            
      
          ),
        ),
     ),
    );
    
  }
}