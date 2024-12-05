import 'package:flutter/material.dart';

class SongTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String artistName;
  final String album;
  const SongTile({super.key,
    required this.imageUrl,
    required this.name,
    required this.artistName,
    required this.album});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: ListTile(
        leading: ClipRRect(child: Image.network(imageUrl), borderRadius: BorderRadius.circular(10),),
        title: Text(name, style: TextStyle(fontFamily: 'cera pro', fontWeight: FontWeight.w700, color: Colors.white, fontSize: 16,),),
        subtitle: Text(artistName, style: TextStyle(fontFamily: 'cera pro', fontWeight: FontWeight.w300, color: Colors.white, fontSize: 14, height: 1.65)),
        trailing: Icon(Icons.music_note_outlined, color: Colors.white,),
      ),
    );
  }
}