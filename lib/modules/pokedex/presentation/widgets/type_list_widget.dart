import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/app_colors.dart';

class TypeList extends StatefulWidget {
  const TypeList({
    super.key,
  });

  @override
  TypeListState createState() => TypeListState();
}

class TypeListState extends State<TypeList> {
  int _brandCategoryIndex = 0;

  var typeList = [
    {
      "name": "Fogo",
      "icon": "",
      "id": 0,
    },
    {
      "name": "Água",
      "icon": "assets/icons/chevrolet_icon.png",
      "id": 1,
    },
    {
      "name": "Terra",
      "icon": "assets/icons/volks_icon.png",
      "id": 2,
    },
    {
      "name": "Ar",
      "icon": "assets/icons/toyota_icon.png",
      "id": 3,
    },
    {
      "name": "Pedra",
      "icon": "assets/icons/toyota_icon.png",
      "id": 3,
    },
  ];

  void setBrandIndex(int currentIndex) {
    setState(() {
      _brandCategoryIndex = currentIndex;
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
                    debugPrint(typeList[index]["name"].toString());
                  },
                  child: BrandItem(
                    imgAsset: 'Todos',
                    index: 0,
                    isSelected: (_brandCategoryIndex == index) ? true : false,
                  ),
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    setBrandIndex(index);
                    debugPrint(typeList[index]["name"].toString());
                  },
                  child: BrandItem(
                    imgAsset: typeList[index]["name"].toString(),
                    index: index,
                    isSelected: (_brandCategoryIndex == index) ? true : false,
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

class BrandItem extends StatelessWidget {
  final String imgAsset;
  final int index;
  final bool isSelected;

  const BrandItem({
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
