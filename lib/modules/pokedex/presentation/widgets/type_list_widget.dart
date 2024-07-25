import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/config/database/pokedex/pokedex_db.dart';
import 'package:pokedex/modules/pokedex/presentation/home_feed_page/cubit/pokedex_cubit.dart';

import '../../../../utils/app_colors.dart';

class TypeList extends StatefulWidget {
  const TypeList({
    super.key,
  });

  @override
  TypeListState createState() => TypeListState();
}

class TypeListState extends State<TypeList> {
  int _typeIndex = 0;

  var typeList = [
    {
      "name": "All",
      "id": 0,
    },
    {
      "name": "Água",
      "id": 1,
    },
    {
      "name": "Fogo",
      "id": 2,
    },
    {
      "name": "Grama",
      "id": 3,
    },
    {
      "name": "Normal",
      "id": 4,
    },
    {
      "name": "Terra",
      "id": 5,
    },
    {
      "name": "Inseto",
      "id": 6,
    },
  ];

  void setBrandIndex(int currentIndex) {
    setState(() {
      _typeIndex = currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, bottom: 3),
          child: Text(
            "Tipo",
            style: GoogleFonts.nunito(
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
          ),
        ),
        SizedBox(
          height: 60,
          width: double.infinity,
          child: ListView.builder(
            itemCount: typeList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index == 0) {
                return GestureDetector(
                  onTap: () {
                    setBrandIndex(index);

                    context.read<PokedexCubit>().getPokedex();
                  },
                  child: TypeItem(
                    imgAsset: 'Todos',
                    index: 0,
                    isSelected: (_typeIndex == index) ? true : false,
                  ),
                );
              } else {
                return GestureDetector(
                  onTap: () async {
                    setBrandIndex(index);

                    final pokedexDB = PokedexDB();

                    final pokedexTable = await pokedexDB.getAll();

                    if (pokedexTable.isNotEmpty && context.mounted) {
                      context.read<PokedexCubit>().filterByType(index, pokedexTable);
                    }
                  },
                  child: TypeItem(
                    imgAsset: typeList[index]["name"].toString(),
                    index: index,
                    isSelected: (_typeIndex == index) ? true : false,
                  ),
                );
              }
            },
          ),
        )
      ],
    );
  }
}

class TypeItem extends StatelessWidget {
  final String imgAsset;
  final int index;
  final bool isSelected;

  const TypeItem({
    super.key,
    required this.imgAsset,
    required this.index,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: (index == 0) ? const EdgeInsets.fromLTRB(20, 12, 10, 12) : const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: (isSelected)
            ? Colors.blue
            : (index == 0)
                ? Colors.black12
                : Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 7,
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: (index == 0)
          ? Center(
              child: Text(
                "Todos",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : Text(
              imgAsset,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
    );
  }
}
