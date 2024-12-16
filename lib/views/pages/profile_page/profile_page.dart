import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moviestack/providers/index.dart';
import 'package:moviestack/views/index.dart' show AppTopBar, AppBottomBar;

class ProfilePage extends StatelessWidget {
  final int selectedPage = 2;

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppTopBar(),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            // User Profile Information (Optional)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Profile Picture and Username
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                        'assets/images/profile_placeholder.png'), // Placeholder image
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Username", // Replace with dynamic username from user profile
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  // You can add options to toggle theme, language, etc. here
                ],
              ),
            ),
            // Tabs for Watchlist and Rated Movies
            TabBar(
              tabs: [
                Tab(text: 'Watchlist'),
                Tab(text: 'Rated Movies'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Watchlist Tab
                  movieProvider.watchlist.isEmpty
                      ? Center(child: Text("Your watchlist is empty"))
                      : ListView.builder(
                          itemCount: movieProvider.watchlist.length,
                          itemBuilder: (context, index) {
                            final item = movieProvider.watchlist[index];
                            return ListTile(
                              leading: item['poster_path'] != null
                                  ? Image.network(
                                      'https://image.tmdb.org/t/p/w200${item['poster_path']}')
                                  : Icon(
                                      Icons.movie), // Default icon if no poster
                              title: Text(item['title'] ?? "Untitled"),
                              onTap: () {
                                // Navigate to movie details (add navigation logic if necessary)
                              },
                            );
                          },
                        ),
                  // Rated Movies Tab
                  movieProvider.ratedMovies.isEmpty
                      ? Center(child: Text("No rated movies yet"))
                      : ListView.builder(
                          itemCount: movieProvider.ratedMovies.length,
                          itemBuilder: (context, index) {
                            final item = movieProvider.ratedMovies[index];
                            return ListTile(
                              leading: item['poster_path'] != null
                                  ? Image.network(
                                      'https://image.tmdb.org/t/p/w200${item['poster_path']}')
                                  : Icon(Icons.movie),
                              title: Text(item['title'] ?? "Untitled"),
                              subtitle:
                                  Text('Rating: ${item['rating'] ?? "N/A"}'),
                              onTap: () {
                                // Navigate to movie details (add navigation logic if necessary)
                              },
                            );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomBar(
        selectedPage: selectedPage,
      ),
    );
  }
}
