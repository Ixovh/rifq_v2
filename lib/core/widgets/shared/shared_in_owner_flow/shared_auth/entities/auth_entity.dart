import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String token;
  final String refreshToken;
  const AuthEntity({required this.token, required this.refreshToken});

  @override
  List<Object?> get props => [token, refreshToken];
}
