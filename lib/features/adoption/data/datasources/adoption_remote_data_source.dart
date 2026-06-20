import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:rifq_v2/core/services/local_keys_service.dart';
import 'package:rifq_v2/features/adoption/data/models/adoption_model.dart';
import 'package:rifq_v2/core/errors/network_exceptions.dart';


abstract class BaseAdoptionRemoteDataSource {
  Future<AdoptionModel> getAdoption();
}


@LazySingleton(as: BaseAdoptionRemoteDataSource)
class AdoptionRemoteDataSource implements BaseAdoptionRemoteDataSource {
 
  final SupabaseClient _supabase;
  final LocalKeysService _localKeysService;
  
  

   AdoptionRemoteDataSource(this._localKeysService, this._supabase);



    @override
  Future<AdoptionModel> getAdoption() async {
    try {
      return AdoptionModel(id: 1, firstName: "Last Name", lastName: "First Name");
    } catch (error) {
     throw FailureExceptions.getException(error);
    }
  }
}
