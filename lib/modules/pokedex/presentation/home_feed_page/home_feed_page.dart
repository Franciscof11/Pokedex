import 'package:flutter/material.dart';
import 'package:pokedex/modules/pokedex/data/pokedex_repository.dart';
import 'package:pokedex/modules/pokedex/domain/pokemon.dart';
import 'package:pokedex/modules/pokedex/presentation/pokemon_details_page/pokemon_details_page.dart';
import 'package:pokedex/utils/app_colors.dart';

import '../../../../utils/cached_network_svg.dart';
import '../widgets/search_widget.dart';

class HomeFeedPage extends StatefulWidget {
  const HomeFeedPage({super.key});

  @override
  State<HomeFeedPage> createState() => _HomeFeedPageState();
}

class _HomeFeedPageState extends State<HomeFeedPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Icon(
              Icons.menu,
              color: AppColors.primaryBlue,
              size: 30,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Image.asset(
              'assets/logo_inicie.png',
            ),
          ),
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: CircleAvatar(
                child: Icon(
                  Icons.person,
                  color: AppColors.primaryRed,
                ),
              ),
            )
          ],
        ),
        backgroundColor: AppColors.whiteIce,
        body: const SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SizedBox(height: 25),
              SearchWidget(),
            ],
          ),
        )),
      ),
    );
  }
}

class HomeFeedPage2 extends StatefulWidget {
  const HomeFeedPage2({super.key});

  @override
  HomeFeedPage2State createState() => HomeFeedPage2State();
}

class HomeFeedPage2State extends State<HomeFeedPage2> {
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
