import 'package:ecommerce_app/features/auth/data/model/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel?> getCurrentUser();
  Future<UserModel> signUp(
    {
      required String name,
      required String email,
      required String password,
    }
  );

  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<UserModel> signInWithGoogle();

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