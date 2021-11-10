import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String _title = "Chưa đổi";

  void changeTitle() {
    setState(() {
      _title = _title == "Chưa đổi" ? "Đổi rồi nè" : "Chưa đổi";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(_title),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              changeTitle();
            },
            child: Text("Nhấn chơi để đổi title nè"),
          ),
        ),
      ),
    );
  }
}
