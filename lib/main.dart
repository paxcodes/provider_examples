import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
      create: (context) => Data(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: MyText(),
          ),
          body: Level1(),
        ),
      ),
    );
  }
}

class Level1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Level2(),
    );
  }
}

class Level2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MyTextField(),
        Level3(),
      ],
    );
  }
}

class Level3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(context.watch<Data>().someString),
    );
  }
}

class MyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // To only rebuild when a specific piece in the data has changed.
    return Text(context.select<Data, String>((Data d) => d.titleString));
    // If I use `watch`, this widget will unnecessarily be rebuilt in
    // every keystroke.
    // print("MY TEXT WILL BUILD EVERY KEYSTROKE IN THE TEXTFIELD");
    // return Text(context.watch<Data>().titleString);
  }
}

class MyTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(onChanged: (newText) {
      context.read<Data>().changeString(newText);
    });
  }
}

class Data extends ChangeNotifier {
  String titleString = "App Title";
  String someString = "Some paxxx";

  void changeString(String newString) {
    someString = newString;
    notifyListeners();
  }
}
