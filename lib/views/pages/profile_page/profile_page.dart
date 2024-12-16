import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moviestack/providers/index.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('My Profile')),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(tabs: [
              Tab(text: 'Watchlist'),
              Tab(text: 'Rated Movies'),
            ]),
            Expanded(
              child: TabBarView(
                children: [
                  ListView.builder(
                    itemCount: movieProvider.watchlist.length,
                    itemBuilder: (context, index) {
                      final item = movieProvider.watchlist[index];
                      return ListTile(
                        leading: Image.network(
                            'https://image.tmdb.org/t/p/w200${item['poster_path']}'),
                        title: Text(item['title']),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: movieProvider.ratedMovies.length,
                    itemBuilder: (context, index) {
                      final item = movieProvider.ratedMovies[index];
                      return ListTile(
                        leading: Image.network(
                            'https://image.tmdb.org/t/p/w200${item['poster_path']}'),
                        title: Text(item['title']),
                        subtitle: Text('Rating: ${item['rating']}'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
