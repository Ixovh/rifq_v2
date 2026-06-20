import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:rifq_v2/core/services/local_keys_service.dart';
import 'package:rifq_v2/features/auth/data/models/auth_model.dart';
import 'package:rifq_v2/core/errors/network_exceptions.dart';


abstract class BaseAuthRemoteDataSource {
  Future<AuthModel> getAuth();
}


@LazySingleton(as: BaseAuthRemoteDataSource)
class AuthRemoteDataSource implements BaseAuthRemoteDataSource {
 
  final SupabaseClient _supabase;
  final LocalKeysService _localKeysService;
  
  

   AuthRemoteDataSource(this._localKeysService, this._supabase);



    @override
  Future<AuthModel> getAuth() async {
    try {
      return AuthModel(id: 1, firstName: "Last Name", lastName: "First Name");
    } catch (error) {
     throw FailureExceptions.getException(error);
    }
  }
}
