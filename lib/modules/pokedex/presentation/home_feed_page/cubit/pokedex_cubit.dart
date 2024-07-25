import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

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

        debugPrint('## FROM HTTP ');
        for (var pokemon in pokedex) {
          debugPrint(pokemon.toString());
        }
      } else if (pokedexTable.isNotEmpty) {
        final pokedex = await pokedexDB.getAll();

        emit(PokedexState.data(pokedex: pokedex));

        debugPrint('## FROM DATABASE ');
        debugPrint(pokedex.toString());
      }
    } catch (e) {
      log(
        'Error!',
        error: e,
      );
      emit(const PokedexState.error(message: 'Error!'));
    }
  }

  Future<void> searchPokemon(String pokemonName) async {
    try {
      emit(const PokedexState.loading());

      final pokedex = await _repository.getPokedex();

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

  Future<void> filterByType(int typeId) async {
    try {
      emit(const PokedexState.loading());

      final pokedex = await _repository.getPokedex();

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
          filter("air");

        case 6:
          filter("rock");
      }
      print(filteredPokedex);
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
