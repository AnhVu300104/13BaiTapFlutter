import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_lessons/lessons/bai13_news/article.dart';

class NewsService {
  static const String _apiKey = 'a8794d9535974bb19a6cb9c18da4a74d';
  static const String _baseUrl = 'https://newsapi.org/v2';

  // Lấy tin tức top headlines
  Future<List<Article>> getTopHeadlines({String country = 'us'}) async {
    try {
      final url = Uri.parse(
        '$_baseUrl/top-headlines?country=$country&apiKey=$_apiKey',
      );
      
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> articles = data['articles'];
        
        return articles
            .map((json) => Article.fromJson(json))
            .where((article) => article.urlToImage != null)
            .toList();
      } else {
        throw Exception('Không thể tải tin tức');
      }
    } catch (e) {
      throw Exception('Lỗi kết nối: $e');
    }
  }

  // Tìm kiếm tin tức theo từ khóa
  Future<List<Article>> searchNews(String query) async {
    try {
      final url = Uri.parse(
        '$_baseUrl/everything?q=$query&sortBy=publishedAt&apiKey=$_apiKey',
      );
      
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> articles = data['articles'];
        
        return articles
            .map((json) => Article.fromJson(json))
            .where((article) => article.urlToImage != null)
            .toList();
      } else {
        throw Exception('Không thể tìm kiếm tin tức');
      }
    } catch (e) {
      throw Exception('Lỗi kết nối: $e');
    }
  }
}