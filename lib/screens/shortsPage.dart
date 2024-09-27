import 'package:cross_platform_application/vimeoServiceClass.dart';
import'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShortsPage extends StatefulWidget{
  final String videoId;
  
  ShortsPage({required this.videoId});
  

  @override
  State<ShortsPage> createState() => _ShortsPageState();
}

class _ShortsPageState extends State<ShortsPage> {
  
  final VimeoService myVimeoService = VimeoService('177453d9951ec6b8896a55f0227e5b19');

  Map<String, dynamic>? _videoDetails;

  // void loadVideoDetails() async{
  //   final details = await myVimeoService.fetchVideoDetails(videoId);
  //   setState(() {
  //     _videoDetails = details;
  //   });
  // }

  // final String videoId = '862221161?share=copy';
  //
  // final String url = 'https://vimeo.com/$videoId';

  @override
  Widget build(BuildContext context) {

    // final String url = 'https://vimeo.com/$videoId';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 50.0,
        backgroundColor: Colors.white,
        title: Text("Video Player Example", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: HexColor("#212529"),),),
        centerTitle: true,
      ),
    );
  }
}
