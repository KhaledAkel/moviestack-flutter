import 'package:dio/dio.dart';

class TMDBApi {
  final Dio _dio = Dio();
  final String apiKey =
      '922fc17a3813316c16d0896fb4b23b3b'; // Replace with your API Key
  final String baseUrl = "https://api.themoviedb.org/3";

  TMDBApi() {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MjJmYzE3YTM4MTMzMTZjMTZkMDg5NmZiNGIyM2IzYiIsIm5iZiI6MTczNDM2NTI1MS43MTI5OTk4LCJzdWIiOiI2NzYwNTA0M2JlNDQ3YmU2MDE2ZWM0YmEiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.6a1C00GfRhFqCeNRQqzedgZplX8uotVLGqToJ6IaCqQ',
      },
    );
  }

  // Fetch Trending Movies
  Future<List<dynamic>> fetchTrendingMovies() async {
    try {
      final response = await _dio
          .get('/trending/movie/week', queryParameters: {'api_key': apiKey});
      return response.data['results'];
    } catch (e) {
      throw Exception("Failed to fetch trending movies: $e");
    }
  }

  // Fetch Trending TV Shows
  Future<List<dynamic>> fetchTrendingTVShows() async {
    try {
      final response = await _dio
          .get('/trending/tv/week', queryParameters: {'api_key': apiKey});
      return response.data['results'];
    } catch (e) {
      throw Exception("Failed to fetch trending TV shows: $e");
    }
  }

  // Search Movies, TV Shows, or Actors
  Future<List<dynamic>> search(String query) async {
    try {
      final response = await _dio.get('/search/multi', queryParameters: {
        'api_key': apiKey,
        'query': query,
      });
      return response.data['results'];
    } catch (e) {
      throw Exception("Failed to search: $e");
    }
  }

  // Fetch Movie Details
  Future<dynamic> fetchMovieDetails(int id) async {
    try {
      final response =
          await _dio.get('/movie/$id', queryParameters: {'api_key': apiKey});
      return response.data;
    } catch (e) {
      throw Exception("Failed to fetch movie details: $e");
    }
  }

  // Fetch TV Show Details
  Future<dynamic> fetchTVShowDetails(int id) async {
    try {
      final response =
          await _dio.get('/tv/$id', queryParameters: {'api_key': apiKey});
      return response.data; // Returns TV Show details
    } catch (e) {
      throw Exception("Failed to fetch TV show details: $e");
    }
  }

  // Fetch Actor Details
  Future<dynamic> fetchActorDetails(int id) async {
    try {
      final response =
          await _dio.get('/person/$id', queryParameters: {'api_key': apiKey});
      return response.data;
    } catch (e) {
      throw Exception("Failed to fetch actor details: $e");
    }
  }
}
