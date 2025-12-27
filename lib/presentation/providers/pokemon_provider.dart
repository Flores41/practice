import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/graphql_config.dart';
import '../../data/datasources/remote/pokemon_remote_datasource.dart';
import '../../data/repositories/pokemon_repository_impl.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../../domain/entities/pokemon.dart';

// 1. Provider del Datasource
// Necesita el cliente de GraphQL que creamos antes
final pokemonRemoteDataSourceProvider = Provider<PokemonRemoteDataSource>((
  ref,
) {
  final client = ref.read(graphQLClientProvider);
  return PokemonRemoteDataSource(client: client);
});

// 2. Provider del Repositorio
// Necesita el Datasource
final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  final dataSource = ref.read(pokemonRemoteDataSourceProvider);
  return PokemonRepositoryImpl(dataSource);
});

// 3. El Provider de la Lista de Pokemones (El que usará la UI)
// Usamos 'FutureProvider' porque la llamada es asíncrona (demora un poco)
final pokemonListProvider = FutureProvider<List<Pokemon>>((ref) async {
  // Obtenemos el repositorio
  final repository = ref.read(pokemonRepositoryProvider);
  // Pedimos los datos
  return await repository.getPokemons();
});
