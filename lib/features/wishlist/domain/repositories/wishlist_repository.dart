import 'package:ecommerce_app/features/wishlist/domain/entities/wishlist_entity.dart';

abstract class WishlistRepository {
  Future<void> addWishlist({
   required String userId,
    required WishlistEntity wishListItem,
  });
  Stream<List<WishlistEntity>> getWishlist({
    required String userId,
  });
  Future<void> removeWishList({
    required String userId,
    required int productId,
});
}