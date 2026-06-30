
import 'package:rifq_v2/features/add_pet/data/models/pet_model.dart';

class HomeDataEntity {
  final String username;
  final List<PetModel> pets;

  HomeDataEntity({
    required this.username,
    required this.pets,
  });
}