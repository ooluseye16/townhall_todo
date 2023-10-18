import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:townhall_todo/data/todo_notifier.dart';
import 'package:townhall_todo/model/todo.dart';
import 'package:townhall_todo/utils/colors.dart';
import 'package:townhall_todo/utils/extensions.dart';

class TodoListTile extends ConsumerStatefulWidget {
  const TodoListTile({
    super.key,
    required this.todo,
  });

  final Todo todo;

  @override
  ConsumerState<TodoListTile> createState() => _TodoListTileState();
}

class _TodoListTileState extends ConsumerState<TodoListTile> {
  late Todo _todo;
  @override
  void initState() {
    super.initState();
    _todo = widget.todo;
  }

  bool get todoDone => _todo.done;

  set todoDone(bool done) {
    _todo.done = done;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.w),
      child: Dismissible(
        key: ValueKey(_todo.id),
        direction: DismissDirection.endToStart,
        background: ColoredBox(
          color: AppColors.red,
          child: Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Delete",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                )),
          ),
        ),
        onDismissed: (direction) {
          ref.read(todosProvider.notifier).removeTodo(_todo.id);
        },
        child: Row(
          children: [
            InkWell(
              onTap: () {
                ref.read(todosProvider.notifier).toggle(_todo.id);

                setState(() {
                  todoDone = !todoDone;
                });
              },
              child: !todoDone
                  ? ImageIcon(AssetImage("checkbox".iconPath))
                  : ImageIcon(
                      AssetImage(
                        "checkbox_checked".iconPath,
                      ),
                      color: Colors.green,
                    ),
            ),
            8.width,
            Text(
              _todo.title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: todoDone ? AppColors.grey : AppColors.black,
                  decoration: todoDone ? TextDecoration.lineThrough : null),
            ),
            const Spacer(),
            if (!todoDone)
              Text(
                _todo.time,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColors.black),
              ),
            4.width,
            Icon(
              Icons.arrow_forward_ios,
              size: 12.w,
            ),
          ],
        ),
      ),
    );
  }
}
