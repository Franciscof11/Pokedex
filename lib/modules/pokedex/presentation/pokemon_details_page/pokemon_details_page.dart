import 'package:flutter/material.dart';
import 'package:pokedex/modules/pokedex/data/pokemon_repository.dart';

import '../../../../utils/cached_network_svg.dart';
import '../../domain/pokemon.dart';

class PokemonDetailsPage extends StatefulWidget {
  final Pokemon? pokemon;
  const PokemonDetailsPage({super.key, this.pokemon});

  @override
  PokemonDetailsPageState createState() => PokemonDetailsPageState();
}

class PokemonDetailsPageState extends State<PokemonDetailsPage> {
  late Future<Pokemon> futurePokemon;
  final pokemonRepository = PokemonRepository();

  @override
  void initState() {
    super.initState();
    futurePokemon = pokemonRepository.getPokemon(widget.pokemon?.name ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Tela'),
      ),
      body: FutureBuilder<Pokemon>(
        future: futurePokemon,
        builder: (context, snapshot) {
          final pokemon = snapshot.data ?? Pokemon.empty();
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Nenhum dado disponível'));
          } else {
            return Column(
              children: [
                Text(
                  pokemon.name,
                  style: const TextStyle(color: Colors.amber, fontSize: 20),
                ),
                const SizedBox(height: 30),
                CachedNetworkSvg(urlImage: pokemon.imageLink),
                /*             CachedNetworkImage(
                  imageUrl: pokemon.imageLink,
                  
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  width: 400,
                ), */
              ],
            );
          }
        },
      ),
    );
  }
}
