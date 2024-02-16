import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Tareas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
  List<TodoItem> _todos = [];

  TextEditingController _textEditingController = TextEditingController();

  void _addTodo() {
    setState(() {
      _todos.add(TodoItem(title: _textEditingController.text));
      _textEditingController.clear();
    });
  }

  void _removeTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  void _toggleTodoCompleted(int index) {
    setState(() {
      _todos[index].isCompleted = !_todos[index].isCompleted;
    });
  }

  void _editTodo(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController _editTextController = TextEditingController(text: _todos[index].title);
        return AlertDialog(
          title: Text('Editar Tarea'),
          content: TextField(
            controller: _editTextController,
            decoration: InputDecoration(
              hintText: 'Editar tarea',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _todos[index].title = _editTextController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de Tareas',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListTile(
                    title: Text(
                      _todos[index].title,
                      style: TextStyle(
                        fontSize: 18.0,
                        decoration: _todos[index].isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                        color: _todos[index].isCompleted ? Colors.grey : Colors.black,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.check),
                          onPressed: () => _toggleTodoCompleted(index),
                          color: Colors.blue,
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _editTodo(index),
                          color: Colors.orange,
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _removeTodo(index),
                          color: Colors.red,
                        ),
                      ],
                    ),
                    contentPadding: EdgeInsets.all(0),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            color: Colors.blue,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Ingrese una nueva tarea',
                      hintStyle: TextStyle(
                        color: Colors.white70,
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    cursorColor: Colors.white,
                    onSubmitted: (_) => _addTodo(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addTodo,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TodoItem {
  String title;
  bool isCompleted;

  TodoItem({required this.title, this.isCompleted = false});
}
