import 'package:flutter/material.dart';
import 'package:mymusic/auth/auth_controller.dart';
import 'package:mymusic/views/base_screen.dart';
import 'package:mymusic/views/homescreen.dart';
import 'package:mymusic/views/lib_screen.dart';
import 'package:mymusic/views/login_screen.dart';
import 'package:mymusic/views/profile_screen.dart';
import 'package:mymusic/views/search_screen.dart';
import 'package:mymusic/views/upload_song_screen.dart';

import 'models/Song.dart';

BaseScreen baseScreen = BaseScreen();
List pages = [HomeScreen(), LibScreen(), SearchScreen(), UploadSongScreen()];
var authController = AuthController();
