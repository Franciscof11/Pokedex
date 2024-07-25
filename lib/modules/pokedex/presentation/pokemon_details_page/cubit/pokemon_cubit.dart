import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokedex/modules/pokedex/domain/pokemon.dart';

part 'pokemon_state.dart';
part 'pokemon_cubit.freezed.dart';

class PokemonCubit extends Cubit<PokemonState> {
  PokemonCubit() : super(const PokemonState.initial());

  Future<void> showPokemon(Pokemon pokemon) async {
    try {
      emit(const PokemonState.loading());

      emit(PokemonState.data(pokemon: pokemon));
    } catch (e) {
      log(
        'Error!',
        error: e,
      );
      emit(const PokemonState.error(message: 'Error!'));
    }
  }
}
