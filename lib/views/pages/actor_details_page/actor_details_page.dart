import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moviestack/providers/movie_provider.dart'; // Make sure to import your MovieProvider

class ActorDetailsPage extends StatelessWidget {
  final int actorId;

  const ActorDetailsPage({Key? key, required this.actorId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch actor details from the MovieProvider
    return FutureBuilder(
      future: Provider.of<MovieProvider>(context, listen: false)
          .getActorDetails(actorId), // This fetches the actor details
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading spinner while fetching data
          return Scaffold(
            appBar: AppBar(title: Text("Actor Details")),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final actor = snapshot.data;
        if (actor == null) {
          // Handle case when actor details could not be fetched
          return Scaffold(
            appBar: AppBar(title: Text("Actor Details")),
            body: Center(child: Text("Failed to load actor details")),
          );
        }

        // Build the UI with fetched actor details
        return Scaffold(
          appBar: AppBar(title: Text(actor['name'] ?? 'Unknown Name')),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Actor's profile picture with fallback
                Center(
                  child: CircleAvatar(
                    backgroundImage: actor['profile_path'] != null
                        ? NetworkImage(
                            'https://image.tmdb.org/t/p/w500${actor['profile_path']}')
                        : AssetImage('assets/images/placeholder.png')
                            as ImageProvider,
                    radius: 80,
                  ),
                ),
                // Actor's name
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    actor['name'] ?? 'Unknown Name',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                // Actor's birthday
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Birthday: ${actor['birthday'] ?? 'N/A'}"),
                ),
                // Biography heading
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Biography:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                // Actor's biography
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(actor['biography'] ?? 'No biography available'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
