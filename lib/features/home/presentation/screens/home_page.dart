import 'package:ecommerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_event.dart';
import 'package:ecommerce_app/features/cart/presentation/screen/cart_screen.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_state.dart';
import 'package:ecommerce_app/features/product/presentation/screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  final UserEntity? currentUser;
  const HomePage({super.key, required this.currentUser});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   final List<Map<String, dynamic>> categories = [
  {
    'name': 'Fashion',
    'icon': Icons.checkroom_outlined,
  },
  {
    'name': 'Electronics',
    'icon': Icons.phone_android_outlined,
  },
  {
    'name': 'Shoes',
    'icon': Icons.directions_run_outlined,
  },
  {
    'name': 'Computers',
    'icon': Icons.computer_outlined,
  },
];


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
   
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.currentUser == null ? "Hello":"Hello, ${ widget.currentUser!.name}",
          style: textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
            color: colorScheme.onSurface,
          ),

          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(currentUser: widget.currentUser),));
            },
            icon: const Icon(Icons.shopping_cart_outlined),
            color: colorScheme.onSurface,
          ),
        ],
      ),

      body: SingleChildScrollView(
        physics:const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Find Your Favorite Products",
              style: textTheme.headlineLarge,
            ),

            const SizedBox(height: 16),

            TextField(
              decoration: InputDecoration(
                hintText: "Search products...",
                prefixIcon: const Icon(Icons.search),

              ),
            ),

            const SizedBox(height: 30),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(children: [
                Text("Special offer",
                style: textTheme.titleLarge?.copyWith(
                  color: colorScheme.onPrimary,
                ),
                ),

                const SizedBox(height: 8,),

                Text(
                  "Get up to 50% off",
                  style: textTheme.headlineLarge?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),

                const SizedBox(height: 16,),

                ElevatedButton(
                  onPressed: (){},
                  child: const Text("Shop Now")),

              ],),
            ),

            const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: textTheme.titleLarge,
                  ),

                  TextButton(
                    onPressed: () {},
                    child: const Text("See All"),
                  ),
                ],
              ),

              const SizedBox(height: 12,),

              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder:(context, index) {
                    final category = categories[index];

                    return Container(
                      width: 90,
                      margin: const EdgeInsets.only(right: 12),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: colorScheme.primaryContainer,
                            child: Icon(category['icon'],
                            color: colorScheme.onPrimaryContainer,
                            ),
                          ),

                          const SizedBox(height: 8,),

                          Text(
                            category['name'],
                            style: textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),

                        ],
                      ),
                    );
                  },
                   ),
              ),
        const SizedBox(height: 30),



        const SizedBox(height: 12),

        BlocBuilder<ProductBloc,ProductState>(
          builder: (context, state) {
            if(state is ProductLoadingState){
              return Center(child: CircularProgressIndicator(),);
            }
            if(state is ProductErrorState){
              return Center(child: Text(state.errorMessage),);
            }
            if(state is ProductLoadedState){
              final productList = state.productList;
              if(productList.isEmpty){
                return Center(child: Text("No product found"),);
              }
            return  GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount:productList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final product = productList[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                     MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(product: product,currentUser: widget.currentUser,),));
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Center(
                            child: Image.network(product.productImage)
                          ),
                        ),

                        Text(
                          product.productTitle,
                          style: textTheme.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "\$${product.productPrice}",
                          style: textTheme.bodyLarge?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<CartBloc>().add(AddItemToCartEvent(cartItem: CartItemEntity(product: product, quantity: 1), userId: widget.currentUser!.uid));
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added to Cart")));
                            },
                            child: const Text("Add to Cart"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
            }
          return Center(child: Text("Some error Occurred"),);
          },
        ),
                  ],
                ),

              ),
            );
          }
        }