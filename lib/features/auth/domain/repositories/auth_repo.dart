import 'package:ecommerce_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<UserEntity?> getCurrentUser();
  Future<UserEntity> signUp(
    {
      required String name,
      required String email,
      required String password,
    }
  );

  Future<UserEntity> login({
    required String email,
    required String password,
  });

  Future<UserEntity?> signInWithGoogle();

  Future<void> forgotPassword({
    required String email,
  });

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<void> deleteAccount();

  Future<void> logout();
}