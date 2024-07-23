import 'package:flutter/material.dart';
import 'package:pokedex/modules/pokedex/presentation/home_feed_page/home_feed_page.dart';
import 'package:pokedex/modules/pokedex/presentation/pokemon_details_page/pokemon_details_page.dart';

import '../modules/pokedex/presentation/welcome_page/welcome_page.dart';

class AppRoutes {
  static String welcomePage = '/welcomePage';
  static String homeFeedPage = '/homeFeedPage';
  static String pokemonDetailsPage = '/pokemonDetailsPage';

  static Map<String, WidgetBuilder> routes = {
    welcomePage: (context) => const WelcomePage(),
    homeFeedPage: (context) => const HomeFeedPage(),
    pokemonDetailsPage: (context) => const PokemonDetailsPage(),
  };
}
