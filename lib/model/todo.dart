import 'package:objectbox/objectbox.dart';

@Entity()
class Todo {
  @Id()
  int id = 0;
  final String title;
  final String date;
  final String time;
  bool done;
  final List<String>? subTasks;
  final String category;
  final String? description;

  Todo(
      {required this.time,
      this.id = 0,
      this.subTasks,
      required this.category,
      this.description,
      required this.title,
      required this.date,
      this.done = false});

  Todo copyWith({
    int? id,
    String? title,
    String? date,
    String? time,
    bool? done,
    List<String>? subTasks,
    String? category,
    String? description,
  }) =>
      Todo(
          time: time ?? this.time,
          id: id ?? this.id,
          category: category ?? this.category,
          title: title ?? this.title,
          date: date ?? this.date,
          subTasks: subTasks ?? this.subTasks,
          description: description ?? this.description,
          done: done ?? this.done);
}
