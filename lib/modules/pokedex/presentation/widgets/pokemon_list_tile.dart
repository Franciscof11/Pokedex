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
      color: AppColors.whiteIce,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  pokemon.name,
                  style: GoogleFonts.nunito(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 7,
                        spreadRadius: 0.5,
                      ),
                    ],
                  ),
                  child: Text(
                    pokemon.type,
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '#${pokemon.id}',
                  style: GoogleFonts.nunito(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CachedNetworkSvg(urlImage: pokemon.imageLink),
          ),
        ],
      ),
    );
  }
}
