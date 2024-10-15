class Todo {
  int? id;
  late String title;
  String content;
  bool?  isDone;

  Todo(this.id, this.title, this.content, this.isDone);

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'content':content,
      'isDone': isDone,
    };
  }

  @override
  String toString() {
    return 'Todo{id: $id, title: $title, content: $content, isDone: $isDone}';
  }
}