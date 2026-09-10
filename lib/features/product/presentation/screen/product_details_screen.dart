import 'package:ecommerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_event.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_state.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/wishlist/domain/entities/wishlist_entity.dart';
import 'package:ecommerce_app/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:ecommerce_app/features/wishlist/presentation/bloc/wishlist_event.dart';
import 'package:ecommerce_app/features/wishlist/presentation/bloc/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductEntity product;
  final UserEntity? currentUser;
  const ProductDetailsScreen({super.key,required this.product,required this.currentUser});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  int quantity = 1;
  bool isWishListed = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<WishlistBloc>().add(GetWishListEvent(userId: widget.currentUser!.uid));
  }
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("Product details",style: textTheme.titleLarge,),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            if(isWishListed){
              context.read<WishlistBloc>().add(RemoveWishListEvent(userId: widget.currentUser!.uid, productId: widget.product.productId));

            }else{
              context.read<WishlistBloc>().add(AddWishListEvent(userId: widget.currentUser!.uid, wishListItem: WishlistEntity(product: widget.product)));
            }
          }, icon: Icon(isWishListed? Icons.favorite : Icons.favorite_border,color: isWishListed? Colors.red : null,))
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CartBloc,CartState>(
          listener: (context, state) {
            if(state is CartAddSuccessfulState ){
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                  SnackBar(
                      content: Text("Item added to cart")));
              Navigator.pop(context);
            }
          },),

          BlocListener<WishlistBloc,WishlistState>(
            listener: (context, state) {
              if(state is WishListLoadedState){
                final isExist = state.wishList.any((item) => item.product.productId == widget.product.productId ,);
                setState(() {
                  isWishListed = isExist;
                });
              }

            },
            ),

        ],
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          // Product Image
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.network(
              widget.product.productImage,
              fit: BoxFit.contain,
            ),
          ),
        
          const SizedBox(height: 25),
        
          // Product Title
          Text(
            widget.product.productTitle,
            style: textTheme.headlineSmall,
          ),
        
          const SizedBox(height: 12),
        
          // Rating and Category
          Row(
            children: [
              Text(
                "⭐ ${widget.product.productRating}",
                style: textTheme.bodyLarge,
              ),
              const SizedBox(width: 15),
              Text(
                widget.product.productCategory,
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        
          const SizedBox(height: 20),
        
          // Price
          Text(
            "\$${widget.product.productPrice}",
            style: textTheme.headlineMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        
          const SizedBox(height: 25),
        
          // Description
          Text(
            "Description",
            style: textTheme.titleLarge,
          ),
        
          const SizedBox(height: 10),
        
          Text(
            widget.product.productDescription,
            style: textTheme.bodyLarge,
          ),
        
          const SizedBox(height: 25),
        
          // Quantity
          Text(
            "Quantity",
            style: textTheme.titleLarge,
          ),
        
          const SizedBox(height: 10),
        
          Row(
            children: [
              IconButton(
                onPressed: () {
                  if (quantity > 1) {
                    setState(() {
                      quantity--;
                    });
                  }
                },
                icon: const Icon(Icons.remove_outlined),
              ),
        
              Text(
                quantity.toString(),
                style: textTheme.titleLarge,
              ),
        
              IconButton(
                onPressed: () {
                  setState(() {
                    quantity++;
                  });
                },
                icon: const Icon(Icons.add_outlined),
              ),
            ],
          ),
        
          const SizedBox(height: 25),
        
          // Add to Cart
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                context.read<CartBloc>().add(AddItemToCartEvent(
                  userId: widget.currentUser!.uid,
                  cartItem:CartItemEntity(
                    product: widget.product,
                     quantity: quantity)));
              },
              child: const Text("Add to Cart"),
            ),
          ),
              ],
            ),
          ),
        ),
      
    );
}}