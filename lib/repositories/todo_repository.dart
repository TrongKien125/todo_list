import 'package:todo_list/model/Todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addToDoItem(ToDo todo) async {
    await _firestore.collection('todo_items').add({
      'id': todo.id,
      'todoText': todo.todoText,
      'isDone': todo.isDone,
      'dateTime': todo.dateTime,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<ToDo>> getToDoItems() {
    return _firestore.collection('todo_items')
        .orderBy('createdAt')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ToDo.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<void> deleteToDoItem(String documentId) async {
    await _firestore.collection('todo_items').doc(documentId).delete();
  }

  Future<void> updateToDoItem(String documentId, String newTitle, String newDescription) async {
    await _firestore.collection('todo_items').doc(documentId).update({
      'title': newTitle,
      'description': newDescription,
    });
  }
}