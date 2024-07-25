import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pokedex/modules/pokedex/data/pokedex_repository.dart';
import 'package:pokedex/modules/pokedex/presentation/home_feed_page/cubit/pokedex_cubit.dart';
import 'package:pokedex/modules/pokedex/presentation/home_feed_page/home_feed_page.dart';
import 'package:pokedex/utils/app_colors.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteIce,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Image.asset(
              'assets/welcome_image.png',
              width: 450,
              height: 450,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text.rich(
                TextSpan(
                  text: 'Explore o mundo dos ',
                  children: [
                    TextSpan(
                      text: 'Pokémons',
                      style: GoogleFonts.nunito(
                        color: AppColors.primaryRed,
                        fontWeight: FontWeight.w700,
                        fontSize: 44,
                      ),
                    )
                  ],
                ),
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.w700,
                  fontSize: 44,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Descubra todas as espécies de Pokémons',
              style: GoogleFonts.nunito(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 35),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryRed.withOpacity(0.5),
                    spreadRadius: 8,
                    blurRadius: 15,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: BlocProvider(
                        create: (context) => PokedexCubit(repository: context.read<PokedexRepository>())..getPokedex(),
                        child: const HomeFeedPage(),
                      ),
                      type: PageTransitionType.rightToLeft,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryRed,
                  fixedSize: const Size(250, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Começar',
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}
