import 'package:covid_assistant/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../questions/symptomss.dart';

class HomeScreen extends StatelessWidget {
  final User? user = Auth().currentUser;

//Future function to sign out the user
  Future<void> signOut() async {
    await Auth().signOut();
  }

// widget to display user's registered email on login
  Widget _userUid() {
    return Text(
      user?.email ?? 'User email',
      style: TextStyle(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              // call function sign out
              onPressed: () {
                signOut();
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ))
        ],
      ),
      body: Container(
          color: Colors.black,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                  child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  'assets/run.png',
                  fit: BoxFit.cover,
                ),
              )),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      ClipOval(
                        child: Container(
                          width: 110,
                          height: 110,
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: Image.asset('assets/background.png'),
                        ),
                      ),
                      SizedBox(height: 40),
                      Text(
                        'Welcome to Covid-19 Assistant, ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _userUid(),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'i will help you to \n make a simple check up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton.icon(
                        onPressed: () {
                          // push navigator to the symptoms screen
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => symptomss()));
                        },
                        icon: Icon(
                          Icons.navigate_next,
                          size: 30,
                          color: Colors.white,
                        ),
                        label: Text('Next',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
