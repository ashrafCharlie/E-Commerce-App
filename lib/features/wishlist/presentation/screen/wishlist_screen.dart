import 'package:ecommerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/wishlist_bloc.dart';
import '../bloc/wishlist_event.dart';
import '../bloc/wishlist_state.dart';

class WishlistScreen extends StatefulWidget {
  final UserEntity? currentUser;
  const WishlistScreen({super.key, required this.currentUser});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {

  @override
  void initState() {
    super.initState();
    context.read<WishlistBloc>().add(
      GetWishListEvent(
        userId: widget.currentUser!.uid,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wishlist"),
        centerTitle: true,
      ),

      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {

          if (state is WishListLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is WishListErrorState) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is WishListLoadedState) {

            final wishList = state.wishList;

            if (wishList.isEmpty) {
              return const Center(
                child: Text("Your wishlist is empty"),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: wishList.length,
              itemBuilder: (context, index) {

                final wishlistItem = wishList[index];
                final product = wishlistItem.product;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),

                    leading: Image.network(
                      product.productImage,
                      width: 70,
                      height: 70,
                      fit: BoxFit.contain,
                    ),

                    title: Text(
                      product.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    subtitle: Text(
                      "\$${product.productPrice}",
                    ),

                    trailing: IconButton(
                      onPressed: () {
                        context.read<WishlistBloc>().add(
                          RemoveWishListEvent(
                            userId: widget.currentUser!.uid,
                            productId: product.productId,
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}