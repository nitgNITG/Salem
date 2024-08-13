import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerExample extends StatefulWidget{
  const YoutubePlayerExample({Key? key,required this.url, required this.context2}) :super(key: key);
  final String url;
  final BuildContext context2;
  @override
  State<YoutubePlayerExample> createState() => _YoutubePlayerExampleState();
}

class _YoutubePlayerExampleState extends State<YoutubePlayerExample> {
  //final videoURL= "https://www.youtube.com/embed/OC8hjwxk6ro?si=YsZ4nZw37QqD9H90";
  late YoutubePlayerController _controller;
  @override
  void initState(){
    final videoID = YoutubePlayer.convertUrlToId(widget.url);
    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
          autoPlay: false
      ),
    );
    super.initState();
  }

  Widget build(BuildContext context) {
    return  Stack(children: [
      SizedBox(
          width: 290.0, // Adjust the width as needed
          height: 180.0, // Adjust the height as needed
          child:YoutubePlayer(
              bottomActions: const [],
              controller: _controller,
              aspectRatio : 16 / 9,
              onReady: ()  {_controller.pause();
              _controller.addListener(() {
                if(_controller.value.isPlaying) {_controller.pause();}
              });
              }, showVideoProgressIndicator: true
          )),
        ElevatedButton(
          style:ElevatedButton.styleFrom(backgroundColor: Colors.transparent,elevation: 0) ,
        onFocusChange: null,
        onHover: null,
        onLongPress: null,
        onPressed: () { print("ooooo___");
    Open(); },
    child:const SizedBox(
    width: 290.0, // Adjust the width as needed
    height: 180.0))
    ]);
  }

  Open()  {
    final videoID = YoutubePlayer.convertUrlToId(widget.url);
    YoutubePlayerController  _controller2 = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
          autoPlay: false
      ),
    );
   return showDialog(
      context: widget.context2,
      builder: (BuildContext context) {
        return WillPopScope(child:  AlertDialog(
          title: Align(alignment: Alignment.topLeft,child:   TextButton(
            child: const Text(
              'Close',
              style: TextStyle(fontSize: 13, color: Colors.white),
            ),
            onPressed: () async {
              await  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
              Navigator.pop(widget.context2);
            },
          )),
          contentPadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.all(10),
          backgroundColor: Colors.transparent,
          content: YoutubePlayer( // content of the alert dialog is our YT video
            controller: _controller2,
            aspectRatio : 16 / 9,
            onEnded: (i)async{
              if(_controller2.value.isFullScreen) {await  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);}
            Navigator.pop(widget.context2);},
            showVideoProgressIndicator: true,
            onReady: () => debugPrint('Ready'), // for debugging purposes only
            bottomActions: [
              CurrentPosition(),
              ProgressBar(
                isExpanded: true,
                colors: const ProgressBarColors(
                  playedColor: Colors.orange,
                  handleColor: Colors.orangeAccent,
                ),
              ),
              const PlaybackSpeedButton(),
              FullScreenButton(),
            ],
          )
        ), onWillPop: ()async{
          if(_controller2.value.isFullScreen) {await  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);}
          Navigator.pop(widget.context2);
          return false;
        });
      },
    );
  }
}
