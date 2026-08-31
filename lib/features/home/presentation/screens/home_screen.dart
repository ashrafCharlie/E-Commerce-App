import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
 

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            context.read<AuthBloc>().add(LogoutEvent());
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: const Center(
        child: Text(
          "Welcome to Home Screen",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}