import 'package:flutter/material.dart';
import 'package:mymusic/controllers/lib_controller.dart';
import 'package:mymusic/widgets/song_view.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  LibController controller = LibController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: controller.getAlbums(), builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text("Error connection failed");
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text("Loading");
      }

      return Container(
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.height,
        child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemBuilder: ((context, index) => SongView(song: snapshot.data![index],height: 160, width: 160))),
      );
    });
  }
}