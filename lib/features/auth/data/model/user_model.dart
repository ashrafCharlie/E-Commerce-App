import 'package:ecommerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends UserEntity{
 const UserModel({
  required super.uid,
   required super.name,
    required super.email,
    super.createdAt,
    });

  factory UserModel.fromMap(Map<String,dynamic> map){
    return UserModel(
      uid: map['uid'] ?? '', 
      name: map['name'] ?? '', 
      email: map['email'] ?? '',
      createdAt: map['createdAt'] != null ? (map['createdAt'] as Timestamp).toDate(): null,
      );
  }

  Map<String,dynamic> toMap(){
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'createdAt': createdAt,
    };
  }

}