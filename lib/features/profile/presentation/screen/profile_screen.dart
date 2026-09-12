import 'package:ecommerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc_event.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc_state.dart';
import 'package:ecommerce_app/features/order/presentation/screens/orders_screen.dart';
import 'package:ecommerce_app/features/wishlist/presentation/screen/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  final UserEntity? currentUser;
  const ProfileScreen({super.key,required this.currentUser});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            CircleAvatar(
              radius: 45,
              child: Text(
                currentUser!.name.isNotEmpty
                    ? currentUser!.name[0].toUpperCase()
                    : "?",
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              currentUser!.name,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              currentUser!.email,
              style: textTheme.bodyMedium,
            ),

            const SizedBox(height: 30),


            Card(
              child: ListTile(
                leading: const Icon(Icons.shopping_bag_outlined),
                title: const Text("My Orders"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OrdersScreen(),));
                },
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.favorite_border),
                title: const Text("Wishlist"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => WishlistScreen(currentUser: currentUser),));
                },
              ),
            ),

          const SizedBox(height: 20),

            Card(
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                onTap: () {
                  showDialog(context: context, builder: (context) => AlertDialog(
                    title: Text("Are you Sure?"),
                    actions: [
                      TextButton(onPressed: (){Navigator.pop(context);}, child: Text("cancel")),
                      TextButton(onPressed: (){
                        context.read<AuthBloc>().add(LogoutEvent());
                        Navigator.pop(context);
                      }, child: Text("Logout")),
                    ],
                  ),);

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}