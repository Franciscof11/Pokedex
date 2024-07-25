part of 'pokedex_cubit.dart';

@freezed
class PokedexState with _$PokedexState {
  const factory PokedexState.initial() = _Initial;
  const factory PokedexState.loading() = _Loading;
  const factory PokedexState.data({required List<Pokemon> pokedex}) = _Data;
  const factory PokedexState.error({required String message}) = _Error;
}
