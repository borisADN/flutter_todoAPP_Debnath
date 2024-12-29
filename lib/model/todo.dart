class Todo {
  String? id;
  String? todoText;
  bool isDone;

  Todo({required this.id, required this.todoText, this.isDone = false});

  static List<Todo> todoList() {
    return [
      Todo(id: '01', todoText: 'Buy Milk', isDone: true),
      Todo(id: '02', todoText: 'Buy Eggs', isDone: true),
      Todo(id: '03', todoText: 'Buy Bread', isDone: false),
      Todo(id: '04', todoText: 'Buy Juice', isDone: false),
    ];
  }
}
