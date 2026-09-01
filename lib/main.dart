import 'package:ecommerce_app/core/theme/app_theme.dart';
import 'package:ecommerce_app/features/auth/data/datasource/remote/auth_remote_datasource_impl.dart';
import 'package:ecommerce_app/features/auth/data/repository/auth_repo_impl.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc_event.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc_state.dart';
import 'package:ecommerce_app/features/auth/presentation/screens/login_screen.dart';
import 'package:ecommerce_app/features/home/presentation/screens/home_screen.dart';
import 'package:ecommerce_app/features/splash/presentation/screens/splash_screen.dart';
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
          BlocProvider(create: (context) => AuthBloc(repo: context.read<AuthRepo>())..add(AuthCheckEvent()),)
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
        home: BlocConsumer<AuthBloc, AuthBlocState>(
  listener: (context, state) {
   if(state is AuthErrorState){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg)));
   }
  },
  builder: (context, state) {
    if (state is AuthcheckingState) {
      return const SplashScreen();
    }

    if (state is AuthenticateState) {
    
      return  HomeScreen(currentUser: state.user,);
    }
    if(state is AuthLoadingState){
      return Scaffold(
        body: Center(child: CircularProgressIndicator(),),
      );
    }else{
      return LoginScreen();
    }
   
  },
),
        ),
      ),
    );
  }
}