import 'package:flutter/material.dart';
import 'package:moviestack/controllers/index.dart'; // Import your TMDBApi

class MovieProvider with ChangeNotifier {
  final TMDBApi _tmdbApi = TMDBApi();
  List<dynamic> _movies = [];
  List<dynamic> _watchlist = [];
  List<dynamic> _ratedMovies = [];
  Map<int, dynamic> _movieDetailsCache = {}; // Cache for movie details
  Map<int, dynamic> _actorDetailsCache = {}; // Cache for actor details
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

  // Add to Watchlist
  void addToWatchlist(dynamic movie) {
    if (!_watchlist.any((item) => item['id'] == movie['id'])) {
      _watchlist.add(movie);
      notifyListeners();
    }
  }

  // Remove from Watchlist
  void removeFromWatchlist(dynamic movie) {
    _watchlist.removeWhere((item) => item['id'] == movie['id']);
    notifyListeners();
  }

  // Add Rating
  void addRating(int movieId, double rating) {
    final movie =
        _movies.firstWhere((item) => item['id'] == movieId, orElse: () => {});
    if (movie.isNotEmpty) {
      final ratedMovie = {...movie, 'rating': rating};
      if (_ratedMovies.any((item) => item['id'] == movieId)) {
        _ratedMovies.removeWhere((item) => item['id'] == movieId);
      }
      _ratedMovies.add(ratedMovie);
      notifyListeners();
    } else {
      print("Error: Movie not found for ID $movieId.");
    }
  }

  // Fetch Movie Details with Caching
  Future<dynamic> getMovieDetails(int id) async {
    if (_movieDetailsCache.containsKey(id)) {
      return _movieDetailsCache[id]; // Return cached data if available
    }

    try {
      final movie = await _tmdbApi.fetchMovieDetails(id); // Fetch from API
      _movieDetailsCache[id] = movie; // Cache the result
      return movie;
    } catch (e) {
      print("Error fetching movie details: $e");
      return null;
    }
  }

  // Fetch Actor Details with Caching
  Future<Map<String, dynamic>?> getActorDetails(int actorId) async {
    if (_actorDetailsCache.containsKey(actorId)) {
      return _actorDetailsCache[actorId]; // Return cached actor details
    }

    try {
      final actorDetails =
          await _tmdbApi.fetchActorDetails(actorId); // API call
      _actorDetailsCache[actorId] = actorDetails; // Cache the result
      return actorDetails;
    } catch (e) {
      print("Error fetching actor details: $e");
      return null; // Return null in case of error
    }
  }
}
