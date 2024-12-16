import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moviestack/providers/index.dart' show MovieProvider;
import 'package:moviestack/views/index.dart' show AppTopBar, AppBottomBar;

class SearchPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final int selectedPage = 1;
  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppTopBar(),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "Search Movies/TV Shows"),
            onChanged: (query) => movieProvider.search(query),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: movieProvider.movies.length,
              itemBuilder: (context, index) {
                final item = movieProvider.movies[index];
                return ListTile(
                  leading: Image.network(
                      'https://image.tmdb.org/t/p/w500${item['poster_path']}'),
                  title: Text(item['title'] ?? item['name']),
                  onTap: () {
                    if (item['media_type'] == 'movie') {
                    } else if (item['media_type'] == 'tv') {}
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomBar(selectedPage: selectedPage),
    );
  }
}
