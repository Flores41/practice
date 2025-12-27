import '../entities/pokemon.dart';

// Es una clase abstracta (un contrato)
abstract class PokemonRepository {
  // Solo definimos QUÉ queremos hacer: "Traer una lista de Pokemon"
  Future<List<Pokemon>> getPokemons();
}
