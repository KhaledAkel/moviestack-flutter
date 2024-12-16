import 'package:flutter/material.dart';
import 'package:moviestack/controllers/index.dart';

class MovieProvider with ChangeNotifier {
  final TMDBApi _tmdbApi = TMDBApi();
  List<dynamic> _movies = [];
  List<dynamic> _watchlist = [];
  List<dynamic> _ratedMovies = [];
  Map<int, dynamic> _movieDetailsCache = {};
  Map<int, dynamic> _actorDetailsCache = {};
  List<String> _recentSearches = [];

  List<dynamic> get movies => _movies;
  List<dynamic> get watchlist => _watchlist;
  List<dynamic> get ratedMovies => _ratedMovies;
  List<String> get recentSearches => _recentSearches;

  // Fetch Trending Movies
  Future<void> fetchTrendingMovies() async {
    try {
      _movies = await _tmdbApi.fetchTrendingMovies();
      notifyListeners();
    } catch (e) {
      print("Error fetching trending movies: $e");
    }
  }

  // Fetch Trending TV Shows
  Future<void> fetchTrendingTVShows() async {
    try {
      _movies = await _tmdbApi.fetchTrendingTVShows();
      notifyListeners();
    } catch (e) {
      print("Error fetching trending TV shows: $e");
    }
  }

  // Search for Movies, TV Shows, or Actors
  Future<void> search(String query) async {
    try {
      _movies = await _tmdbApi.search(query);
      if (!_recentSearches.contains(query)) {
        if (_recentSearches.length >= 10) {
          _recentSearches.removeAt(0); // Remove the oldest search
        }
        _recentSearches.add(query);
      }
      notifyListeners();
    } catch (e) {
      print("Error searching: $e");
    }
  }

  // Fetch Movie Details
  Future<dynamic> getMovieDetails(int id) async {
    if (_movieDetailsCache.containsKey(id)) {
      return _movieDetailsCache[id];
    }
    try {
      final details = await _tmdbApi.fetchMovieDetails(id);
      _movieDetailsCache[id] = details;
      notifyListeners();
      return details;
    } catch (e) {
      print("Error fetching movie details: $e");
      return null;
    }
  }

  // Fetch Actor Details
  Future<dynamic> getActorDetails(int id) async {
    if (_actorDetailsCache.containsKey(id)) {
      return _actorDetailsCache[id];
    }
    try {
      final details = await _tmdbApi.fetchActorDetails(id);
      _actorDetailsCache[id] = details;
      notifyListeners();
      return details;
    } catch (e) {
      print("Error fetching actor details: $e");
      return null;
    }
  }

  // Add to Watchlist
  void addToWatchlist(dynamic movie) {
    if (!_watchlist.any((item) => item['id'] == movie['id'])) {
      _watchlist.add(movie);
      notifyListeners();
    }
  }

  // Add Rating
  void addRating(dynamic movie, double rating) {
    final ratedMovie = {...movie, 'rating': rating};
    if (_ratedMovies.any((item) => item['id'] == movie['id'])) {
      _ratedMovies.removeWhere((item) => item['id'] == movie['id']);
    }
    _ratedMovies.add(ratedMovie);
    notifyListeners();
  }
}
