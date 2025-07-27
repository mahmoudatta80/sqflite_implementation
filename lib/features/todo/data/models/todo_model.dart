class TodoModel {
  final int? id;
  final String title, description;

  TodoModel({this.id, required this.title, required this.description});

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'title': title, 'description': description};
  }
}
