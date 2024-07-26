import 'package:pokedex/modules/pokedex/domain/pokemon.dart';
import 'package:sqflite/sqflite.dart';

import 'database_service.dart';

class PokedexDB {
  final tableName = 'pokedex';

  Future<void> createTable(Database database) async {
    await database.execute(
      """CREATE TABLE IF NOT EXISTS $tableName (
  "id" INTEGER NOT NULL,
  "name" TEXT NOT NULL,
  "type" TEXT NOT NULL,
  "imageLink" TEXT NOT NULL,
  "hp" INTEGER NOT NULL,
  "attack" INTEGER NOT NULL,
  "defense" INTEGER NOT NULL,
  "speed" INTEGER NOT NULL,
   PRIMARY KEY("name")
    );""",
    );
  }

  create({
    required List<Pokemon> pokedex,
  }) async {
    final database = await DatabaseService().database;

    for (var pokemon in pokedex) {
      await database.rawInsert(
        '''INSERT INTO $tableName (id, name, type, imageLink, hp, attack, defense, speed) VALUES (?,?,?,?,?,?,?,?)''',
        [pokemon.id, pokemon.name, pokemon.type, pokemon.imageLink, pokemon.hp, pokemon.attack, pokemon.defense, pokemon.speed],
      );
    }
  }

  Future<List<Pokemon>> getAll() async {
    final database = await DatabaseService().database;
    final pokedex = await database.rawQuery(
      '''SELECT * from $tableName''',
    );
    return pokedex.map((pokemon) => Pokemon.fromDatabase(pokemon)).toList();
  }
}
