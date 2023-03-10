import 'dart:async';
import 'package:flutter/material.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({Key? key}) : super(key: key);

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final _todoController = TextEditingController();
  List<String> _todoList = [];

  void _addTodo() {
    if (_todoController.text.isEmpty) return;
    setState(() {
      _todoList.add(_todoController.text);
      _todoController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('할일 목록'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _todoController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: '할일을 적어주세요',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _addTodo,
            child: Text('추가하기'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _todoList[index],
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
