import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mymusic/controllers/artist_controller.dart';
import 'package:mymusic/controllers/home_controller.dart';
import 'package:mymusic/controllers/upload_song_controller.dart';
import 'package:mymusic/models/Artist.dart';
import 'package:mymusic/views/upload_artist_screen.dart';
import 'package:mymusic/widgets/artist_search.dart';
import 'package:mymusic/widgets/song_list.dart';
import 'package:mymusic/controllers/search_controller.dart' as my;

class UploadSongScreen extends StatefulWidget {
   UploadSongScreen({super.key});
  Artist? artist;
  setArtist(Artist? newArtist) {
    artist = newArtist;
  }
  @override
  State<UploadSongScreen> createState() => _UploadSongScreenState();
  UploadSongController uploadSongController = UploadSongController();
}

class _UploadSongScreenState extends State<UploadSongScreen> {
  File? image;
  File? song;
  bool songMode = true;
  bool uploaded = false;
  SongList songList = SongList();
  

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
  Future pickSong() async {
    try {
    final song = await FilePicker.platform.pickFiles();
    String? songPath = song?.paths.elementAt(0);
    if(songPath == null) return;

    final songTemp = File(songPath);
    setState( ( )=> this.song = songTemp);
    } on Exception catch(e) {
      print("Failed to pick song: $e");
    }
    
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController artistNameController = TextEditingController();
  final ArtistController ac = ArtistController();
  List<String> songs = [];
  List<bool> _selectedList = [];
  bool songsSelected = false;

  @override
  void initState() {
    super.initState();
    ac.artistsLen().then((len) => _selectedList = List<bool>.filled(len, false, growable: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SafeArea(
        child: SingleChildScrollView(
          child: songMode ? Column(
            children: [
              uploaded? Container(width: MediaQuery.of(context).size.width, child: Center(
                child: Text("Song Uploaded!", style: TextStyle(fontFamily: 'Cera Pro',
                          color: Colors.white, fontWeight: FontWeight.w900, fontSize: 15),),
              ), color: Colors.blue, padding: EdgeInsets.all(5),): SizedBox(height: 0,),
              SizedBox(height: 30,),
              const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text("Upload Song", style: TextStyle(fontFamily: 'Cera Pro',
                        color: Colors.white, fontWeight: FontWeight.w900, fontSize: 25),
                        ),
                  ),
              SizedBox(height: 30,),
              Text("Enter Song Name", style: TextStyle(fontFamily: "cera pro", fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),),
              Container(
                width: MediaQuery.of(context).size.width, 
                margin: const EdgeInsets.all(20),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: nameController, 
                  decoration: InputDecoration(fillColor: Colors.white,focusColor: Colors.white, enabledBorder: OutlineInputBorder( borderRadius: new BorderRadius.circular(5.0), borderSide: const BorderSide(color: Colors.white, width: 1.0),),), ),
                  ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Search Artist or", style: TextStyle(fontFamily: "cera pro", fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),),
                  InkWell(child: Text(" create new artist", style: TextStyle(fontSize: 18, color: Colors.blue, fontWeight: FontWeight.w700),),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => UploadArtistScreen())),),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(20), 
                child: TextField(
                  onChanged: (text) => setState(() {}),
                  style: TextStyle(color: Colors.white),
                  controller: artistNameController, 
                  decoration: InputDecoration(fillColor: Colors.white, focusColor: Colors.white, enabledBorder: OutlineInputBorder(borderRadius: new BorderRadius.circular(5.0), borderSide: const BorderSide(color: Colors.white, width: 1.0),),), ),),
              SizedBox(height: 10,),
              artistNameController.text != ""? ArtistSearch(artistNameController: artistNameController, ups: this.widget,): SizedBox(height: 0,),
              Column(
                children: [Text(this.image == null? "": "Image Selected", style: TextStyle(fontFamily: "cera pro", fontWeight: FontWeight.w400),),
                  Container(width: MediaQuery.of(context).size.width - 180, height: 40, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))), child: InkWell(child: this.image == null? Center(child: Text("Select Cover Image", style: TextStyle(fontFamily: "cera pro", fontWeight: FontWeight.w700, fontSize: 18),)) : Text("Change Image Selection", style: TextStyle(fontFamily: "cera pro", fontWeight: FontWeight.w700, fontSize: 15),), onTap: () => pickimage())),
                ],
              ),
              Column(
                children: [Text(this.song == null? "": "Song Selected"),
                  Container(width: MediaQuery.of(context).size.width - 180, height: 40, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))), child: InkWell(child: this.song == null? Center(child: Text("Select Song", style: TextStyle(fontFamily: "cera pro", fontWeight: FontWeight.w700, fontSize: 18),)) : Text("Change Song Selection", style: TextStyle(fontFamily: "cera pro", fontWeight: FontWeight.w700, fontSize: 15),), onTap: () => pickSong())),
                ],
              ),
              SizedBox(height: 12,),
              
              SizedBox(height: 40,),
              Container(width: MediaQuery.of(context).size.width - 180, height: 40, 
              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(10))), 
              child: InkWell(child: Center(child: Text("Upload Song", style: TextStyle(fontFamily: "cera pro", fontWeight: FontWeight.w700, fontSize: 18),)), 
              onTap: () => {

                if (nameController.text != null && image != null && song != null && widget.artist != null) {
                  widget.uploadSongController.UploadSong(nameController.text, widget.artist!.name, song!, image!, widget.artist!.artistId),
                  uploaded = true,
                image = null,
                song = null,
                nameController.clear(),
                artistNameController.clear(),
                setState(() {})
                } else{ 
                  print("Missing Fields")
                }
                }
                )
              ),
              SizedBox(height: 45,),
              InkWell(onTap: () => {songMode = false, setState(() {})}, child: Text("Click Here To Create Album", style: TextStyle(color: Colors.white, fontFamily: 'Cera Pro', fontSize: 18),),)   
            ],
          ) : Column(
              children: [
                uploaded? Container(width: MediaQuery.of(context).size.width, child: Center(
                  child: Text("Album Created!", style: TextStyle(fontFamily: 'Cera Pro',
                            color: Colors.white, fontWeight: FontWeight.w900, fontSize: 15),),
                ), color: Colors.blue, padding: EdgeInsets.all(5),): SizedBox(height: 0,),
                SizedBox(height: 30,),
                const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text("Create Album", style: TextStyle(fontFamily: 'Cera Pro',
                          color: Colors.white, fontWeight: FontWeight.w900, fontSize: 25),
                          ),
                    ),
                SizedBox(height: 30,),
                Text("Enter Album Name", style: TextStyle(fontFamily: "cera pro", fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),),
                Container(
                  width: MediaQuery.of(context).size.width, 
                  margin: const EdgeInsets.all(20),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: nameController, 
                    decoration: InputDecoration(fillColor: Colors.white,focusColor: Colors.white, enabledBorder: OutlineInputBorder( borderRadius: new BorderRadius.circular(5.0), borderSide: const BorderSide(color: Colors.white, width: 1.0),),), ),),
                SizedBox(height: 10,),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Search Artist or", style: TextStyle(fontFamily: "cera pro", fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),),
                  InkWell(child: Text(" create new artist", style: TextStyle(fontSize: 18, color: Colors.blue, fontWeight: FontWeight.w700),),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => UploadArtistScreen())),),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(20), 
                child: TextField(
                  onChanged: (text) => setState(() {}),
                  style: TextStyle(color: Colors.white),
                  controller: artistNameController, 
                  decoration: InputDecoration(fillColor: Colors.white, focusColor: Colors.white, enabledBorder: OutlineInputBorder(borderRadius: new BorderRadius.circular(5.0), borderSide: const BorderSide(color: Colors.white, width: 1.0),),), ),),
              SizedBox(height: 10,),
              artistNameController.text != ""? ArtistSearch(artistNameController: artistNameController, ups: this.widget,): SizedBox(height: 0,),
                SizedBox(height: 10,),
                Column(
                  children: [Text(this.image == null? "": "Image Selected", style: TextStyle(fontFamily: "cera pro", fontWeight: FontWeight.w400),),
                    Container(
                      width: MediaQuery.of(context).size.width - 180, 
                      height: 40, 
                      decoration: BoxDecoration(color: Colors.white, 
                      borderRadius: BorderRadius.all(Radius.circular(10))), 
                      child: InkWell(child: this.image == null? 
                        Center(child: Text("Select Cover Image", 
                        style: TextStyle(fontFamily: "cera pro", fontWeight: FontWeight.w700, fontSize: 18),)) : 
                        Text("Change Image Selection", 
                        style: TextStyle(fontFamily: "cera pro", fontWeight: FontWeight.w700, fontSize: 15),), 
                      onTap: () => pickimage())),
                  ],
                ),
                SizedBox(height: 20,),
                Text("Select Songs For Album", style: TextStyle(fontFamily: "cera pro", fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),),
                SizedBox(height: 40,),
                songList,
                SizedBox(height: 40,),
                Column(
                  children: [Text(this.song == null? "": "Song Selected"),
                    Container(
                      width: MediaQuery.of(context).size.width - 180, 
                      height: 40, 
                      decoration: BoxDecoration(color: Colors.white, 
                      borderRadius: BorderRadius.all(Radius.circular(10))), 
                      child: InkWell(
                        child: !songsSelected? 
                        Center(
                          child: Text("Finish Selection", 
                          style: TextStyle(fontFamily: "cera pro", fontWeight: FontWeight.w700, fontSize: 18),)) : 
                          Text("Select More Songs", 
                          style: TextStyle(fontFamily: "cera pro", fontWeight: FontWeight.w700, fontSize: 15),), 
                          onTap: () {songs = songList.getSongs(); songsSelected = !songsSelected; setState(() {});}
                          )
                        ),
                  ],
                ),
                SizedBox(height: 20,),
                Container(width: MediaQuery.of(context).size.width - 180, height: 40, 
                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(10))), 
                child: InkWell(child: Center(child: Text("Create Album", style: TextStyle(fontFamily: "cera pro", fontWeight: FontWeight.w700, fontSize: 18),)), 
                onTap: () => {
                  if (!nameController.text.isEmpty && image != null && widget.artist != null && songs.length > 0) {
                    widget.uploadSongController.createAlbum(nameController.text, widget.artist!.name, widget.artist!.artistId, songs, image!),
                    uploaded = true,
                    image = null,
                    song = null,
                    nameController.clear(),
                    artistNameController.clear(),
                    setState(() {})
                    } else{ 
                      if (nameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter name"))),
                      } else if (widget.artist == null){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Select artist"))),
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Select songs"))),
                      }
                      
                    }
                  }
                  )
                ),
                SizedBox(height: 45,),
                InkWell(onTap: () => {songMode = true, songList = SongList(), setState(() {})}, child: Text("Click Here To Upload Song", style: TextStyle(color: Colors.white, fontFamily: 'Cera Pro', fontSize: 18),),),    
              ],
            ),
          
        ),
      )
    );
    }
  }