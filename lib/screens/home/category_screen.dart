import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:townhall_todo/data/todo_notifier.dart';
import 'package:townhall_todo/router/base_navigator.dart';
import 'package:townhall_todo/screens/widgets/todo_list_tile.dart';
import 'package:townhall_todo/utils/extensions.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = "category";
  const CategoryScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Consumer(builder: (context, ref, _) {
          final todos = ref.watch(todosProvider);
          final categoryTodos =
              todos.where((element) => element.category == title);
          final doneTodos = categoryTodos
              .where(
                (element) => element.done,
              )
              .toList();
          final notDoneTodos = categoryTodos
              .where(
                (element) => !element.done,
              )
              .toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              56.height,
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      BaseNavigator.pop();
                    },
                    child: const Icon(Icons.arrow_back_ios),
                  ),
                  const Spacer(),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Spacer(),
                ],
              ),
              24.height,
              ...List.generate(
                notDoneTodos.length,
                (index) => Column(
                  children: [
                    TodoListTile(
                      todo: notDoneTodos[index],
                    ),
                    const AppDivider(),
                  ],
                ),
              ),
              24.height,
              Text(
                "Done",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              16.height,
              ...List.generate(
                doneTodos.length,
                (index) => TodoListTile(
                  todo: doneTodos[index],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Color(0xFFEBEAEA),
          ),
        ),
      ),
    );
  }
}
