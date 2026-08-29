import 'package:ecommerce_app/features/auth/data/datasource/remote/auth_remote_datasource_impl.dart';
import 'package:ecommerce_app/features/auth/data/repository/auth_repo_impl.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/screens/login_screen.dart';
import 'package:ecommerce_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const EcommercApp());
}

class EcommercApp extends StatelessWidget {
  const EcommercApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepo>(create: (context) => AuthRepoImpl(remote: AuthRemoteDatasourceImpl()), )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(repo: context.read<AuthRepo>() ),)
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const LoginScreen(),
        ),
      ),
    );
  }
}