import 'package:dio/dio.dart';

class TMDBApi {
  final Dio _dio = Dio();
  final String apiKey = "your_api_key_here";
  final String baseUrl = "https://api.themoviedb.org/3";

  Future<List<dynamic>> fetchTrendingMovies() async {
    try {
      final response = await _dio.get('$baseUrl/trending/movie/week',
          queryParameters: {'api_key': apiKey});
      return response.data['results'];
    } catch (e) {
      throw Exception("Failed to fetch trending movies");
    }
  }

  Future<List<dynamic>> fetchTrendingTVShows() async {
    try {
      final response = await _dio.get('$baseUrl/trending/tv/week',
          queryParameters: {'api_key': apiKey});
      return response.data['results'];
    } catch (e) {
      throw Exception("Failed to fetch trending TV shows");
    }
  }

  // Add other API calls like search, get details of movies, etc.
}
