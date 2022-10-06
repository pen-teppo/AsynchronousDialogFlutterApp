import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc/status.dart';

class DialogWidget extends StatefulWidget {
  const DialogWidget({Key? key}) : super(key: key);

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  late BLoC _BLoC;

  @override
  void initState(){
    super.initState();
    _BLoC = BLoC();
  }

  @override
  void dispose(){
    _BLoC.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _BLoC.onDialogChange,
      builder: (BuildContext context, AsyncSnapshot<Status> snapshot) {
        if(snapshot.hasData){
            if(snapshot.data! == Status.inPreparation){
              //開始前ダイアログ表示
              return NormalDialog(title: 'ダウンロードの確認', content: 'データをダウンロードしますか？');
            }else if(snapshot.data! == Status.inProgress){
              //処理中ダイアログ表示
              return ProgressDialog(text: 'ダウンロード中');
            }else if(snapshot.data! == Status.completed){
              //完了時ダイアログ表示
              return NoticeDialog(title: 'ダウンロード完了', content: 'ダウンロードが完了しました。');
            }
        }

        return SizedBox(
          width: 10,
          height: 10,
        );
      },
    );
  }

  Widget ProgressDialog({required String text}) {
    return Dialog(
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text(text),
          ],
        ),
      ),
    );
  }

  Widget NormalDialog({required String title, required String content}) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: Text('キャンセル',style: TextStyle(color: Colors.lightBlueAccent)),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('OK',style: TextStyle(color: Colors.lightBlueAccent)),
          onPressed: (){
            _BLoC.triggerAction.add(null);
          },
        ),
      ],
    );
  }

  Widget NoticeDialog({required String title, required String content}) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: Text('OK',style: TextStyle(color: Colors.lightBlueAccent)),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}