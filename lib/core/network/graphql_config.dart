import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final graphQLClientProvider = Provider<GraphQLClient>((ref) {
  final HttpLink httpLink = HttpLink('https://graphql-pokeapi.graphcdn.app/');

  return GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: InMemoryStore()),
  );
});
