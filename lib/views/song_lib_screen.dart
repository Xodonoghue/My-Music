import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mymusic/controllers/lib_controller.dart';
import 'package:mymusic/constants.dart';
import 'package:mymusic/models/User.dart' as model;

class SongLibScreen extends StatefulWidget {
  const SongLibScreen({super.key});

  @override
  State<SongLibScreen> createState() => _SongLibScreenState();
}

class _SongLibScreenState extends State<SongLibScreen> {
  late LibController controller = LibController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Songs",
                style: TextStyle(
                    fontFamily: 'Cera Pro',
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 25),
              ),
            ),
            FutureBuilder(
                future: controller.getSongs(),
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }
                  return Container(
                      height: MediaQuery.of(context).size.height - 20,
                      width: 250,
                      child: ListView.separated(
                          itemBuilder: ((context, index) => ListTile(
                              subtitle: Text(
                                snapshot.data![index].artistName,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                              leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                      snapshot.data![index].imageUrl)),
                              title: Text(
                                snapshot.data![index].name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ))),
                          separatorBuilder: (context, index) => Divider(
                                thickness: 1,
                                color: Colors.white,
                              ),
                          itemCount: snapshot.data!.length));
                }))
          ],
        ));
  }
}
