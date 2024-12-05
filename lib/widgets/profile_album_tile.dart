import 'package:flutter/material.dart';

class ProfileAlbumTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String artistName;
  final String year;
  final double size;
  const ProfileAlbumTile({
    super.key, 
    required this.imageUrl,
    required this.name,
    required this.artistName,
    required this.size,
    required this.year,
    });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
            padding: EdgeInsets.all(6),
            height: size,
            width: size,
            child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            child: Image.network(imageUrl)),
          ),
          Text(name, style: TextStyle(fontFamily: 'Cera Pro',
              color: Colors.white, fontWeight: FontWeight.w700),),
          SizedBox(height: 4,),
          Text(year, style: TextStyle(fontFamily: 'Cera Pro',
              color: Colors.white, fontWeight: FontWeight.w200),),
          ]
        ),
      ),
    );
  }
}