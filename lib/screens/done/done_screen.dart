import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:townhall_todo/data/todo_notifier.dart';
import 'package:townhall_todo/model/todo.dart';
import 'package:townhall_todo/screens/widgets/todo_list_tile.dart';
import 'package:townhall_todo/utils/extensions.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Consumer(builder: (context, ref, _) {
          final todos = ref.watch(todosProvider);
          Map<String, List<Todo>> groupedTodos = {};

          // Get the current date
          DateTime currentDate = DateTime.now();

          for (var todo in todos.where((element) => element.done)) {
            // Convert the todo date string to a DateTime object
            DateTime todoDate = DateTime.parse(todo.date);

            // Format the date to display
            String formattedDate = _formatDate(todoDate, currentDate);

            if (!groupedTodos.containsKey(formattedDate)) {
              groupedTodos[formattedDate] = [];
            }
            groupedTodos[formattedDate]!.add(todo);
          }

          return Column(
            children: [
              56.height,
              Center(
                child: Text(
                  "Done To-do",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              24.height,
              ...groupedTodos.keys.map((date) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      8.height,
                      ...groupedTodos[date]!.map((todo) {
                        return TodoListTile(
                          todo: todo,
                        );
                      }).toList(),
                    ],
                  ),
                );
              }).toList(),
            ],
          );
        }),
      ),
    );
  }

  String _formatDate(DateTime todoDate, DateTime currentDate) {
    if (todoDate.year == currentDate.year &&
        todoDate.month == currentDate.month &&
        todoDate.day == currentDate.day) {
      return 'Today';
    } else if (todoDate.year == currentDate.year &&
        todoDate.month == currentDate.month &&
        todoDate.day == currentDate.day - 1) {
      return 'Yesterday';
    } else {
      // Format the date using the intl package
      return DateFormat('yyyy-MM-dd').format(todoDate);
    }
  }
}
