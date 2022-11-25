import 'package:covid_assistant/moduels/login/login_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../auth.dart';

class registerScreen extends StatefulWidget {
  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  String? errorMessage = ''; // declaration error message

  var nameController = TextEditingController(); // name form-field  controller

  final TextEditingController RegisterEmailController =
      TextEditingController(); // email register - form field controller

  var RegisterPasswordController =
      TextEditingController(); //  password register - form field controller

  var ConfirmPasswordController =
      TextEditingController(); //confirm password register - form field controller

  var phoneController = TextEditingController(); // phone form field controller

  var formKey = GlobalKey<FormState>(); //form key for validator for form fields

  bool passwordObscure = true; // bool to toggle password show/ hide

  static const List<String> list = <String>[
    'Male',
    'Female'
  ]; //initialize list of gender

  String dropdownValue =
      list.first; // drop down default value to pop selected first in list

  Future<void> createUserWithEmailAndPassword() async {
    //future function to sign up with email and pass ( Authentication)
    try {
      await Auth().createUserWithEmailAndPassword(
        email: RegisterEmailController.text,
        password: RegisterPasswordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _errorMessage() {
    //error message to be displayed
    return Text(
      errorMessage == '' ? '' : 'Hmm? $errorMessage',
      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          color: Colors.white,
          onPressed: () {
            //[pushing navigator to login screen
            Navigator.pop(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Register',
                    style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan),
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    onFieldSubmitted: (String value) {},
                    onChanged: (String value) {},
                    decoration: InputDecoration(
                      labelText: 'Enter your full name ',
                      hintText: 'First name , Last name ',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      //validator to check if form field is full or not
                      if (value != null && value.isEmpty) {
                        return 'MUST NOT BE EMPTY';
                      } else if (value!.length < 7) {
                        return 'Name must be min. 7 chars';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    controller: RegisterEmailController,
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (String value) {},
                    onChanged: (String value) {},
                    decoration: InputDecoration(
                      labelText: 'Enter your e-mail address ',
                      hintText: 'example@gmail.com',
                      prefixIcon: Icon(Icons.email_rounded),
                      border: OutlineInputBorder(),
                    ),
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Enter a valid e-mail address' // form not valid
                            : null, // form valid
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    maxLength: 9,
                    // max length for password form field is 8
                    keyboardType: TextInputType.number,
                    controller: RegisterPasswordController,
                    obscureText: passwordObscure,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      // Here is key idea
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordObscure state choose the icon
                          passwordObscure
                              ? Icons.visibility //show password
                              : Icons.visibility_off, // hide password
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toggle the state of passwordObscure bool from true to false or otherwise
                          setState(() {
                            passwordObscure =
                                !passwordObscure; //toggle bool state
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      //Validator to check if password form field is full or not
                      if (value != null && value.isEmpty) {
                        return 'MUST NOT BE EMPTY';
                      } else if (value!.length < 6) {
                        return 'Password must be min. 6 digits length';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    maxLength: 9,
                    // max length for password form field is 8
                    keyboardType: TextInputType.number,
                    controller: ConfirmPasswordController,
                    obscureText: passwordObscure,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
                      hintText: 'Confirm your password',
                      // Here is key idea
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordObscure state choose the icon
                          passwordObscure
                              ? Icons.visibility //show password
                              : Icons.visibility_off, // hide password
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toggle the state of passwordObscure bool from true to false or otherwise
                          setState(() {
                            passwordObscure =
                                !passwordObscure; //toggle bool state
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      //Validator to check if confirm password form field is full or not
                      if (value != null && value.isEmpty) {
                        return 'MUST NOT BE EMPTY';
                      } else if (value!.length < 6) {
                        return 'Password must be min. 6 digits length';
                      } else if (ConfirmPasswordController.text !=
                          RegisterPasswordController.text) {
                        return 'Passwords does not match';
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    // max length for phone form field is 11
                    maxLength: 11,
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone No.',
                      hintText: 'Enter your phone number',
                      prefixIcon: Icon(Icons.call_rounded),
                    ),
                    validator: (value) {
                      //Validator for phone form field
                      if (value != null && value.isEmpty) {
                        return 'MUST NOT BE EMPTY';
                      }else if(value!.length<11){
                        return'Enter valid phone no.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: [
                      Text(
                        'Gender',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      DropdownButton<String>(
                        //Drop down list to select gender and toggle between them(Male-Female)
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down_sharp),
                        iconSize: 30,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black54,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(20),
                      ),
                      icon: Icon(Icons.how_to_reg_rounded,
                          size: 30, color: Colors.white),
                      label: Text(
                        'Register',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise, if valid will create new user with e-mail and password
                        if (formKey.currentState!.validate()) {
                          createUserWithEmailAndPassword();
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return LoginScreen();
                              },
                            ),
                          );
                        }
                      }),
                  _errorMessage(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
