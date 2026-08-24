import 'package:rifq_v2/features/add_pet/data/models/pet_model.dart';

class HomeDataEntity {
  final String username;
  final String? imageUrl;
  final List<PetModel> pets;

  HomeDataEntity({required this.username, this.imageUrl, required this.pets});
}
