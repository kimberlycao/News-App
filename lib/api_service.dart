import 'package:http/http.dart' as http;
import 'model.dart';
import 'dart:convert';

class APIService {
  Future<NewsModel> getNews() async {
    var client = http.Client();
    var newsModel;

    try {
      var response = await client.get(
          'http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=a39a71d4243f4588a2a7c84b06b17ec8');
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = NewsModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return newsModel;
    }

    return newsModel;
  }
}
