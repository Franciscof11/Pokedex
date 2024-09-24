import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/modules/pokedex/domain/pokemon.dart';
import 'package:pokedex/utils/app_colors.dart';
import 'package:pokedex/utils/cached_network_svg.dart';

class PokemonListTile extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonListTile({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final pokemonName = '${pokemon.name[0].toUpperCase()}${pokemon.name.substring(1)}';

    Color selectColor(String type) {
      switch (type) {
        case 'water':
          return Colors.blue;
        case 'fire':
          return Colors.orange;
        case 'grass':
          return Colors.green;
        case 'normal':
          return Colors.grey[800]!;
        case 'ground':
          return Colors.brown;
        case 'bug':
          return Colors.purple[700]!;
        case 'electric':
          return Colors.yellow;
      }

      return Colors.black;
    }

    String translateType(String type) {
      switch (type) {
        case 'water':
          return 'Água';
        case 'fire':
          return 'Fogo';
        case 'grass':
          return 'Grama';
        case 'normal':
          return 'Normal';
        case 'ground':
          return 'Terra';
        case 'bug':
          return 'Inseto';
        case 'electric':
          return 'Elétrico';

        case 'fairy':
          return 'Fada';
      }

      return type;
    }

    return Card(
      elevation: 8,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    pokemonName,
                    style: GoogleFonts.nunito(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: 55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: selectColor(pokemon.type),
                    ),
                    child: Text(
                      translateType(pokemon.type),
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '#${pokemon.id}',
                    style: GoogleFonts.nunito(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    child: Image.asset(
                      'assets/background_tile.png',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Hero(
                    tag: pokemon.id,
                    child: CachedNetworkSvg(urlImage: pokemon.imageLink),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
