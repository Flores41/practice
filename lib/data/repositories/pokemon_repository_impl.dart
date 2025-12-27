import 'package:flutter_application_1/data/datasources/remote/pokemon_remote_datasource.dart';
import 'package:flutter_application_1/domain/repositories/pokemon_repository.dart';

import '../../domain/entities/pokemon.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;

  PokemonRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Pokemon>> getPokemons() async {
    // 1. Llamamos al Datasource (que nos devuelve Models)
    final models = await remoteDataSource.getPokemons();

    // 2. Convertimos los Models a Entities (que es lo que la app entiende)
    // Esto mantiene limpia tu arquitectura: la UI nunca ve los modelos JSON.
    return models.map((model) => model.toEntity()).toList();
  }
}
