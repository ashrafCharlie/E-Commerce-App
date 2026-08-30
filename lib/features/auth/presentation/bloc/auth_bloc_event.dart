import 'package:equatable/equatable.dart';

sealed class AuthBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class AuthSignUpEvent extends AuthBlocEvent{
  final String name;
  final String email;
  final String password;
  AuthSignUpEvent({
    required this.email,
    required this.name,
    required this.password,
  });

  @override
  List<Object?> get props => [name,email,password];
}

class AuthLoginEvent extends AuthBlocEvent{
  final String email;
  final String password;
  AuthLoginEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email,password];
}