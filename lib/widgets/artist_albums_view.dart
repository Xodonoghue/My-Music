import 'package:flutter/material.dart';
import 'package:mymusic/models/Album.dart';
import 'package:mymusic/models/Artist.dart';
import 'package:mymusic/widgets/album_view.dart';

class ArtistAlbumsView extends StatefulWidget {
  final Artist artist;
  ArtistAlbumsView({
    required this.artist,
    super.key});

  @override
  State<ArtistAlbumsView> createState() => _ArtistAlbumsViewState();
}

class _ArtistAlbumsViewState extends State<ArtistAlbumsView> {
  late Future<List<Album>> _data;
  @override
  void initState() {
    super.initState();
    _data = widget.artist.getAlbums();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: _data, builder: ((context, snapshot){
      if (snapshot.hasError){
        return const Text('Something went wrong');
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Text("Loading");
      }
      return Container(width: MediaQuery.of(context).size.width - 250, height: 200, child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
        return AlbumView(album: snapshot.data![index], height: 160, width: 160);
      }, itemCount: snapshot.data!.length),
      );
    }));
  }
}