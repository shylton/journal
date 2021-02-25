import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  // TODO: Convert to StatefulWidget

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Counter counter; // TODO: Lift the state up.

  void topUpdateCounter() {
    setState(() {
      counter.value++;
    });
  }

  void initState() {
    super.initState();
    counter = Counter(initialValue: 0);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Example',
        theme: ThemeData.dark(), //COOLEO !!!
        home: Scaffold(
            appBar: AppBar(title: Text('Example')),
            body: Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // TODO: Pass down state (once lifted up here).
                    children: [
                  DecreasingWidget(counter),
                  IncreasingWidget(counter, topUpdateCounter)
                ] // TODO: And eventually, a state change function
                    ))));
  }
}

// TODO: After lifting state out of here, change to StatelessWidget
class IncreasingWidget extends StatelessWidget {
  final counter;
  final changeCount;

  IncreasingWidget(this.counter, this.changeCount);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('${counter.value} done',
          style: Theme.of(context).textTheme.headline3),
      CounterChangingButton(
          updateCounter:
              changeCount) // TODO: Pass down a callback into the constructor.
      //       After lifting state, you may need to pass
      //       this down twice.
    ]);
  }
}

class DecreasingWidget extends StatelessWidget {
  final counter;

  DecreasingWidget(this.counter);

  @override
  Widget build(BuildContext context) {
    // TODO: Use the state to display the number of taps left.
    return Container(
        child: Text('${10 - counter.value} left',
            style: Theme.of(context).textTheme.headline3));
  }
}

class CounterChangingButton extends StatelessWidget {
  final void Function() updateCounter;

  CounterChangingButton({this.updateCounter});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: updateCounter,
        child: Text('Tap Me!', style: Theme.of(context).textTheme.headline3));
  }
}

class Counter {
  int value;

  Counter({int initialValue}) : value = initialValue;

  void increment() {
    ++value;
  }
}
