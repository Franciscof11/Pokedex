import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/modules/pokedex/domain/pokemon.dart';

class PokemonRepository {
  Future<Pokemon> getPokemon(int id) async {
    try {
      final dio = Dio();

      final response = await dio.get('https://pokeapi.co/api/v2/pokemon/$id/');

      final responseMap = response.data;

      final pokemon = Pokemon.fromMap(responseMap);

      return pokemon;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        debugPrint('Server Error: ${e.response?.statusCode} - ${e.response?.statusMessage}');
      } else if (e.type == DioExceptionType.connectionTimeout) {
        debugPrint('Connection Timeout Error');
      }

      rethrow;
    } catch (e) {
      debugPrint('Unexpected Error: $e');

      return Pokemon.empty();
    }
  }
}
