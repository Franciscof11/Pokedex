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
                    pokemon.name,
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
                      color: Colors.blue,
                    ),
                    child: Text(
                      pokemon.type,
                      style: GoogleFonts.nunito(
                        color: AppColors.primaryBlue,
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
                  child: CachedNetworkSvg(urlImage: pokemon.imageLink),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
