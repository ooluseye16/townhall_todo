import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:townhall_todo/model/todo.dart';
import 'package:townhall_todo/utils/constants.dart';

class TodosNotifier extends StateNotifier<List<Todo>> {
  // We initialize the list of todos to an empty list
  TodosNotifier() : super([]) {
    getTodos();
  }

  final store = objectbox.store.box<Todo>();

  getTodos() {
    state = store.getAll();
  }

  void addTodo(Todo todo) {
    state = [...state, todo];
    store.put(todo);
  }

  void removeTodo(int todoId) {
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
    store.remove(todoId);
  }

  void toggle(int todoId) {
    state = state.map((todo) {
      if (todo.id == todoId) {
        final newTodo = todo.copyWith(done: !todo.done);
        store.put(newTodo);
        return newTodo;
      } else {
        return todo;
      }
    }).toList();
  }
}

// Finally, we are using StateNotifierProvider to allow the UI to interact with
// our TodosNotifier class.
final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  return TodosNotifier();
});

final filteredTodosProvider =
    Provider.family<List<Todo>, Filter>((ref, filter) {
  // final filter = ref.watch(filterProvider);
  final todos = ref.watch(todosProvider);

  switch (filter) {
    case Filter.upcoming:
      return todos
          .where(
            (element) => (addTimeOfDayToDateTime(DateTime.parse(element.date),
                    convertTimeStringToTimeOfDay(element.time))
                .isAfter(
              DateTime.now(),
            )),
          )
          .toList();
    case Filter.overdue:
      return todos
          .where(
            (element) => (addTimeOfDayToDateTime(DateTime.parse(element.date),
                        convertTimeStringToTimeOfDay(element.time))
                    .isBefore(
                  DateTime.now(),
                ) &&
                !element.done),
          )
          .toList();
  }
});

enum Filter {
  upcoming,
  overdue,
}

TimeOfDay convertTimeStringToTimeOfDay(String timeString) {
  List<String> timeComponents = timeString.split(' ');
  List<String> hourMinute = timeComponents[0].split(':');
  int hours = int.parse(hourMinute[0]);
  int minutes = int.parse(hourMinute[1]);
  bool isPM = timeComponents[1].toLowerCase() == 'pm';

  if (isPM && hours != 12) {
    hours += 12;
  } else if (!isPM && hours == 12) {
    hours = 0;
  }

  return TimeOfDay(hour: hours, minute: minutes);
}

DateTime addTimeOfDayToDateTime(DateTime dateTime, TimeOfDay timeOfDay) {
  return DateTime(
    dateTime.year,
    dateTime.month,
    dateTime.day,
    timeOfDay.hour,
    timeOfDay.minute,
  );
}
