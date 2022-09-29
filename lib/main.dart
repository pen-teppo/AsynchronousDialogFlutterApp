import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc/dialog.dart';
import 'package:bloc/status.dart';

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
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late BLoC _BLoC;

  @override
  void initState(){
    super.initState();
    _BLoC = BLoC();
    _BLoC.onDialogChange.listen((Status status) async {
      if(Navigator.of(context).canPop() == true){
        Navigator.pop(context);
      }

      if(status == Status.inPreparation){
        //開始前ダイアログ表示
        bool result = await DialogManager.showNormalDialog(
          context: context,
          title: 'ダウンロードの確認',
          content: 'データをダウンロードしますか？'
        );
        if(result == true){
          _BLoC.triggerAction.add(null);
        }
      }else if(status == Status.inProgress){
        //処理中ダイアログ表示
        await DialogManager.showProgressDialog(
            context: context,
            text: 'ダウンロード中'
        );
      }else if(status == Status.completed){
        //完了時ダイアログ表示
        await DialogManager.showNoticeDialog(
          context: context,
          title: 'ダウンロード完了',
          content: 'ダウンロードが完了しました。'
        );
      }
    });
  }

  @override
  void dispose(){
    _BLoC.close();
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
