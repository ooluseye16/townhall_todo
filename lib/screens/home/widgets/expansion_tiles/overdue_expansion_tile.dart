import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:townhall_todo/data/todo_notifier.dart';
import 'package:townhall_todo/screens/widgets/todo_list_tile.dart';
import 'package:townhall_todo/utils/colors.dart';
import 'package:townhall_todo/utils/extensions.dart';

class OverdueExpansionTile extends ConsumerWidget {
  const OverdueExpansionTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overdueTodos = ref.watch(filteredTodosProvider(Filter.overdue));
    return ExpansionTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      title: Row(
        children: [
          Text(
            "Overdue",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: AppColors.black),
          ),
          4.width,
          if (overdueTodos.isNotEmpty)
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: ShapeDecoration(
                color: const Color(0xFFFF4C4C),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
              child: Text("${overdueTodos.length}",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white)),
            )
        ],
      ),
      children: List.generate(
          overdueTodos.length,
          (index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: TodoListTile(
                  todo: overdueTodos[index],
                ),
              )),
    );
  }
}
