import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:moviestack/views/index.dart' show AppTheme, router;
import 'package:moviestack/providers/index.dart' show MovieProvider;

void main() {
  // await dotenv.load(); // Load .env file
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MovieProvider(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'MovieStack',
        routerConfig: router,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
