import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String url = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<dynamic>> fetchPosts() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print(data);
      return data;
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
