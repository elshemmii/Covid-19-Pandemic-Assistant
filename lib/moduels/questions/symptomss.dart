import 'package:covid_assistant/moduels/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';

class symptomss extends StatefulWidget {
  @override
  State<symptomss> createState() => _symptomssState();
}

class _symptomssState extends State<symptomss> {
  List<String> name = [
    'Cough',
    'Head ache',
    'Fever',
    'Muscle aches',
    'Tiredness',
    'Sneezing',
    'Sore throat',
    'Runny nose',
    'Pink eyes',
    'Vomiting',
    'Diarrhea',
    'Loss of smell'
  ];
  List<String> selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Select Symptoms',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: name.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          if (selected.contains(name[index].toString())) {
                            selected.remove(name[index].toString());
                          } else {
                            selected.add(name[index].toString());
                          }
                        });
                        print(selected.toString());
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(
                            name[index].toString(),
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w400),
                          ),
                          trailing: Container(
                            height: 40,
                            width: 70,
                            decoration: BoxDecoration(
                                color: selected.contains(name[index].toString())
                                    ? Colors.red
                                    : Colors.cyan,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                  selected.contains(name[index].toString())
                                      ? 'Remove'
                                      : 'Select',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Container(
              width: double.infinity,
              color: Colors.cyan,
              child: MaterialButton(
                height: 50.0,
                onPressed: () {
                  if (selected.contains('Cough') &&
                      (selected.contains('Fever')) &&
                      (selected.contains('Sore throat'))) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('Result'),
                              content: Text(
                                  'Covid +Ve !\nyou can chat with DoctorBot to know what is the next step'),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Cancel')),
                                TextButton(
                                    onPressed: () async {
                                      try {
                                        dynamic conversationObject = {
                                          'appId':
                                              'bdddfbf44eef6a652137e9ab5c4c0cf'
                                          // The [APP_ID](https://dashboard.kommunicate.io/settings/install) obtained from kommunicate dashboard.
                                        };
                                        dynamic result =
                                            await KommunicateFlutterPlugin
                                                .buildConversation(
                                                    conversationObject);
                                        print(
                                            "Conversation builder success : " +
                                                result.toString());
                                      } on Exception catch (e) {
                                        print(
                                            "Conversation builder error occurred : " +
                                                e.toString());
                                      }
                                    },
                                    child: Text('Ok'))
                              ],
                            ));
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('Result'),
                              content: Text(
                                  'Covid -Ve, its normal cold !\nyou can chat with DoctorBot to know what is the next step'),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Cancel')),
                                TextButton(
                                    onPressed: () async {
                                      try {
                                        dynamic conversationObject = {
                                          'appId':
                                              'bdddfbf44eef6a652137e9ab5c4c0cf'
                                        };
                                        dynamic result =
                                            await KommunicateFlutterPlugin
                                                .buildConversation(
                                                    conversationObject);
                                        print(
                                            "Conversation builder success : " +
                                                result.toString());
                                      } on Exception catch (e) {
                                        print(
                                            "Conversation builder error occurred : " +
                                                e.toString());
                                      }
                                    },
                                    child: Text('Ok'))
                              ],
                            ));
                  }
                },
                child: Text(
                  'GET RESULT',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
