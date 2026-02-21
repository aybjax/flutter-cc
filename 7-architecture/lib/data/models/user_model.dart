// =============================================================================
// User Model (Data Layer)
// =============================================================================
// Freezed + JsonSerializable model that maps to/from JSON and converts
// to the domain entity. Models live in the data layer and never leak
// into domain or presentation.
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

// ---------------------------------------------------------------------------
// UserModel
// ---------------------------------------------------------------------------

/// Data-layer representation of a user, with JSON serialization.
///
/// The backend returns:
/// ```json
/// {
///   "user": { "id": 1, "email": "test@test.com" },
///   "token": "jwt..."
/// }
/// ```
///
/// We flatten this into a single model for convenience.
@freezed
class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required int id,
    required String email,
    required String token,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  // ---------------------------------------------------------------------------
  // Factory: parse the nested backend response
  // ---------------------------------------------------------------------------

  /// Parses the backend auth response format:
  /// `{ "user": { "id": ..., "email": ... }, "token": "..." }`
  factory UserModel.fromAuthResponse(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>;
    return UserModel(
      id: user['id'] as int,
      email: user['email'] as String,
      token: json['token'] as String,
    );
  }

  // ---------------------------------------------------------------------------
  // Domain conversion
  // ---------------------------------------------------------------------------

  /// Converts this data model to a domain entity.
  ///
  /// This is the boundary between data and domain layers.
  /// The domain layer never sees [UserModel], only [UserEntity].
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      token: token,
    );
  }

  // Alternative: use an extension method instead
  // extension UserModelX on UserModel {
  //   UserEntity toEntity() => UserEntity(id: id, email: email, token: token);
  // }
}
