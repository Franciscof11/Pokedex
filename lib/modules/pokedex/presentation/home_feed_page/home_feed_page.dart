import 'package:flutter/material.dart';
import 'package:pokedex/modules/pokedex/data/pokedex_repository.dart';
import 'package:pokedex/modules/pokedex/domain/pokemon.dart';
import 'package:pokedex/modules/pokedex/presentation/pokemon_details_page/pokemon_details_page.dart';

import '../../../../utils/cached_network_svg.dart';

class HomeFeedPage extends StatefulWidget {
  const HomeFeedPage({super.key});

  @override
  HomeFeedPageState createState() => HomeFeedPageState();
}

class HomeFeedPageState extends State<HomeFeedPage> {
  final pokedexRepository = PokedexRepository();
  late Future<List<Pokemon>> futurePokemons;

  @override
  void initState() {
    super.initState();
    futurePokemons = pokedexRepository.getPokedex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon Feed'),
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: futurePokemons,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Pokémon found'));
          }

          final pokemons = snapshot.data!;

          return ListView.builder(
            itemCount: pokemons.length,
            itemBuilder: (context, index) {
              final pokemon = pokemons[index];
              return GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonDetailsPage(pokemon: pokemon))),
                child: ListTile(
                  leading: SizedBox(
                    width: 80,
                    height: 50,
                    child: CachedNetworkSvg(
                      urlImage: pokemon.imageLink,
                    ),
                  ),
                  title: Text(pokemon.name),
                  subtitle: Text('ID: ${pokemon.id}\nTypes: ${pokemon.type}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
