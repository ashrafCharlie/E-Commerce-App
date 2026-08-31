import 'package:ecommerce_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc_event.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthBlocEvent,AuthBlocState> {
  final AuthRepo repo;
  AuthBloc({required this.repo}): super(AuthInitState()){
    on<AuthCheckEvent>((event, emit) async {
  emit(AuthcheckingState());
  try {
  await  Future.delayed(Duration(seconds: 2));
    final user = await repo.getCurrentUser();

    if (user != null) {
      emit(AuthenticateState(user: user));
    } else {
      emit(UnAuthenticateState());
    }
  } catch (e) {
    emit(AuthErrorState(errorMsg: e.toString()));
  }
},);

    on<AuthSignUpEvent>((event, emit) async {
      emit(AuthLoadingState());
      try{
      final user =  await repo.signUp(name: event.name, email: event.email, password: event.password);

       emit(AuthenticateState(user:user ));

      }catch(e){
        emit(AuthErrorState(errorMsg: e.toString()));
      }
    },);


  on<AuthLoginEvent>((event, emit) async {
  emit(AuthLoadingState());

  try {
    final user = await repo.login(
      email: event.email,
      password: event.password,
    );

    emit(AuthenticateState(user: user));

  } catch (e) {
  
    emit(AuthErrorState(errorMsg: e.toString()));
  }
});

    
  on<LogoutEvent>((event, emit) async {
    emit(AuthLoadingState());
    try{
     await repo.logout();
      emit(UnAuthenticateState());
    }catch(e){
      emit(AuthErrorState(errorMsg: e.toString()));
    }
  },
  
  );

  on<ForgetPasswordEvent>((event, emit) async {
      try {
        await repo.forgotPassword(email: event.email);
        emit(ResetEmailSendedState());
      } catch (e) {
        emit(AuthErrorState(errorMsg: e.toString()));
      }
    });

    //signin with google
    on<GoogleSignInEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final user = await repo.signInWithGoogle();
        if (user != null) {
          emit(AuthenticateState(user: user));
        } else {
          emit(UnAuthenticateState());
        }
      } catch (e) {
        emit(AuthErrorState(errorMsg: e.toString()));
      }
    });

  }
}