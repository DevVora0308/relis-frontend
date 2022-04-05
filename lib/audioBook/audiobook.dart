// import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:relis/audioBook/audio_file.dart';
import 'package:relis/authentication/user.dart';
import 'package:relis/globals.dart';

class AudioBook extends StatefulWidget {
  static const routeName = '/AudioBook';
  //const AudioBook({Key? key}) : super(key: key);
  dynamic book, audioBook, audioBytes, index;
  AudioBook({
    this.book,
    this.audioBook,
    this.audioBytes,
    this.index,
  });

  @override
  _AudioBookState createState() => _AudioBookState();
}

class _AudioBookState extends State<AudioBook> {
  late AudioPlayer advPlayer;
  @override
  void initState() {
    print("...in AudioBook");
    super.initState();
    advPlayer = AudioPlayer(userAgent: "${user!["emailId"]}-${widget.audioBook[widget.index]["id"]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.yellow[800],
      appBar: AppBar(
        title: Text("ReLis: Audio-Book"),
        backgroundColor: appBarBackgroundColor,
        shadowColor: appBarShadowColor,
        elevation: 2.0,
      ),
      body: view(context, advPlayer, widget.index, widget.book, widget.audioBook, widget.audioBytes),
    );
  }
}

Widget view(BuildContext context, AudioPlayer advancedPlayer, var index, var book, var audioBook, var audioBytes) {
  print("...in view of AudioBook");
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 2,
            padding: EdgeInsets.all(10.00),
            margin: EdgeInsets.all(10.00),
            color: Colors.yellow[700],
            alignment: Alignment.center,
            child: book["image"],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10.00),
          margin: EdgeInsets.all(10.00),
          child: Column(
            children: [
              Text(
                "${audioBook[index]["audioBookChapterName"]}",
                style: TextStyle(fontSize: 20.0),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "${book["bookName"]} by ${book["authorName"]}",
                style: TextStyle(fontSize: 15.0),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(10.00),
          padding: EdgeInsets.all(10.00),
          color: Colors.yellow[700],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //Audio line and Icons...
              AudioFile(advancedPlayer: advancedPlayer, index: index, book: book, audioBook: audioBook, audioBytes: audioBytes),
            ],
          ),
        ),
      ],
    ),
  );
}
