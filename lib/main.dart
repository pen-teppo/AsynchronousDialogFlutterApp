import 'package:flutter/material.dart';
import 'package:bloc/modal.dart';
import 'package:bloc/dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLoC & Dialog App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      onGenerateRoute: (RouteSettings settings) {
        final args = (settings.arguments ?? {}) as Map;
        if (settings.name == '/dialog') {
          return ModalOverlay(
            builder: (BuildContext context) => DialogWidget(),
          );
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState(){
    super.initState();
    Future(() async {
      await Navigator.of(context).pushNamed('/dialog');
    });
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BLoC & Dialog App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('BLoC & Dialog App'),
          ],
        ),
      ),
    );
  }
}
