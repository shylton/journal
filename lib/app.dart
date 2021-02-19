import 'package:flutter/material.dart';

class App extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class VerticalLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lime,
    );
  }
}

class HorizontalLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(child: Container(color: Colors.lightGreen)),
        Expanded(
            child: Container(
          color: Colors.deepOrange,
        ))
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  Widget getLayout(BuildContext context, BoxConstraints constraints) =>
      constraints.maxWidth < 500 ? VerticalLayout() : HorizontalLayout();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("adaptive layout"),
      ),
      body: LayoutBuilder(
          builder:
              getLayout), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
