import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/config/database/pokedex/pokedex_db.dart';

import '../home_feed_page/cubit/pokedex_cubit.dart';

class SearchField extends StatelessWidget {
  SearchField({super.key});
  final pokemonNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            controller: pokemonNameController,
            decoration: const InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: IconButton(
            icon: const Icon(Icons.search),
            color: Colors.white,
            onPressed: () async {
              final pokedexDB = PokedexDB();

              final pokedexTable = await pokedexDB.getAll();

              if (context.mounted) {
                context.read<PokedexCubit>().searchPokemon(pokemonNameController.text, pokedexTable);

                FocusScope.of(context).unfocus();
              }
            },
          ),
        ),
      ],
    );
  }
}
