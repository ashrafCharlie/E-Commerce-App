import 'package:ecommerce_app/features/auth/data/datasource/remote/auth_remote_datasource.dart';
import 'package:ecommerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDatasource remote;
  AuthRepoImpl({
    required this.remote,
  });
  @override
  Future<void> deleteAccount() {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Future<void> forgotPassword({required String email}) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<UserEntity?> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> login({required String email, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> signUp({required String name, required String email, required String password}) async {
   return await remote.signUp(name: name, email: email, password: password);
  }

  @override
  Future<void> updatePassword({required String currentPassword, required String newPassword}) {
    // TODO: implement updatePassword
    throw UnimplementedError();
  }
}