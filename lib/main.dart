import 'package:flutter/material.dart';
import 'package:pokedex/modules/pokedex/data/pokedex_repository.dart';
import 'package:pokedex/modules/pokedex/data/pokemon_repository.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: () async {
              final repository = PokemonRepository();

              final pokemon = await repository.getPokemon(1);

              print(pokemon.toString());
            },
            child: const Text('Hello World!'),
          ),
        ),
      ),
    );
  }
}
