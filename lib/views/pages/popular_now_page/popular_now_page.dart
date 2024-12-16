import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:moviestack/providers/index.dart' show MovieProvider;
import 'package:moviestack/views/index.dart' show AppTopBar, AppBottomBar;

class PopularNowPage extends StatelessWidget {
  final int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    movieProvider.fetchTrendingMovies();

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
                  onTap: () {
                    // Navigate to movie details screen
                    context.go('/movie/${movie['id']}');
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
