import 'dart:convert';
import 'package:http/http.dart' as http;
class VimeoService{
  final String accessToken;

  VimeoService(this. accessToken);

  Future<Map<String, dynamic>?>
  fetchVideoDetails(String videoId) async{
    final url = 'https://api.vimeo.com/videos/$videoId';
    final response = await http.get(Uri.parse(url),
    headers: {
      'Authorization' : 'Bearer $accessToken',
    },
    );

    if(response.statusCode == 200) {
      return json.decode(response.body);
    }
    else {
      print('Error: ${response.statusCode}');
      return null;
    }
  }
}