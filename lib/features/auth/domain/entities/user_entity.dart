import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String name;
  final String email;
  final DateTime? createdAt;
  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    this.createdAt,
  });
  @override
  List<Object?> get props => [uid,name,email,createdAt];


}