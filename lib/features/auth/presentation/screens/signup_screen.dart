import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc_event.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc_state.dart';
import 'package:ecommerce_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpassController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isPassObscure = true;
  bool isConfirmPassObscure = true;


  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpassController.dispose();
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
  appBar: AppBar(
    title: const  Text('SignUp'),
  ),
  body: BlocListener<AuthBloc,AuthBlocState>(
    listener: (context, state) {
      if(state is AuthErrorState){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg)));
      }
    },
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
            
                const Text(
                  'Welcome Here',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            
                const SizedBox(height: 8),
            
                const Text(
                  'Explore The Best',
                ),
                
                const SizedBox(height: 40),
                
                 // Name field 
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    hintText: 'Enter Your Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return "Please Enter Your Name";
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 20.0,),
            
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
                
                const SizedBox(height: 20.0,),
                
                //confirm Password 
                TextFormField(
                  controller: confirmpassController,
                  obscureText: isConfirmPassObscure,
                  decoration:  InputDecoration(
                    labelText: "Confirm Password",
                    hintText: 'Enter Confirm Password',
                    prefixIcon: Icon(Icons.lock_outlined),
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          isConfirmPassObscure = !isConfirmPassObscure;
                        });
                    }, 
                    icon: isConfirmPassObscure? Icon(Icons.visibility_outlined): Icon(Icons.visibility_off_outlined)),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please confirm your password";
                      }
                
                      if (value != passwordController.text) {
                     return "Confirm password doesn't match";
                    }
                     return null;
                    },
                    ),
                
                const SizedBox(height: 20,),
                
                // Login button
               SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if(formKey.currentState!.validate()){
                    final email = emailController.text.trim();
                    final name = nameController.text.trim();
                    final password = passwordController.text;
                  
                    context.read<AuthBloc>().add(AuthSignUpEvent(
                      email: email,
                       name: name,
                        password: password));
                    }
                  
                  },
                  child: const Text('Sign Up'),
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
                        context.read<AuthBloc>().add(GoogleSignInEvent());
                      },
                      label: const Text('Continue with Google'),
                    ),
                  ),
                
                
              //Don't have account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
              ],
            ),
          ),
        ),
      ),
    ),
  ),
);
  }
}