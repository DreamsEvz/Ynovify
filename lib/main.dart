import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ynovify/Music.dart';
import 'package:just_audio/just_audio.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
          primarySwatch: Colors.grey,
          scaffoldBackgroundColor: Colors.black87),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //mettre les function ici


  List<Music> musicList = [
    Music('Nothing like the old school', "Sefa", "assets/nothing_like_old_school.jpg", "assets/nothing-like.mp3"),
    Music("Du propre", "Orelsan", "assets/c_est_du_propre.jpg", "assets/nothing-like.mp3")
  ];


  bool updateSong = true;

  _updatePlayerSong() async {
    if(updateSong) {
      await _player.setAsset(musicList[index].urlSong);
    }
  }

  final _player = AudioPlayer();


  bool isPlaying = false;

  var index = 0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Ynovify"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 400,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25)
                      ),
                        image: DecorationImage(
                            image: AssetImage(musicList[index].imagePath))),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text(
                    musicList[index].singer,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text(
                      musicList[index].title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25
                      ),
                    )
                  ]
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  IconButton(
                    icon: const Icon(
                      Icons.fast_rewind,
                      color:  Colors.white,
                    ),
                    iconSize: 45,
                    onPressed: () {
                      setState(() {
                        if(index != 0){
                          index = index -1;
                        }
                        else {
                          index = musicList.length -1;
                        }
                      });
                    },
                  ),
                  IconButton(
                    iconSize: 50,
                    color: Colors.white,
                    icon: isPlaying? const Icon(Icons.pause_circle_rounded) : const Icon(Icons.play_circle_rounded),
                    onPressed: () {
                      setState(() {
                        isPlaying = !isPlaying;
                        if(isPlaying){
                          _updatePlayerSong();
                          _player.play();
                        }
                        else {
                          _player.pause();
                        }
                      });
                    }
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if(index != musicList.length -1) {
                            index = index + 1;

                          }
                          else {
                            index = 0;
                          }
                        });
                      },
                      iconSize: 45,
                      icon: const Icon(
                        Icons.fast_forward,
                        color: Colors.white,
                      )
                  )
                ],

              )
            ]),
      ),
    );
  }
}
