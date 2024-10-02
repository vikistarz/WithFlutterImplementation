import'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {

  String videoId = "";
  String accessToken = "5255c0888f8975cd1b11b5b473c39f06";
  late VideoPlayerController myVideoController;


  @override
  void initState() {
   super.initState();
   // initializePlayer();
  }


  Future<String> fetchVimeoVideosUrl(String videoId, String accessToken) async {
    final url = 'https://api.vimeo.com/videos/$videoId';
    final response =  await  http.get(Uri.parse(url),
      headers: {
        'Authorization' : 'Bearer $accessToken',
      },
    );
    if(response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final videoFiles = jsonData['files'];
      final bestQualityFile = videoFiles.firstWhere((files)=> files['quality'] == 'hd');
      return bestQualityFile['link'];
    }
    else {
      print('Error: ${response.statusCode}');
      throw Exception('failed to load video');
    }
  }

  Future<void> initializePlayer() async{
    final videoUrl = await fetchVimeoVideosUrl(videoId, accessToken);

    myVideoController = VideoPlayerController.network(videoUrl)..initialize().then((_) {
      setState(() {

      });
    });
  }


  @override
  void dispose() {
    myVideoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50.0,
        backgroundColor: Colors.white,
        title: Text("Video Player Example", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: HexColor("#212529"),),),
        centerTitle: true,
      ),
      body: Center(
        child: myVideoController.value.isInitialized ? AspectRatio(
            aspectRatio: myVideoController.value.aspectRatio,
        child: VideoPlayer(myVideoController),
        )
            :
            CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            myVideoController.value.isPlaying ?
                myVideoController.pause() :
                myVideoController.play();
          });
        },
        child: Icon(myVideoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

}

