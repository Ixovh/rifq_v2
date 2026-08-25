import 'package:equatable/equatable.dart';

class HomePetEntity extends Equatable {
  final String id;
  final String name;
  final String? photoUrl;

  const HomePetEntity({required this.id, required this.name, this.photoUrl});

  @override
  List<Object?> get props => [id, name, photoUrl];
}

class HomeDataEntity extends Equatable {
  final String username;
  final String? imageUrl;
  final List<HomePetEntity> pets;

  const HomeDataEntity({
    required this.username,
    this.imageUrl,
    required this.pets,
  });

  String get firstName {
    final trimmed = username.trim();
    if (trimmed.isEmpty) return 'User';
    return trimmed.split(RegExp(r'\s+')).first;
  }

  String get initials {
    final trimmed = username.trim();
    if (trimmed.isEmpty) return 'U';
    return trimmed[0].toUpperCase();
  }

  @override
  List<Object?> get props => [username, imageUrl, pets];
}
