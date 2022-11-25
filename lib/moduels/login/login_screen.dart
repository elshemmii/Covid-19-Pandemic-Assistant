import 'package:covid_assistant/moduels/register_screen/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:covid_assistant/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>(); //form key to validate forms

  bool passwordObscure = true; //bool to toggle password field

  String? errorMessage = ''; // error message to catch

  bool isLogin = true; //bool to check if user is already login to select route

  final TextEditingController emailController =
      TextEditingController(); //email controller to get what's inside e-mail form field

  final TextEditingController passwordController =
      TextEditingController(); //password controller to get what's inside e-mail form field

  Future<void> signInWithEmailAndPassword() async {
    //future function to sign in with email and pass ( Authentication)
    try {
      await Auth().signInWithEmailAndPassword(
        // sign in method
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

// error message displayed
  Widget _errorMessage() {
    return Text(
      errorMessage == '' ? '' : 'Hmm? $errorMessage',
      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Login ',
                    style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan),
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (String value) {},
                    onChanged: (String value) {},
                    decoration: InputDecoration(
                      labelText: 'Enter your E-mail Address',
                      prefixIcon: Icon(Icons.email_rounded),
                      border: OutlineInputBorder(),
                    ),
                    //Validator for e-mail form field
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'E-MAIL ADDRESS MUST NOT BE EMPTY';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  TextFormField(
                    maxLength: 9,
                    keyboardType: TextInputType.text,
                    controller: passwordController,
                    //password toggle bool
                    obscureText: passwordObscure,
                    //This will obscure text dynamically
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your password',
                      hintText: '8-Digit password',
                      // Here is key idea
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordObscure state choose the icon
                          passwordObscure
                              ? Icons.visibility //show pass
                              : Icons.visibility_off, //hide pass
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toggle the state of passwordObscure bool from true to false or otherwise
                          setState(() {
                            passwordObscure =
                                !passwordObscure; // toggling bool state
                          });
                        },
                      ),
                    ),
                    //Validator for pass form field
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'MUST NOT BE EMPTY';
                      }else if(value!.length<6){
                        return 'Must be min. 6 digits length';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(20),
                    ),
                    icon: Icon(
                      Icons.lock_open,
                      size: 32,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    onPressed: () {
                      // checks if the previous forms are filled in or not if true ==> login
                      if (formKey.currentState!.validate()) {
                        signInWithEmailAndPassword();
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  //display error message if there's one
                  _errorMessage(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                      ),
                      TextButton(
                        onPressed: () {
                          //pushing navigation for register screen
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => registerScreen()));
                        },
                        child: Text(
                          'Register Now',
                        ),
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
