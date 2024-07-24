import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/modules/pokedex/domain/pokemon.dart';
import 'package:pokedex/utils/app_colors.dart';
import '../widgets/pokemon_list_tile.dart';
import '../widgets/search_widget.dart';
import '../widgets/type_list_widget.dart';

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
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: SearchWidget(),
            ),
            const SizedBox(height: 25),
            const TypeList(),
            const SizedBox(height: 15),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mais procurados",
                      style: GoogleFonts.nunito(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) => PokemonListTile(
                          pokemon: Pokemon(
                            id: 1,
                            name: 'Teste',
                            attack: 1,
                            defense: 2,
                            hp: 4,
                            imageLink: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/1.svg',
                            speed: 4,
                            type: 'grama',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
