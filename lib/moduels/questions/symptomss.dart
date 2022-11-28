import 'package:covid_assistant/moduels/home/home_screen.dart';
import 'package:covid_assistant/moduels/loadingPage.dart';
import 'package:flutter/material.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';

class symptomss extends StatefulWidget {
  @override
  State<symptomss> createState() => _symptomssState();
}

class _symptomssState extends State<symptomss> {
  bool isLoading = false; // bool to show loading screen

  //declaring the list of symptoms
  List<String> name = [
    'Cough    سعال',
    'Head ache    صداع الراس',
    'Fever    حُمى',
    'Muscle aches    آلام العضلات',
    'Tiredness    التعب',
    'Sneezing    العطس',
    'Sore throat    إلتهاب الحلق',
    'Runny nose    سيلان الأنف',
    'Pink eyes    عيون وردية',
    'Vomiting    التقيؤ',
    'Diarrhea    إسهال',
    'Loss of smell    فقدان حاسة الشم'
  ];

  //creating new empty list to store the selected symptoms
  List<String> selected = [];

  @override
  Widget build(BuildContext context) => isLoading
      ? LoadingPage()
      : Scaffold(
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
                //pushing navigator to the home screen
                Navigator.pop(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
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
                              // if the list contains same symptoms remove it
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
                                    // toggling button's color if selected or remove symptom
                                    color: selected
                                            .contains(name[index].toString())
                                        ? Colors.red
                                        : Colors.cyan,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                      // if symptom is selected display "remove" else "select"
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
                    onPressed: () async {
                      setState(() => isLoading = true);
                      await Future.delayed(Duration(seconds: 2));
                      setState(() => isLoading = false);
                      // check if the selected list contains the positive symptoms "Cough//Fever//sore throat"
                      if (selected.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('ERROR !'),
                                  content: Text(
                                      'No Symptoms Are selected ! \nSelect symptoms to get result'),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('Ok')),
                                  ],
                                ));
                      } else if (selected.length < 7) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('Select more symptoms!'),
                                  content: Text(
                                      'You have to select at least 7 symptoms to accurate your result'),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('Ok')),
                                  ],
                                ));
                      } else if (selected.contains(
                            'Cough    سعال',
                          ) &&
                          (selected.contains(
                            'Fever    حُمى',
                          )) &&
                          (selected.contains('Sore throat    إلتهاب الحلق')) &&
                          (selected
                              .contains('Loss of smell    فقدان حاسة الشم'))) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  //creating alertdialog box to generate result
                                  title: Text('Result'),
                                  content: Text(
                                      'Covid +Ve !\nyou can chat with DoctorBot to know what is the next step'),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('Cancel')),
                                    TextButton(
                                        // if "ok" button is pressed the chat will be called through below function
                                        onPressed: () async {
                                          try {
                                            dynamic conversationObject = {
                                              'appId':
                                                  '2864b06793ff3c86d29317cbb1e0f0a07'
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
                                                  '2864b06793ff3c86d29317cbb1e0f0a07'
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
