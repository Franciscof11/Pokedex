import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class CachedNetworkSvg extends StatelessWidget {
  final String url;

  const CachedNetworkSvg({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _fetchSvg(url),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Icon(Icons.error));
        } else if (snapshot.hasData) {
          return SvgPicture.string(
            snapshot.data!,
          );
        } else {
          return const Center(child: Icon(Icons.error));
        }
      },
    );
  }

  Future<String> _fetchSvg(String url) async {
    final cacheKey = url;
    final cacheDir = await CachedNetworkImage(
      imageUrl: url,
    ).cacheManager?.getFileFromCache(cacheKey);
    if (cacheDir != null && await cacheDir.file.exists()) {
      return await cacheDir.file.readAsString();
    } else {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        await CachedNetworkImage(
          imageUrl: url,
        ).cacheManager?.putFile(cacheKey, response.bodyBytes);
        return response.body;
      } else {
        throw Exception('Falha ao carregar SVG');
      }
    }
  }
}
