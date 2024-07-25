import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/modules/pokedex/data/pokemon_repository.dart';
import 'package:pokedex/modules/pokedex/domain/pokemon.dart';

class PokedexRepository {
  Future<List<Pokemon>> getPokedex() async {
    try {
      final dio = Dio();

      final response = await dio.get('https://pokeapi.co/api/v2/pokemon?limit=50');

      final responseMap = response.data['results'];

      List<Pokemon> pokemons = [];

      for (var result in responseMap) {
        final pokemonRepository = PokemonRepository();

        final pokemonDetail = await pokemonRepository.getPokemon(result['name']);

        pokemons.add(pokemonDetail);
      }

      return pokemons;
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
