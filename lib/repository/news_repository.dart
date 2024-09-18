import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:short_news_app/models/categories_news_model.dart';
import 'package:short_news_app/models/news_channel_headlines_model.dart';

class NewsRepository {

  // Method to fetch news headlines from a specific channel (e.g., BBC News)
  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi() async {
    String url = 'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=83ec704307c44101912106064b61fa8c';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return NewsChannelHeadlinesModel.fromJson(body);
    } else {
      throw Exception('Error fetching channel headlines');
    }
  }

  // Method to fetch news based on a specific category
  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    String url = 'https://newsapi.org/v2/everything?q=$category&apiKey=83ec704307c44101912106064b61fa8c';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return CategoriesNewsModel.fromJson(body);
    } else {
      throw Exception('Error fetching category news');
    }
  }
}
