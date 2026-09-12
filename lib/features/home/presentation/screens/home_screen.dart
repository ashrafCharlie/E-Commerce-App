import 'package:ecommerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce_app/features/cart/presentation/screen/cart_screen.dart';
import 'package:ecommerce_app/features/wishlist/presentation/screen/wishlist_screen.dart';
import 'package:ecommerce_app/features/home/presentation/screens/home_page.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repo.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_event.dart';
import 'package:ecommerce_app/features/profile/presentation/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
   final UserEntity? currentUser;
  const HomeScreen({super.key,required this.currentUser});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;
  @override
  Widget build(BuildContext context) {
     List<Widget> pages = [HomePage(currentUser: widget.currentUser),WishlistScreen(currentUser: widget.currentUser),CartScreen(currentUser: widget.currentUser,),ProfileScreen(currentUser: widget.currentUser,)];

    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(create:  (context) => ProductBloc(productRepo: context.read<ProductRepo>())..add(ProductFetchEvent()),)
      ],
      child: Scaffold(
        body: pages[_selectedPage],
        bottomNavigationBar: GNav(
          backgroundColor: Colors.grey.shade100,
          selectedIndex: _selectedPage,
          onTabChange: (value) {
            setState(() {
              _selectedPage = value;
            });
          },
          tabs: [
          GButton(
            icon: Icons.home_outlined,
            text: "Home",
              ),
          GButton(
            icon: Icons.favorite_border,
            text: "Favorite",
              ),
          GButton(
            icon: Icons.shopping_cart_outlined,
            text: "Cart",
              ),
          GButton(
            icon: Icons.person_outline,
            text: "Profile",
              ),
        ]),
      ),
    );
  }
}