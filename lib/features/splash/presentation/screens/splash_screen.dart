import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_bag_outlined,
                size: 80,
              ),
        
              const SizedBox(height: 20),
        
              const Text(
                'Ash Shopping Platform',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
        
              const SizedBox(height: 10),
        
              const Text('Your shopping starts here'),
        
              const SizedBox(height: 30),
        
              LoadingAnimationWidget.staggeredDotsWave(color: Colors.blue, size: 40),
            ],
          ),
        ),
      
    );
  }
}