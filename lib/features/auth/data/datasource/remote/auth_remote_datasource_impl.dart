import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/auth/data/datasource/remote/auth_remote_datasource.dart';
import 'package:ecommerce_app/features/auth/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDatasourceImpl  implements AuthRemoteDatasource{
 final FirebaseAuth _auth = FirebaseAuth.instance;
 final FirebaseFirestore _firestore =  FirebaseFirestore.instance;
  @override
  Future<void> deleteAccount() async {
    try{
      final currentUser = _auth.currentUser;
      if(currentUser == null){
        throw Exception("User not found");
      }
     await currentUser.delete();
     await logout();

    }catch(e){
      throw Exception("Some Error Occured.. error is : $e");
    }
  }

  @override
  Future<void> forgotPassword({required String email})  async{
    try{
     await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      throw Exception("Password reset failed... error is : $e");
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
   final currentUser =  _auth.currentUser;
   if(currentUser == null){
    return null;
   }
   return UserModel(uid: currentUser.uid, name: currentUser.displayName?? '', email: currentUser.email ?? '');
  }

  @override
  Future<UserModel> login({required String email, required String password}) async{
    try{
    final UserCredential userCredential =  await _auth.signInWithEmailAndPassword(email: email, password: password);
    final user = userCredential.user;
    if(user == null){
      throw Exception("user not found");
    }

    return UserModel(uid: user.uid, name: user.displayName ?? '', email: email);

    }catch(e){
      throw Exception("Login Failed.. Error is: $e");
    }
  }

  @override
  Future<void> logout() async {
    try{
      final currentUser = _auth.currentUser;
      if(currentUser == null){
        throw Exception("user not found...");

      }
     await _auth.signOut();

    }catch(e){
      throw Exception("Logout failed.. error is : $e");
    }
  }

  @override
  Future<UserModel> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signUp({required String name, required String email, required String password}) async{
   try{
  final UserCredential userCredential =  await  _auth.createUserWithEmailAndPassword(email: email, password: password);
  final user = userCredential.user;
  if(user == null){
    throw Exception("User not found..");
  }

   await _firestore.collection('users').doc(user.uid).set({
    'name': name,
    'email': email,
    'createdAt': FieldValue.serverTimestamp(),
   });
   return  UserModel(uid:user.uid, name: name, email: email);
   }catch(e){
    throw Exception("Sign up failed, Error is : $e");
   }
  }

  @override
  Future<void> updatePassword({required String currentPassword, required String newPassword}) {
    // TODO: implement updatePassword
    throw UnimplementedError();
  }
}