import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:moviestack/providers/index.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for movies, TV shows, or actors',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (query) {
                movieProvider.search(query);
              },
            ),
          ),
          Expanded(
            child: movieProvider.movies.isEmpty
                ? Center(child: Text('No results yet. Start searching!'))
                : ListView.builder(
                    itemCount: movieProvider.movies.length,
                    itemBuilder: (context, index) {
                      final result = movieProvider.movies[index];
                      return ListTile(
                        leading: result['poster_path'] != null
                            ? Image.network(
                                'https://image.tmdb.org/t/p/w200${result['poster_path']}',
                                width: 50,
                              )
                            : SizedBox(width: 50),
                        title: Text(
                            result['title'] ?? result['name'] ?? 'Unknown'),
                        subtitle: Text(result['media_type'] ?? 'unknown'),
                        onTap: () {
                          final route = result['media_type'] == 'movie'
                              ? '/movie/${result['id']}'
                              : '/tv/${result['id']}';
                          context.go(route);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
