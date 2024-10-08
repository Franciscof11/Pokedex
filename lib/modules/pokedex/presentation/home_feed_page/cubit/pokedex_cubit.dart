import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokedex/config/database/pokedex/pokedex_db.dart';
import 'package:pokedex/modules/pokedex/data/pokedex_repository.dart';

import '../../../domain/pokemon.dart';

part 'pokedex_state.dart';
part 'pokedex_cubit.freezed.dart';

class PokedexCubit extends Cubit<PokedexState> {
  final PokedexRepository _repository;

  PokedexCubit({
    required PokedexRepository repository,
  })  : _repository = repository,
        super(const PokedexState.initial());

  Future<void> getPokedex() async {
    try {
      emit(const PokedexState.loading());

      final pokedexDB = PokedexDB();

      final pokedexTable = await pokedexDB.getAll();

      if (pokedexTable.isEmpty) {
        final pokedex = await _repository.getPokedex();

        pokedexDB.create(pokedex: pokedex);

        emit(PokedexState.data(pokedex: pokedex));
      } else if (pokedexTable.isNotEmpty) {
        final pokedex = await pokedexDB.getAll();

        emit(PokedexState.data(pokedex: pokedex));
      }
    } catch (e) {
      log(
        'Error!',
        error: e,
      );
      emit(const PokedexState.error(message: 'Error!'));
    }
  }

  Future<void> searchPokemon(String pokemonName, List<Pokemon> pokedex) async {
    try {
      emit(const PokedexState.loading());

      final filteredPokemon = pokedex.where((pokemon) => pokemon.name.toLowerCase().contains(pokemonName.toLowerCase())).toList();

      emit(PokedexState.data(pokedex: filteredPokemon));
    } catch (e) {
      log(
        'Error!',
        error: e,
      );
      emit(const PokedexState.error(message: 'Error!'));
    }
  }

  Future<void> filterByType(int typeId, List<Pokemon> pokedex) async {
    try {
      emit(const PokedexState.loading());

      List<Pokemon> filteredPokedex = pokedex;
      filter(String type) {
        filteredPokedex = pokedex.where((pokemon) {
          if (pokemon.type == type) return true;
          return false;
        }).toList();
      }

      switch (typeId) {
        case 0:
        case 1:
          filter("water");

        case 2:
          filter("fire");

        case 3:
          filter("grass");

        case 4:
          filter("normal");

        case 5:
          filter("ground");

        case 6:
          filter("bug");
      }

      emit(PokedexState.data(pokedex: filteredPokedex));
    } catch (e) {
      log(
        'Error!',
        error: e,
      );
      emit(const PokedexState.error(message: 'Error!'));
    }
  }
}
