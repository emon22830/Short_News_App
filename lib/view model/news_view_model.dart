

import 'package:short_news_app/models/categories_news_model.dart';
import 'package:short_news_app/models/news_channel_headlines_model.dart';
import 'package:short_news_app/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  // Fetches news headlines from a specific news channel (e.g., BBC News)
  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi() async {
    final response = await _rep.fetchNewsChannelHeadlinesApi();
    return response;
  }

  // Fetches news based on a specific category (e.g., technology, health)
  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    final response = await _rep.fetchCategoriesNewsApi(category);
    return response;
  }
}
