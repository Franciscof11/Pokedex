import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pokedex/modules/pokedex/domain/pokemon.dart';
import 'package:pokedex/modules/pokedex/presentation/home_feed_page/cubit/pokedex_cubit.dart';
import 'package:pokedex/modules/pokedex/presentation/pokemon_details_page/cubit/pokemon_cubit.dart';
import 'package:pokedex/modules/pokedex/presentation/pokemon_details_page/pokemon_details_page.dart';
import 'package:pokedex/utils/app_colors.dart';
import '../widgets/loader.dart';
import '../widgets/pokemon_list_tile.dart';
import '../widgets/search_widget.dart';
import '../widgets/type_list_widget.dart';

class HomeFeedPage extends StatefulWidget {
  const HomeFeedPage({super.key});

  @override
  State<HomeFeedPage> createState() => _HomeFeedPageState();
}

class _HomeFeedPageState extends State<HomeFeedPage> {
  bool _isVisible = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (_isVisible) {
        setState(() {
          _isVisible = false;
        });
      }
    } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      if (!_isVisible) {
        setState(() {
          _isVisible = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.whiteIce,
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: SearchWidget(),
              ),
              const SizedBox(height: 15),
              const TypeList(),
              const SizedBox(height: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Mais procurados",
                          style: GoogleFonts.nunito(
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Center(
                        child: Loader<PokedexCubit, PokedexState>(
                          selector: (state) => state.maybeWhen(
                            orElse: () => false,
                            loading: () => true,
                          ),
                        ),
                      ),
                      BlocSelector<PokedexCubit, PokedexState, List<Pokemon>>(
                        selector: (state) => state.maybeWhen(
                          data: (pokedex) => pokedex,
                          orElse: () => [],
                        ),
                        builder: (context, state) {
                          final pokedex = state;
                          return Expanded(
                            child: RefreshIndicator(
                              color: AppColors.primaryRed,
                              onRefresh: () async {
                                context.read<PokedexCubit>().getPokedex();
                              },
                              child: GridView.builder(
                                controller: _scrollController,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 2,
                                  childAspectRatio: 1.25,
                                ),
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: pokedex.length,
                                itemBuilder: (context, index) => GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    PageTransition(
                                      child: BlocProvider(
                                        create: (context) => PokemonCubit()..showPokemon(pokedex[index]),
                                        child: PokemonDetailsPage(pokemon: pokedex[index]),
                                      ),
                                      type: PageTransitionType.rightToLeft,
                                    ),
                                  ),
                                  child: PokemonListTile(
                                    pokemon: pokedex[index],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: _isVisible
                ? BottomNavigationBar(
                    selectedLabelStyle: GoogleFonts.nunito(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    unselectedLabelStyle: GoogleFonts.nunito(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.home_rounded,
                          color: AppColors.primaryBlue,
                        ),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.favorite_outline),
                        label: 'Favoritos',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person_outline),
                        label: 'Minha conta',
                      ),
                    ],

                    selectedItemColor: Colors.blue, // Change this to match your design
                    unselectedItemColor: Colors.grey, // Change this to match your design
                  )
                : const SizedBox.shrink(),
          ),
        ));
  }
}
