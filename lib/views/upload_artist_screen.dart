import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mymusic/controllers/artist_controller.dart';

class UploadArtistScreen extends StatefulWidget {
  UploadArtistScreen({super.key});

  @override
  State<UploadArtistScreen> createState() => _UploadArtistScreenState();
}

class _UploadArtistScreenState extends State<UploadArtistScreen> {
  ArtistController ac = ArtistController();
  File? image;
    Future pickimage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on Exception catch(e) {
      print("Failed to pick image: $e");
    }
  }
  TextEditingController artistname = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Artist Name", style: TextStyle(fontFamily: "Cera Pro", fontWeight: FontWeight.w700, color: Colors.white, fontSize: 18),),
            SizedBox(height: 15),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 200,
                child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: artistname, 
                          decoration: InputDecoration(fillColor: Colors.white,focusColor: Colors.white, enabledBorder: OutlineInputBorder( borderRadius: new BorderRadius.circular(5.0), borderSide: const BorderSide(color: Colors.white, width: 1.0),),), ),
              ),
            ),
            SizedBox(height: 25),
            Text("Artist Description", style: TextStyle(fontFamily: "Cera Pro", fontWeight: FontWeight.w700, color: Colors.white, fontSize: 18),),
            SizedBox(height: 15),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 200,
                child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: description, 
                          decoration: InputDecoration(fillColor: Colors.white,focusColor: Colors.white, enabledBorder: OutlineInputBorder( borderRadius: new BorderRadius.circular(5.0), borderSide: const BorderSide(color: Colors.white, width: 1.0),),), ),
              ),
            ),
            SizedBox(height: 25),
            InkWell(onTap: () => pickimage(), child: Container(child: Center(child: Text(image == null? "Select Profile Pic": "Image Selected", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),)), height: 45, width: MediaQuery.of(context).size.width - 200, decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(15)),)),
            SizedBox(height: 25),
            InkWell(onTap:() {
              ac.uploadArtist(image!, artistname.text, description.text);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Artist Succesfully Created")));
              Navigator.of(context).pop();
             },child: Container(child: Center(child: Text("Create Artist", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),)), height: 45, width: MediaQuery.of(context).size.width - 200, decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(15)),))
          ],
        ),
      
    );
  }
}