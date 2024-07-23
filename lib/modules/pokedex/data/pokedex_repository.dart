import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/modules/pokedex/domain/pokemon.dart';

class PokedexRepository {
  Future<List<Pokemon>> getPokedex() async {
    try {
      final dio = Dio();

      final response = await dio.get('https://pokeapi.co/api/v2/pokemon?limit=20');

      final responseMap = response.data['results'];

      final pokedex = responseMap.map<Pokemon>((pokemon) => Pokemon.fromMap(pokemon)).toList();

      return pokedex;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        debugPrint('Server Error: ${e.response?.statusCode} - ${e.response?.statusMessage}');
      } else if (e.type == DioExceptionType.connectionTimeout) {
        debugPrint('Connection Timeout Error');
      }

      rethrow;
    } catch (e) {
      debugPrint('Unexpected Error: $e');

      return [];
    }
  }
}
