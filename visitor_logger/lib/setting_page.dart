import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.settings),
            SizedBox(width: 10),
            Text('設定'),
          ],
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              tooltip: '閉じる', // ツールチップを設定
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: Center(
        child: Expanded(
          child: Row(
            children: [
              const SizedBox(width: 50),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.color_lens_outlined),
                      SizedBox(width: 10),
                      Text('テーマ'),
                      SizedBox(width: 10),
                      DropdownButton<String>(
                        hint: const Text('選択してください'),
                        value: _selectedValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedValue = newValue;
                          });
                        },
                        items: <String>['ダーク', 'ライト']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 50),
            ],
          )
        )
      ),
    );
  }
}