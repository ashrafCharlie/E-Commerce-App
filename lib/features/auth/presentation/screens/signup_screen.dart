import 'package:ecommerce_app/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
      return Scaffold(
  appBar: AppBar(
    title: const  Text('SignUp'),
  ),
  body: SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
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
                  return "Please Your Name";
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
                if(value !=passwordController.text ){
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
                formKey.currentState!.validate();
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
                    // Google login
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
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
);
  }
}