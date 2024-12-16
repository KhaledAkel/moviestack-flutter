import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moviestack/providers/movie_provider.dart';

class ActorDetailsPage extends StatelessWidget {
  final int actorId;

  const ActorDetailsPage({Key? key, required this.actorId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<MovieProvider>(context, listen: false)
          .getActorDetails(actorId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: Text("Actor Details")),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final actor = snapshot.data;
        if (actor == null) {
          return Scaffold(
            appBar: AppBar(title: Text("Actor Details")),
            body: Center(child: Text("Failed to load actor details")),
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text(actor['name'] ?? 'Unknown Name')),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://image.tmdb.org/t/p/w500${actor['profile_path']}'),
                    radius: 80,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(actor['name'] ?? 'Unknown Name',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Birthday: ${actor['birthday'] ?? 'N/A'}"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Biography:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
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
