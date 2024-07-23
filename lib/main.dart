import 'package:flutter/material.dart';
import 'package:pokedex/modules/pokedex/presentation/home_feed_page/home_feed_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokémon Feed',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PokemonFeed(),
    );
  }
}
