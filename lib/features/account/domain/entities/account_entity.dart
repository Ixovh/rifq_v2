import 'package:equatable/equatable.dart';

/// Matches `public.profiles` in Supabase (Ixovh's Project).
///
/// Columns: id, role, full_name, phone_number, avatar_url, created_at, updated_at.
/// Email lives on `auth.users`, not on this table — see [AccountDataEntity.email].
class AccountEntity extends Equatable {
  final String id;
  final String? fullName;
  final String? phoneNumber;
  final String? avatarUrl;

  /// Postgres enum `user_role`: `pet_owner` | `clinic` | `service_provider`
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AccountEntity({
    required this.id,
    this.fullName,
    this.phoneNumber,
    this.avatarUrl,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  String get displayName {
    final trimmed = fullName?.trim() ?? '';
    if (trimmed.isEmpty) return 'User';
    return trimmed;
  }

  String get initials {
    final trimmed = fullName?.trim() ?? '';
    final parts = trimmed.split(RegExp(r'\s+'));
    if (trimmed.isEmpty || parts.first.isEmpty) return 'U';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  String get firstName {
    final trimmed = fullName?.trim() ?? '';
    if (trimmed.isEmpty) return '';
    return trimmed.split(RegExp(r'\s+')).first;
  }

  String get lastName {
    final trimmed = fullName?.trim() ?? '';
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length < 2) return '';
    return parts.sublist(1).join(' ');
  }

  @override
  List<Object?> get props => [
        id,
        fullName,
        phoneNumber,
        avatarUrl,
        role,
        createdAt,
        updatedAt,
      ];
}

class AccountPetEntity extends Equatable {
  final String id;
  final String name;
  final String gender;
  final String breed;
  final int? age;
  final String? photoUrl;
  final bool listedForAdoption;

  const AccountPetEntity({
    required this.id,
    required this.name,
    required this.gender,
    required this.breed,
    this.age,
    this.photoUrl,
    this.listedForAdoption = false,
  });

  String get ageLabel {
    if (age == null) return '-';
    if (age == 1) return '1 Year';
    return '$age Years';
  }

  @override
  List<Object?> get props => [
        id,
        name,
        gender,
        breed,
        age,
        photoUrl,
        listedForAdoption,
      ];
}

/// Screen-level aggregate: profile row + auth email + pets.
class AccountDataEntity extends Equatable {
  final AccountEntity profile;

  /// From `auth.users.email` (not a `profiles` column).
  final String email;
  final List<AccountPetEntity> pets;

  const AccountDataEntity({
    required this.profile,
    required this.email,
    required this.pets,
  });

  @override
  List<Object?> get props => [profile, email, pets];
}

/// Result of updating profile fields and optionally email.
class AccountUpdateResult extends Equatable {
  final AccountEntity profile;
  final String email;

  /// New email awaiting OTP confirmation (when different from [email]).
  final String? pendingEmail;

  /// True when Supabase requires confirming the new email address.
  final bool emailConfirmationPending;

  const AccountUpdateResult({
    required this.profile,
    required this.email,
    this.pendingEmail,
    this.emailConfirmationPending = false,
  });

  @override
  List<Object?> get props => [
        profile,
        email,
        pendingEmail,
        emailConfirmationPending,
      ];
}
