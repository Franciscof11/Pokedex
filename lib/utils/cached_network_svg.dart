import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/utils/app_colors.dart';

class CachedNetworkSvg extends StatelessWidget {
  final String urlImage;

  const CachedNetworkSvg({
    super.key,
    required this.urlImage,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _fetchSvg(urlImage),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryRed),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Icon(
              Icons.error,
              color: Colors.red,
            ),
          );
        } else if (snapshot.hasData) {
          return SvgPicture.string(
            snapshot.data ?? '',
          );
        } else {
          return const Center(child: Icon(Icons.error));
        }
      },
    );
  }

  Future<String> _fetchSvg(String urlImage) async {
    final dio = Dio();

    final cacheKey = urlImage;

    final cacheDir = await CachedNetworkImage(
      imageUrl: urlImage,
    ).cacheManager?.getFileFromCache(cacheKey);

    if (cacheDir != null && await cacheDir.file.exists()) {
      return await cacheDir.file.readAsString();
    } else {
      final response = await dio.get(urlImage);

      if (response.statusCode == 200) {
        await CachedNetworkImage(
          imageUrl: urlImage,
        ).cacheManager?.putFile(cacheKey, response.data);

        return response.data;
      } else {
        throw Exception('Falha ao carregar imagem!');
      }
    }
  }
}
