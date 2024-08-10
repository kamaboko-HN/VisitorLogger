// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:visitor_logger/setting_page.dart'; // SystemNavigator を使用するために必要
import 'package:window_size/window_size.dart'; // ウィンドウサイズを設定するために必要
import 'dart:io';

// 1. エントリーポイントのmain関数
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Visitor Logger'); // ウィンドウのタイトルを設定する。
    setWindowFrame(Rect.fromLTWH(200, 100, 1280, 720)); // ウィンドウの位置と大きさを指定する。
    setWindowMinSize(const Size(700, 300)); // ウィンドウの最小サイズを指定する。
    setWindowMaxSize(Size.infinite); // ウィンドウの最大サイズを指定する。
  }
  
  // 2. MyAppを呼び出す
  runApp(const MyApp());
}

// MyAppのクラス
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 3. タイトルとテーマを設定する。画面の本体はMyHomePageで作る。
    return MaterialApp(
      title: 'Visitor Logger', 
      theme: ThemeData(
        useMaterial3: true, 
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey,
          brightness: Brightness.dark,
        ),
        
      ),
      home: const MyHomePage(title: 'Visitor Logger Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  var _logTextSize = 17.toDouble();
  var _buttonTextSize = 20.toDouble();

  void logVisitor() {
    String formattedDate = DateFormat('yyyy/MM/dd HH:mm:ss.SS').format(DateTime.now());
    _controller.text = '$formattedDate タッチされました\n${_controller.text}';
  }

  @override
  Widget build(BuildContext context) {

    // 4. MyHomePageの画面を構築する部分
    return Scaffold(
      appBar: AppBar( // 画面上部のタイトル部分
        title: const Row(
          children: [
            Icon(Icons.menu_book),
            SizedBox(width: 10),
            Text('Visitor Logger'),
          ],
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton( // ドロワーメニューを開くボタン
              icon: const Icon(Icons.menu),
              tooltip: 'サイドバーを開く',
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Padding( // メインコンテンツ
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded( // ログテキストエリア
              child: TextField(
                controller: _controller,
                maxLines: null,
                expands: true,
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                style: TextStyle(fontSize: _logTextSize),
              ),
            ),

            const SizedBox(width: 10), // スペーサー

            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                SizedBox( // タッチ記録ボタン
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: logVisitor,
                    child: Row(
                      children: [
                        const Icon(Icons.cast_rounded),
                        const SizedBox(width: 10),
                        Text(
                          'タッチで記録',
                          style: TextStyle(fontSize: _buttonTextSize),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10), // スペーサー

                SizedBox( // 手入力記録ボタン
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: logVisitor,
                    child: Row(
                      children: [
                        const Icon(Icons.edit),
                        const SizedBox(width: 10),
                        Text(
                          '手入力で記録',
                          style: TextStyle(fontSize: _buttonTextSize),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ),
      drawer: Drawer( // ドロワーメニュー
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ListTile( // ドロワーメニューを閉じるボタン
                    leading: const Icon(Icons.close),
                    title: const Text("閉じる"),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(height: 10), // スペーサー
                  ListTile( // アプリの設定ボタン
                    leading: const Icon(Icons.settings),
                    title: const Text("設定"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingPage()),
                      );
                    },
                  ),
                  ListTile( // ログ出力ボタン
                    leading: const Icon(Icons.feed),
                    title: const Text("ログ出力"),
                    onTap: () {
                    },
                  ),
                ],
              ),
            ),
            ListTile( // アプリ終了ボタン
              leading: const Icon(Icons.exit_to_app),
              title: const Text("終了"),
              onTap: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // 使用が終わったらコントローラーを破棄する
    _controller.dispose();
    super.dispose();
  }
}
