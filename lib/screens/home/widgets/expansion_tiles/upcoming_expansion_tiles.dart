import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:townhall_todo/data/todo_notifier.dart';
import 'package:townhall_todo/screens/widgets/todo_list_tile.dart';
import 'package:townhall_todo/utils/colors.dart';

class UpcomingExpansionTile extends ConsumerWidget {
  const UpcomingExpansionTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingTodos = ref.watch(filteredTodosProvider(Filter.upcoming));
    return ExpansionTile(
      initiallyExpanded: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      title: Text(
        "Upcoming To-do's",
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(color: AppColors.black),
      ),
      children: List.generate(
          upcomingTodos.length,
          (index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: TodoListTile(
                  todo: upcomingTodos[index],
                ),
              )),
    );
  }
}
