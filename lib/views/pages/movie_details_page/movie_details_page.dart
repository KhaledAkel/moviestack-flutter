import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moviestack/providers/movie_provider.dart';

class MovieDetailsPage extends StatelessWidget {
  final int movieId;

  const MovieDetailsPage({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return FutureBuilder(
      future: movieProvider.getMovieDetails(movieId),
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

        bool isInWatchlist =
            movieProvider.watchlist.any((item) => item['id'] == movieId);

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
                // Add to Watchlist Button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Toggle the watchlist status
                      if (isInWatchlist) {
                        movieProvider.removeFromWatchlist(movie);
                      } else {
                        movieProvider.addToWatchlist(movie);
                      }
                    },
                    child: Text(isInWatchlist
                        ? 'Remove from Watchlist'
                        : 'Add to Watchlist'),
                  ),
                ),
                // Rating Feature
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Rate this movie:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RatingWidget(
                    movieId: movieId,
                    currentRating: movie['vote_average'] ?? 0.0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class RatingWidget extends StatefulWidget {
  final int movieId;
  final double currentRating;

  const RatingWidget(
      {Key? key, required this.movieId, required this.currentRating})
      : super(key: key);

  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  late double rating;

  @override
  void initState() {
    super.initState();
    rating = widget.currentRating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            Icons.star,
            color: rating >= (index + 1)
                ? Colors.yellow
                : Colors.grey, // Change color based on rating
          ),
          onPressed: () {
            setState(() {
              rating = (index + 1).toDouble(); // Update the rating on click
            });
            // Call to MovieProvider to submit the rating
            Provider.of<MovieProvider>(context, listen: false).addRating(
                widget.movieId, rating); // Update the rating for the movie
          },
        );
      }),
    );
  }
}
