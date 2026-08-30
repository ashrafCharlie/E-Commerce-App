import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc_event.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc_state.dart';
import 'package:ecommerce_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isPassObscure = true;
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: const  Text('Login'),
  ),
  body: BlocListener<AuthBloc,AuthBlocState>(
    listener: (context, state) {
      if(state is AuthSuccessState){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Succesful")));
      }
      if(state is AuthErrorState){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg)));

      }
    },
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
          
              const Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
          
              const SizedBox(height: 8),
          
              const Text(
                'Login to continue shopping',
              ),
          
              const SizedBox(height: 40),
          
              // Email field 
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: 'Enter Your Email',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "Please Enter an Email";
                  }
                  if(!value.contains('@')){
                    return "Please Enter a valid Email";
                  }
                  return null;
                },
              ),
    
               const  SizedBox(height: 20,),
    
              // Password field 
              TextFormField(
                controller: passwordController,
                obscureText: isPassObscure,
                decoration:  InputDecoration(
                  labelText: "Password",
                  hintText: 'Enter Your Password',
                  prefixIcon: Icon(Icons.lock_outlined),
                  suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        isPassObscure = !isPassObscure;
                      });
                  }, 
                  icon: isPassObscure? Icon(Icons.visibility_outlined): Icon(Icons.visibility_off_outlined)),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "Please Enter Your Pasword";
                  }
                  if(value.length < 6){
                    return "Password must be at least 6 characters!";
                  }
                  return null;
                },
              ),
    
              //forget password
                Align(
                    alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            
                          },
                        child: const Text('Forgot Password?'),
                ),
              ),
    
              const SizedBox(height: 20,),
              // Login button
             SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                 if( formKey.currentState!.validate()){
                  final email = emailController.text.trim();
                  final password = passwordController.text;
                  context.read<AuthBloc>().add(AuthLoginEvent(email: email, password: password));
                 }
                },
                child: BlocBuilder<AuthBloc,AuthBlocState>(
                   builder:(context, state) {
                     if(state is AuthLoadingState){
                      return CircularProgressIndicator();
                     }
                    return Text("Login");
                   } ,
    
    
                  ),
              ),
            ),
    
            const SizedBox(height: 20),
    
            //continue with google 
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('OR'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Google login
                    },
                    label: const Text('Continue with Google'),
                  ),
                ),
    
    
            //Don't have account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen(),));
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            ),
            ],
          ),
        ),
      ),
    ),
  ),
);
  }
}