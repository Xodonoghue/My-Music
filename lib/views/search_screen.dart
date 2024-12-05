import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mymusic/controllers/search_controller.dart' as my;
class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController song = TextEditingController();
  final my.SearchController _searchController = my.SearchController();
  
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> songStream;
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(children: [
        TextField(controller: song, 
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(prefixIcon: Icon(Icons.search), prefixIconColor: Colors.white, labelText: "Search", 
          labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontFamily: "Cera Pro"), 
          enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 1.0)),),
          onChanged: (value) => setState(() {}),
          ),
          song.text.isNotEmpty? StreamBuilder(
            stream: FirebaseFirestore.instance.collection('songs').where('name', isGreaterThanOrEqualTo: song.text.trim()).snapshots(),
            builder: (context, snapshot){
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }
              return Container(
                height: MediaQuery.of(context).size.height - 100,
                width: MediaQuery.of(context).size.width,
                child: song.text.isNotEmpty ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Padding(padding: EdgeInsets.all(10),child: ListTile(subtitle: Text(snapshot.data!.docs[index]['artistName'], style: TextStyle(color: Colors.white, fontSize: 14),), leading: ClipRRect(borderRadius: BorderRadius.circular(15),child: Image.network(snapshot.data!.docs[index]['imageUrl'])),title: Text(snapshot.data!.docs[index]['name'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700) ,)));
                  }): SizedBox()
              );
              }
          ): SizedBox(),
      ]),
    );
  }
}