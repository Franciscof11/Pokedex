import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pokedex/utils/app_colors.dart';

class PokemonDetailStatsBar extends StatefulWidget {
  final String label;
  final double value;
  final Color colorBar;
  final double padding;
  const PokemonDetailStatsBar({
    super.key,
    required this.value,
    required this.label,
    required this.colorBar,
    required this.padding,
  });

  @override
  State<PokemonDetailStatsBar> createState() => _PokemonDetailStatsBarState();
}

class _PokemonDetailStatsBarState extends State<PokemonDetailStatsBar> {
  @override
  Widget build(BuildContext context) {
    final percent = widget.value >= 100 ? widget.value / 200 : widget.value / 100;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        children: [
          LinearPercentIndicator(
            barRadius: const Radius.circular(2.5),
            animation: true,
            animationDuration: 2000,
            leading: Padding(
              padding: EdgeInsets.only(right: widget.padding),
              child: Text(
                widget.label,
                style: GoogleFonts.nunito(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
            lineHeight: 12,
            percent: percent,
            backgroundColor: Colors.grey.withOpacity(0.1),
            progressColor: widget.colorBar,
          ),
        ],
      ),
    );
  }
}
