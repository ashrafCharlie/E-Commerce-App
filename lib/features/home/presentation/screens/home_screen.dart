import 'package:ecommerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce_app/features/cart/presentation/screen/cart_page.dart';
import 'package:ecommerce_app/features/favorite/presentation/screen/favorite_page.dart';
import 'package:ecommerce_app/features/home/presentation/screens/home_page.dart';
import 'package:ecommerce_app/features/profile/presentation/screen/profile_page.dart';
import 'package:flutter/material.dart';
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
     List<Widget> pages = [HomePage(currentUser: widget.currentUser),FavoritePage(),CartPage(),ProfilePage()];

    return Scaffold(
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
    );
  }
}