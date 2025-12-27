import 'package:flutter_application_1/data/models/pokemon_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PokemonRemoteDataSource {
  final GraphQLClient client;

  PokemonRemoteDataSource({required this.client});

  final String _getAllPokemonQuery = """ 
    query {
      pokemons(limit: 20, offset: 0) {
        results {
          id
          name
          image
        }
      }
    }
  """;

  Future<List<PokemonModel>> getPokemons() async {
    final QueryOptions options = QueryOptions(
      document: gql(_getAllPokemonQuery),
    );

    final result = await client.query(options);
    if (result.hasException) {
      throw 'Error';
    }

    final List<dynamic> data = result.data?['pokemons']?['results'] ?? [];
    return data.map((json) => PokemonModel.fromJson(json)).toList();
  }
}
