import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  State createState() => AppState();
}

class AppState extends State<App> {
  final desserts = List<String>.generate(4, (i) {
    return 'Dessert Name $i';
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(title: Text('${desserts.length} Desserts')),
            body: DessertsScreen(desserts: desserts),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  addDessert('New Cake! ${desserts.length}');
                },
                child: Icon(Icons.cake))));
  }

  void addDessert(String name) {
    // TODO: Add `name` to the list.
    setState(() {
      desserts.add(name);
    });
  }
}

class DessertsScreen extends StatefulWidget {
  final List<String> desserts;

  DessertsScreen({this.desserts});

  @override
  DessertsScreenState createState() => DessertsScreenState(desserts: desserts);
}

class DessertsScreenState extends State<DessertsScreen> {
  final List<String> desserts;

  DessertsScreenState({this.desserts});

  @override
  Widget build(BuildContext context) {
    // TODO: Use the builder constructor.
    //       Pass it two arguments.
    return ListView(
        children: desserts.map((name) {
      return ListTile(
          leading: FlutterLogo(),
          trailing: Icon(Icons.cake),
          title: Text(name),
          subtitle: Text('Mmmm delicious!'));
    }).toList());
  }
}
