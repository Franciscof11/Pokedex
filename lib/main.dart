import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/modules/pokedex/data/pokedex_repository.dart';
import 'package:pokedex/modules/pokedex/data/pokemon_repository.dart';
import 'modules/pokedex/presentation/welcome_page/welcome_page.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: false, // Enable this to test in different resolutions
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => PokedexRepository()),
        RepositoryProvider(create: (context) => PokemonRepository()),
      ],
      child: MaterialApp(
        title: 'Pokedex',
        builder: DevicePreview.appBuilder,
        locale: DevicePreview.locale(context),
        debugShowCheckedModeBanner: false,
        home: const WelcomePage(),
      ),
    );
  }
}
