import 'package:flutter/material.dart';
import 'package:todolist2/constants/colors.dart';
import 'package:todolist2/model/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final onTodoChanged;
  final onTodoDeleted;
  const TodoItem(
      {super.key,
      required this.todo,
      required this.onTodoChanged,
      required this.onTodoDeleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
          onTap: () {
            onTodoChanged(todo);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          tileColor: Colors.white,
          leading: Icon(
            todo.isDone? Icons.check_box : Icons.check_box_outline_blank,
            color: tdBlue,
          ),
          title: Text(
            todo.todoText!,
            style: TextStyle(
                color: tdBlack,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                decoration: todo.isDone? TextDecoration.lineThrough : null),
          ),
          trailing: Container(
            padding: const EdgeInsets.all(0),
            // margin: const EdgeInsets.symmetric(vertical: 12),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: tdRed,
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              icon: Icon(Icons.delete),
              color: Colors.white,
              iconSize: 20,
              onPressed: () {
                onTodoDeleted();
              },
            ),
          )),
    );
  }
}
