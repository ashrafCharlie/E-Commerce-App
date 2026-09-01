import 'package:ecommerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final UserEntity? currentUser;
  const HomeScreen({super.key,required this.currentUser});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {

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
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
            color: colorScheme.onSurface,
          ),
        ],
      ),

      body: SingleChildScrollView(
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
                Text("Special offer 🔥",
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
            )

          ],
        ),
      ),
    );
  }
}