import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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

      final pokedex = await _repository.getPokedex();

      emit(PokedexState.data(pokedex: pokedex));
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
}
