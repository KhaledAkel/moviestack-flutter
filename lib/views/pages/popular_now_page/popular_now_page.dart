import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:moviestack/providers/index.dart'; // Import your movie provider
import 'package:moviestack/views/index.dart' show AppTopBar, AppBottomBar;

class PopularNowPage extends StatefulWidget {
  @override
  _PopularNowPageState createState() => _PopularNowPageState();
}

class _PopularNowPageState extends State<PopularNowPage> {
  final int selectedPage = 0;

  @override
  void initState() {
    super.initState();
    // Fetch movies once when the page is first loaded
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    movieProvider.fetchTrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppTopBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: movieProvider.movies.length,
              itemBuilder: (context, index) {
                final movie = movieProvider.movies[index];

                return ListTile(
                  leading: Image.network(
                      'https://image.tmdb.org/t/p/w500${movie['poster_path']}'),
                  title: Text(movie['title'] ?? 'Unknown Title'),
                  subtitle: Text(movie['release_date'] ?? 'Release Date N/A'),
                  onTap: () {
                    // Navigate to the movie details page
                    context.push('/movie/${movie['id']}');
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomBar(
        selectedPage: selectedPage,
      ),
    );
  }
}
