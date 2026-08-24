import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/shared/storage_service/auth_helper.dart';
import 'package:rifq_v2/features/home/data/datasources/home_remote_data_source.dart';
import 'package:rifq_v2/features/home/domain/entities/home_entity.dart';
import 'package:rifq_v2/features/home/domain/repositories/home_repository_domain.dart';

@LazySingleton(as: HomeRepoDomain)
class HomeRepoImpl implements HomeRepoDomain {
  final BaseHomeDataSource dataSource;

  HomeRepoImpl(this.dataSource);

  @override
  Future<Result<HomeDataEntity, String>> getHomeData() async {
    try {
      //!!-----------guest check-----------
      final isGuest = AuthHelper.isGuestUser();
      if (isGuest) {
        return Success(HomeDataEntity(username: "Guest", pets: []));
      }

      //!!----------profile-----------
      final profile = await dataSource.fetchUserProfile();
      if (profile == null) {
        return Error("User not found");
      }

      final fullName = profile['full_name'] as String?;
      final username =
          (fullName != null && fullName.trim().isNotEmpty) ? fullName.trim() : 'User';
      final ownerId = profile['id'] as String;

      //!!-----------pets-----------
      final pets = await dataSource.fetchUserPets(ownerId);

      return Success(HomeDataEntity(username: username, pets: pets));
    } catch (e) {
      return Error(e.toString());
    }
  }
}