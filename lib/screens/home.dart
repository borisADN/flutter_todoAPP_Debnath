import 'package:flutter/material.dart';
import 'package:todolist2/constants/colors.dart';
import 'package:todolist2/model/todo.dart';
import 'package:todolist2/widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = Todo.todoList();
  List<Todo> _foundTodo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundTodo = todosList;
    super.initState();
    // _todoController.addListener(_searchTodos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 20, top: 30),
                        child: Text('Toutes les taches',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500)),
                      ),
                      for (Todo todo in _foundTodo.reversed)
                        TodoItem(
                          todo: todo,
                          onTodoChanged: _handleToDoChange,
                          onTodoDeleted: () {
                            setState(() {
                              todosList.remove(todo);
                            });
                          },
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: Container(
                    margin:
                        const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Ajouter une tache',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  )),
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 20, right: 20, left: 0),
                    child: FloatingActionButton(
                      foregroundColor: Colors.white,
                      backgroundColor: tdBlue,
                      child: Icon(Icons.add),
                      onPressed: () {
                        _handleAddTodo();
                      },
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  void _handleToDoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _handleAddTodo() {
    if (_todoController.text.trim().isEmpty) return;
    setState(() {
      todosList.add(Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: _todoController.text,
          isDone: false));
      _todoController.clear();
    });
  }

  void _runFilter(String enteredKeyword) {
    List<Todo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundTodo = results;
    });
  }

  Widget searchBox() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Rechercher',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/avatar.jpeg'),
          ),
        )
      ]),
    );
  }
}
