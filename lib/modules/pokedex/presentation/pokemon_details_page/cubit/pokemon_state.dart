part of 'pokemon_cubit.dart';

@freezed
class PokemonState with _$PokemonState {
  const factory PokemonState.initial() = _Initial;
  const factory PokemonState.loading() = _Loading;
  const factory PokemonState.data({required Pokemon pokemon}) = _Data;
  const factory PokemonState.error({required String message}) = _Error;
}
