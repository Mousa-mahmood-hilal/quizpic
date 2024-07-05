import 'package:flutter/material.dart';
import 'dart:math';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'matching word with picture'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _solution = "";
  int index = 0;
  var mp = {
    'cat': 'images/cat.png',
    'fox': 'images/Fox.png',
    'koala': 'images/koala.png',
    'penguin': 'images/Penguin.png',
    'shark': 'images/Shark.png',
    'sheep': 'images/sheep.png',
  };
  var questionlist = {
    'Which animal is known for its ability to land on its feet and is often kept as a pet in homes?':
        'cat',
    'Which animal is known for its bushy tail and its cunning nature in folklore and fairy tales?':
        'fox',
    'Which animal is known for its love of eucalyptus leaves and is native to Australia?':
        'koala',
    'Which animal is known for its waddling walk, lives in cold climates, and is often seen in black and white?':
        'penguin',
    'Which animal is known for its sharp teeth, fin on its back, and lives in the ocean?':
        'shark',
    'Which animal is known for its woolly coat and is often associated with farming and countryside landscapes?':
        'sheep',
  };
  List quesionindex = [
    'Which animal is known for its ability to land on its feet and is often kept as a pet in homes?',
    'Which animal is known for its bushy tail and its cunning nature in folklore and fairy tales?',
    'Which animal is known for its love of eucalyptus leaves and is native to Australia?',
    'Which animal is known for its waddling walk, lives in cold climates, and is often seen in black and white?',
    'Which animal is known for its sharp teeth, fin on its back, and lives in the ocean?',
    'Which animal is known for its woolly coat and is often associated with farming and countryside landscapes?'
  ];
  String question = "", stateimage = "images/questionmark.png";
  String firstimage = 'images/questionmark.png',
      secondimage = 'images/questionmark.png',
      thirdimage = 'images/questionmark.png';
  void level() {
    setState(() {
      stateimage = 'images/questionmark.png';
      // ignore: non_constant_identifier_names
      question = quesionindex[index];
      List imagechose = [
        mp[questionlist[quesionindex[index]]],
        mp[questionlist[quesionindex[(index + 1) % 6]]],
        mp[questionlist[quesionindex[(index + 2) % 6]]]
      ];
      int innerindex = Random().nextInt(3);
      firstimage = imagechose[innerindex];
      secondimage = imagechose[(innerindex + 1) % 3];
      thirdimage = imagechose[(innerindex + 2) % 3];
      _solution = '';
    });
  }

  void solution() {
    setState(() {
      if (questionlist.containsKey(question)) {
        _solution = questionlist[question]!;
      } else {
        _solution = '';
      }
    });
  }

  void checklevel(String chosenimage) {
    setState(() {
      String? ans = mp[questionlist[quesionindex[index]]];
      if (ans == chosenimage) {
        stateimage = 'images/True.png';
        if (index == mp.length - 1) {
          // question = 'the game is done press the icon start to restart';
          Alert(
            context: context,
            type: AlertType.success,
            title: "game over",
            desc: "the game is done press the restart button  to restart",
            buttons: [
              DialogButton(
                onPressed: () => Navigator.pop(context),
                gradient: const LinearGradient(colors: [
                  Color.fromRGBO(116, 116, 191, 1.0),
                  Color.fromRGBO(52, 138, 199, 1.0)
                ]),
                child: const Text(
                  "restart",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ).show();
          index = 0;
          level();
        } else {
          index++;
        }
      } else {
        stateimage = 'images/false.png';
      }
    });
  }

  Expanded buttonpicture(String img) {
    return Expanded(
        child: TextButton(
      onPressed: () {
        checklevel(img);
      },
      child: Image(
        image: AssetImage(img),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 244, 225),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(211, 116, 82, 1),
        title: Center(
            child: Text(
          widget.title,
          style: const TextStyle(
            color: Color.fromARGB(255, 234, 219, 200),
          ),
        )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20.0),
              child: Text(
                question,
                style: const TextStyle(
                  fontSize: 30.0,
                  color: Color.fromARGB(246, 84, 51, 16),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    buttonpicture(firstimage),
                    buttonpicture(secondimage),
                    buttonpicture(thirdimage),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image(
                image: AssetImage(stateimage),
              ),
            )),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child:  Text('to see the solution \nclick the next button:',
                            style: TextStyle(fontSize: 25)),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: FloatingActionButton(
                          onPressed: solution,
                          tooltip: 'solve',
                          child: const Icon(Icons.check),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          _solution,
                          style: const TextStyle(fontSize: 35),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: const Text('next level:',style: TextStyle(fontSize: 25))),
                        FloatingActionButton(
                          onPressed: level,
                          tooltip: 'start',
                          child: const Icon(Icons.start),
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
