import 'package:flutter_application_1/domain/entities/pokemon.dart';

class PokemonModel {
  final String id;
  final String name;
  final String image;

  PokemonModel({required this.id, required this.name, required this.image});

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'] ?? '0',
      name: json['name'] ?? 'Unknown',
      image: json['image'] ?? 'https://via.placeholder.com/150',
    );
  }
  Pokemon toEntity() {
    return Pokemon(id: id, name: name, image: image);
  }
}
