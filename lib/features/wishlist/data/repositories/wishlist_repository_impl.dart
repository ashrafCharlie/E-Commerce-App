import 'package:ecommerce_app/features/wishlist/data/datasource/wishlist_remote_datasource.dart';
import 'package:ecommerce_app/features/wishlist/data/models/wishlist_model.dart';
import 'package:ecommerce_app/features/wishlist/domain/entities/wishlist_entity.dart';
import 'package:ecommerce_app/features/wishlist/domain/repositories/wishlist_repository.dart';

class WishlistRepositoryImpl implements WishlistRepository{
  final WishlistRemoteDatasource wishlistRemoteDatasource;
  WishlistRepositoryImpl({required this.wishlistRemoteDatasource});

  @override
  Future<void> addWishlist({required String userId, required WishlistEntity wishListItem})  {
    final wishListModel = WishlistModel.fromEntity(wishListItem);
   return wishlistRemoteDatasource.addWishList(userId: userId, wishlistItem: wishListModel);
  }

  @override
  Stream<List<WishlistEntity>> getWishlist({required String userId}) {
   return wishlistRemoteDatasource.getWishList(userId: userId);
  }

  @override
  Future<void> removeWishList({required String userId, required int productId}) {
    return wishlistRemoteDatasource.removeWishList(userId: userId, productId: productId);
  }
}