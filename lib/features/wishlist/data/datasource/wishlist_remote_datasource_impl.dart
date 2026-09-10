import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/wishlist/data/datasource/wishlist_remote_datasource.dart';
import 'package:ecommerce_app/features/wishlist/data/models/wishlist_model.dart';

class WishlistRemoteDatasourceImpl implements WishlistRemoteDatasource {
  final FirebaseFirestore firestore;
  WishlistRemoteDatasourceImpl({required this.firestore});
  @override
  Future<void> addWishList({required String userId, required WishlistModel wishlistItem}) async {

    try{
      await firestore.collection('users')
          .doc(userId)
          .collection('wishlist')
          .doc(wishlistItem.product.productId.toString())
          .set(wishlistItem.toMap());
    }catch(e){
      throw Exception(e);
    }
  }

  @override
  Stream<List<WishlistModel>> getWishList({required String userId}) {
    return  firestore.collection('users')
          .doc(userId)
          .collection('wishlist')
          .snapshots()
          .map((snapshot)=> snapshot.docs.map((doc)=>WishlistModel.fromMap(doc.data())).toList());
  }

  @override
  Future<void> removeWishList({required String userId, required int productId}) async {
    try{
      await firestore.collection('users')
          .doc(userId)
          .collection('wishlist')
          .doc(productId.toString()).delete();
    }catch(e){
      throw Exception(e);
    }
  }
}