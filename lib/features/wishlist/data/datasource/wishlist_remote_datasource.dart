import 'package:ecommerce_app/features/wishlist/data/models/wishlist_model.dart';

abstract class WishlistRemoteDatasource {
  Future<void> addWishList({ required String userId, required WishlistModel wishlistItem});
  Stream<List<WishlistModel>> getWishList ({required String userId});
  Future<void> removeWishList({required String userId, required int productId});
}