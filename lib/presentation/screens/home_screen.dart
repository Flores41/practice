import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/pokemon_provider.dart';

// 1. Cambiamos StatelessWidget por ConsumerWidget
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  // 2. El método build ahora recibe un "WidgetRef ref" extra
  Widget build(BuildContext context, WidgetRef ref) {
    // 3. "Miramos" el provider. Si los datos cambian, la pantalla se redibuja sola.
    final asyncPokemons = ref.watch(pokemonListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PokeGraphQL Clean Arch'),
        backgroundColor: Colors.redAccent,
      ),
      // 4. La magia de Riverpod para llamadas asíncronas
      body: asyncPokemons.when(
        // A. Estado de CARGA: Muestra un círculo girando
        loading: () => const Center(child: CircularProgressIndicator()),

        // B. Estado de ERROR: Muestra el mensaje feo (o uno bonito)
        error: (error, stack) => Center(
          child: Text(
            'Error: $error',
            style: const TextStyle(color: Colors.red),
          ),
        ),

        // C. Estado de ÉXITO: Aquí tienes tu lista de pokemones
        data: (pokemons) {
          return ListView.builder(
            itemCount: pokemons.length,
            itemBuilder: (context, index) {
              final pokemon = pokemons[index];

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: Image.network(
                    pokemon.image,
                    width: 50,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error), // Por si la imagen falla
                  ),
                  title: Text(
                    pokemon.name.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("#${pokemon.id}"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
