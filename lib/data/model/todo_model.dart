// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TodoModel {
  String id;
  String title;

  String description;
  String userId;
  bool isCompleted;
  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    required this.isCompleted,
  });

  TodoModel copyWith({
    String? id,
    String? title,
    String? description,
    String? userId,
    bool? isCompleted,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '\$id': id,
      'title': title,
      'description': description,
      'userId': userId,
      'isCompleted': isCompleted,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['\$id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      userId: map['userId'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TodoModel(id: $id, title: $title, description: $description, userId: $userId, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(covariant TodoModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.userId == userId &&
        other.isCompleted == isCompleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        userId.hashCode ^
        isCompleted.hashCode;
  }
}
