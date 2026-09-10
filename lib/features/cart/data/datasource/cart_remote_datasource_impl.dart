import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/cart/data/datasource/cart_remote_datasource.dart';
import 'package:ecommerce_app/features/cart/data/models/cart_model.dart';
import 'package:ecommerce_app/features/cart/domain/entities/cart_item_entity.dart';

class CartRemoteDatasourceImpl implements CartRemoteDatasource {
  final FirebaseFirestore firestore;
  CartRemoteDatasourceImpl({required this.firestore});
  @override
  Future<void> addToCart({required String userId, required CartModel item}) async {
    try{
      await firestore.collection('users')
          .doc(userId)
          .collection('cart')
          .doc(item.product.productId.toString())
          .set(item.toMap());
    }catch(e){
      throw Exception(e);
    }
  }

  @override
  Future<void> clearCart({required String userId}) async {
    try{
      final snapshot = await firestore.collection('users')
          .doc(userId)
          .collection('cart').get();
      for(final doc in snapshot.docs){
        await doc.reference.delete();
      }
    }catch(e){
      throw Exception(e);
    }
  }

  @override
  Stream<List<CartModel>> getCartItems({ required String userId})  {
    try{
      return firestore.collection('users')
          .doc(userId)
          .collection('cart')
          .snapshots()
          .map((snapshot){
          return  snapshot.docs.map((doc)=> CartModel.fromMap(doc.data())).toList();
      });
    }catch(e){
      throw Exception(e);
    }
  }

  @override
  Future<void> updateCartItem({
    required String userId,
    required int productId,
    required int quantity}) async {
    try{
      final cartRef = firestore.collection('users')
          .doc(userId)
          .collection('cart').doc(productId.toString());
      if(quantity <= 0){
        await cartRef.delete();
      }else{
        await cartRef.update({
          'quantity' : quantity
        });
      }
    }catch(e){
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteCartItem(String userId, int productId) async {
    try {
      await firestore.collection('users')
          .doc(userId)
          .collection('cart')
          .doc(productId.toString())
          .delete();
    }catch(e){
      throw Exception(e);
    }
  }


  
}