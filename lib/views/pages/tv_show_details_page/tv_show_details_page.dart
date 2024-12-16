import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moviestack/providers/movie_provider.dart';

class TvShowDetailsPage extends StatelessWidget {
  final int tvShowId;

  const TvShowDetailsPage({Key? key, required this.tvShowId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<MovieProvider>(context, listen: false)
          .getMovieDetails(
              tvShowId), // Ensure to fetch TV show details correctly
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: Text("TV Show Details")),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final tvShow = snapshot.data;
        if (tvShow == null) {
          return Scaffold(
            appBar: AppBar(title: Text("TV Show Details")),
            body: Center(child: Text("Failed to load TV show details")),
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text(tvShow['name'] ?? 'Unknown Name')),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                    'https://image.tmdb.org/t/p/w500${tvShow['poster_path']}'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(tvShow['name'] ?? 'Unknown Name',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "First Air Date: ${tvShow['first_air_date'] ?? 'N/A'}"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Number of Seasons: ${tvShow['number_of_seasons'] ?? 'N/A'}"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Number of Episodes: ${tvShow['number_of_episodes'] ?? 'N/A'}"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Genres: ${tvShow['genres']?.map((e) => e['name']).join(', ') ?? 'N/A'}"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Overview:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(tvShow['overview'] ?? 'No overview available'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
