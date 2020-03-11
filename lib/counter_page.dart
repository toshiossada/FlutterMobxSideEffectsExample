import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import 'counter_page_controller.dart';

class CounterPage extends StatefulWidget {
  CounterPage({Key key}) : super(key: key);

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final controller = CounterPageoController();
  List<ReactionDisposer> disposers = [];

  @override
  void initState() {
    disposers = [
      // reaction<int>((r) => controller.counter, (v) {
      //   if (v % 2 == 0)
      //     return Flushbar(
      //       title: 'Side Effect Reaction',
      //       message: 'Número é par',
      //       duration: Duration(seconds: 1),
      //     ).show(context);

      //   return null;
      // });

      reaction<bool>((r) => controller.counter % 2 == 0, (v) {
        if (v)
          return Flushbar(
            title: 'Side Effect Reaction',
            message: 'Número é par',
            duration: Duration(seconds: 1),
          ).show(context);

        return null;
      }),

      when(
          (r) => controller.counter > 10,
          () => Flushbar(
                title: 'Side Effect When',
                message: 'É maior que 10',
                duration: Duration(seconds: 1),
              ).show(context)),

      autorun((r) => print(controller.counter))
    ];

    super.initState();
  }

  @override
  void dispose() {
    disposers.forEach((dispose) => dispose());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Observer(
              builder: (_) {
                return Text(
                  '${controller.counter}',
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
