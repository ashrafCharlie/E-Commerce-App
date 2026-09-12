import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/theme/app_theme.dart';
import 'package:ecommerce_app/features/auth/data/datasource/remote/auth_remote_datasource_impl.dart';
import 'package:ecommerce_app/features/auth/data/repository/auth_repo_impl.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc_event.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc_state.dart';
import 'package:ecommerce_app/features/auth/presentation/screens/login_screen.dart';
import 'package:ecommerce_app/features/cart/data/datasource/cart_remote_datasource_impl.dart';
import 'package:ecommerce_app/features/cart/data/repository/cart_repositories_impl.dart';
import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/category/data/datasource/category_remote_datasource_impl.dart';
import 'package:ecommerce_app/features/category/data/repositories/category_repository_impl.dart';
import 'package:ecommerce_app/features/category/domain/repositories/category_repository.dart';
import 'package:ecommerce_app/features/category/presentation/bloc/category_bloc.dart';
import 'package:ecommerce_app/features/home/presentation/screens/home_screen.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_bloc.dart';
import 'package:ecommerce_app/features/order/data/datasource/remote_datasource_impl.dart';
import 'package:ecommerce_app/features/order/data/repositories/order_repository_impl.dart';
import 'package:ecommerce_app/features/order/domain/repositories/order_repository.dart';
import 'package:ecommerce_app/features/product/data/datasource/remote/product_remote_datasource_impl.dart';
import 'package:ecommerce_app/features/product/data/repositories/product_repo_impl.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repo.dart';
import 'package:ecommerce_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:ecommerce_app/features/wishlist/data/datasource/wishlist_remote_datasource_impl.dart';
import 'package:ecommerce_app/features/wishlist/data/repositories/wishlist_repository_impl.dart';
import 'package:ecommerce_app/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:ecommerce_app/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:ecommerce_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  EcommerceApp({super.key});
  final Dio dio = Dio();
  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepo>(create: (context) => AuthRepoImpl(remote: AuthRemoteDatasourceImpl()), ),
        RepositoryProvider<ProductRepo>(create: (context) => ProductRepoImpl(remote: ProductRemoteDatasourceImpl(dio: dio)),),
        RepositoryProvider<CartRepository>(create: (context) => CartRepositoriesImpl( remoteDatasource: CartRemoteDatasourceImpl(firestore: fireStore)), ),
        RepositoryProvider<OrderRepository>(create:(context) => OrderRepositoryImpl(remoteDatasource: OrderRemoteDatasourceImpl(firestore: fireStore )), ),
        RepositoryProvider<WishlistRepository>(create:(context) => WishlistRepositoryImpl(wishlistRemoteDatasource: WishlistRemoteDatasourceImpl(firestore: fireStore)),),
        RepositoryProvider<CategoryRepository>(create: (context) => CategoryRepositoryImpl(categoryRemoteDatasource: CategoryRemoteDatasourceImpl(dio: dio)),)
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(repo: context.read<AuthRepo>())..add(AuthCheckEvent()),),
          BlocProvider(create: (context) => CartBloc(cartRepository:context.read<CartRepository>() ),),
          BlocProvider(create: (context) => OrderBloc(orderRepository: context.read<OrderRepository>())),
          BlocProvider(create:(context) => WishlistBloc(wishlistRepository: context.read<WishlistRepository>()), ),
          BlocProvider(create: (context) => CategoryBloc(categoryRepository: context.read<CategoryRepository>() ),)
        ],
        child: MaterialApp(
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              overscroll: false,
            ),
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