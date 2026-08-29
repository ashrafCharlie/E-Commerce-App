import 'package:ecommerce_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc_event.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthBlocEvent,AuthBlocState> {
  final AuthRepo repo;
  AuthBloc({required this.repo}): super(AuthInitState()){
    on<AuthSignUpEvent>((event, emit) async {
      emit(AuthLoadingState());
      try{
      final user =  await repo.signUp(name: event.name, email: event.email, password: event.password);
     
       emit(AuthSuccessState(user:user ));

      }catch(e){
        emit(AuthErrorState(errorMsg: e.toString()));
      }
    },);
  }



  
}