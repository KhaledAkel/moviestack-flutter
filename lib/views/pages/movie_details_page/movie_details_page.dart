import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moviestack/providers/movie_provider.dart';

class MovieDetailsPage extends StatelessWidget {
  final int movieId;

  const MovieDetailsPage({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<MovieProvider>(context, listen: false)
          .getMovieDetails(movieId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: Text("Movie Details")),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final movie = snapshot.data;
        if (movie == null) {
          return Scaffold(
            appBar: AppBar(title: Text("Movie Details")),
            body: Center(child: Text("Failed to load movie details")),
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text(movie['title'] ?? 'Unknown Title')),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                    'https://image.tmdb.org/t/p/w500${movie['poster_path']}'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(movie['title'] ?? 'Unknown Title',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Text("Release Date: ${movie['release_date'] ?? 'N/A'}"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Rating: ${movie['vote_average']?.toStringAsFixed(1) ?? 'N/A'}"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Overview:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(movie['overview'] ?? 'No overview available'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
