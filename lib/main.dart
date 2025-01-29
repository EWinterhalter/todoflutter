import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Список задач',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<String> _todoList = [];
  final TextEditingController _textController = TextEditingController();

  void _addTodoItem(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _todoList.add(task);
      });
      _textController.clear();
    }
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
  }

  void _toggleTodoItem(int index) {
    setState(() {
      _todoList[index] = _todoList[index].startsWith('✓ ')
          ? _todoList[index].substring(2)
          : '✓ ' + _todoList[index];
    });
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _todoList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(
            _todoList[index].startsWith('✓ ') ? Icons.check_circle : Icons.radio_button_unchecked,
            color: _todoList[index].startsWith('✓ ') ? Colors.green : Colors.grey,
          ),
          title: Text(
            _todoList[index],
            style: TextStyle(
              decoration: _todoList[index].startsWith('✓ ')
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          subtitle: Text('Нажмите, чтобы отметить как выполненное'),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _removeTodoItem(index),
          ),
          onTap: () => _toggleTodoItem(index),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список задач'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildTodoList(),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Введите задачу',
                    ),
                    onSubmitted: _addTodoItem,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _addTodoItem(_textController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}