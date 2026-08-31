import 'package:ecommerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

sealed class AuthBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}


class AuthInitState extends AuthBlocState{}

class AuthLoadingState extends AuthBlocState{}

class AuthErrorState extends AuthBlocState{
  final String errorMsg;
  AuthErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}
class AuthcheckingState extends AuthBlocState{
}
class AuthenticateState extends AuthBlocState{
  final UserEntity user;
  AuthenticateState({
    required this.user,
  });
  @override
  List<Object?> get props => [user];
}

class UnAuthenticateState extends AuthBlocState{}
class ResetEmailSendedState extends AuthBlocState{}
