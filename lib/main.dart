import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {

//    final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
//          child: Text("Hello World"),
        child: RandomWords(),
        ),


      ),
    );
  }
}

class RandomWords extends StatefulWidget {

  RandomWordsState createState() => new RandomWordsState();

}

class RandomWordsState extends State<RandomWords> {

  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Text(wordPair.asPascalCase);
  }
}
