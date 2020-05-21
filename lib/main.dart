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
      child: Text(Provider.of<Data>(context).someString),
    );
  }
}

class MyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(Provider.of<Data>(context).someString);
  }
}

class MyTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(onChanged: (newText) {
      // `listen: false` is necessary for elements to be notified of the change
      // Paraphrased from docs: `listen: false` must be passed when exposing
      // data using Provider in an event handler.
      // Why: Because in our scenario, we only need to change the data--not
      // read the data. It doesn't need to listen for changes.
      // https://github.com/rrousselGit/provider/issues/313#issuecomment-576156922
      // From docs: Tried to listen to a value exposed with provider, from
      // outside of the widget tree. This is likely caused by an event handler
      // (like a button's onPressed) that called
      // Provider.of without passing `listen: false`.
      // https://pub.dev/documentation/provider/latest/provider/Provider/of.html
      Provider.of<Data>(context, listen: false).changeString(newText);
    });
  }
}

class Data extends ChangeNotifier {
  String someString = "Some paxxx";

  void changeString(String newString) {
    someString = newString;
    notifyListeners();
  }
}
