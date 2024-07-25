import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pokedex/modules/pokedex/presentation/pokemon_details_page/cubit/pokemon_cubit.dart';
import 'package:pokedex/utils/app_colors.dart';
import '../../../../utils/cached_network_svg.dart';
import '../../domain/pokemon.dart';
import '../widgets/pokemon_detail_stats_bar.dart';

class PokemonDetailsPage extends StatefulWidget {
  final Pokemon pokemon;
  const PokemonDetailsPage({super.key, required this.pokemon});

  @override
  PokemonDetailsPageState createState() => PokemonDetailsPageState();
}

class PokemonDetailsPageState extends State<PokemonDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteIce,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.primaryBlue,
              size: 30,
            ),
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
      body: SingleChildScrollView(
          child: BlocSelector<PokemonCubit, PokemonState, Pokemon>(
        selector: (state) => state.maybeWhen(
          data: (pokedex) => pokedex,
          orElse: () => Pokemon.empty(),
        ),
        builder: (context, state) {
          final pokemon = state;
          final pokemonName = '${pokemon.name[0].toUpperCase()}${pokemon.name.substring(1)}';
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 320,
                    decoration: const BoxDecoration(
                        color: AppColors.whiteIce,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      width: 280,
                      height: 280,
                      child: CachedNetworkSvg(urlImage: pokemon.imageLink),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pokemonName,
                          style: GoogleFonts.nunito(
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Cod: #${pokemon.id.toString()}',
                          style: GoogleFonts.nunito(
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.favorite_border,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.share_outlined,
                              color: Colors.grey,
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        Container(
                          width: 70,
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
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 45),
              PokemonDetailStatsBar(
                label: 'Vida',
                padding: 35,
                colorBar: Colors.orange,
                value: pokemon.hp.toDouble(),
              ),
              const SizedBox(height: 22),
              PokemonDetailStatsBar(
                label: 'Defesa',
                padding: 19,
                colorBar: Colors.lightGreenAccent,
                value: pokemon.defense.toDouble(),
              ),
              const SizedBox(height: 22),
              PokemonDetailStatsBar(
                label: 'Ataque',
                padding: 18,
                colorBar: Colors.red[400]!,
                value: pokemon.attack.toDouble(),
              ),
              const SizedBox(height: 35),
              Center(
                child: CircularPercentIndicator(
                  radius: 50,
                  lineWidth: 14,
                  animation: true,
                  animationDuration: 2000,
                  percent: pokemon.attack.toDouble() / 100,
                  center: Text(
                    pokemon.speed.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  footer: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "Velocidade",
                      style: GoogleFonts.nunito(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.blue,
                ),
              ),
              const SizedBox(height: 22),
            ],
          );
        },
      )),
    );
  }
}
