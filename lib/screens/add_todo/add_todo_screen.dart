import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:townhall_todo/data/todo_notifier.dart';
import 'package:townhall_todo/model/todo.dart';
import 'package:townhall_todo/router/base_navigator.dart';
import 'package:townhall_todo/screens/add_todo/todo_added_screen.dart';
import 'package:townhall_todo/utils/colors.dart';
import 'package:townhall_todo/utils/constants.dart';
import 'package:townhall_todo/utils/extensions.dart';

class AddTodoScreen extends ConsumerStatefulWidget {
  static const routeName = "add_todo";
  const AddTodoScreen({super.key});

  @override
  ConsumerState<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends ConsumerState<AddTodoScreen> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  TimeOfDay? selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  bool newTask = true;

  int selectedIndex = 0;

  final TextEditingController subTextController = TextEditingController();
  final TextEditingController additionalDetailController =
      TextEditingController();

  final TextEditingController todoController = TextEditingController();

  List<String> subTask = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            56.height,
            Row(
              children: [
                InkWell(
                    onTap: () {
                      BaseNavigator.pop();
                    },
                    child: const Icon(Icons.close)),
                const Spacer(),
                Text(
                  "Add To-do",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: Colors.black),
                ),
                const Spacer(),
              ],
            ),
            32.height,
            const FormHeaderText(
              title: "To-do",
            ),
            TextField(
              style: Theme.of(context).textTheme.headlineMedium,
              controller: todoController,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "What do you want to do",
                hintStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 23.sp,
                      color: const Color(0xFFDEE1E4),
                    ),
              ),
            ),
            16.height,
            const FormHeaderText(
              title: "Date",
            ),
            6.height,
            InkWell(
              onTap: () => _selectDate(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ImageIcon(
                      AssetImage("calendar".iconPath),
                      size: 12.w,
                    ),
                    8.width,
                    Container(
                      width: 1.w,
                      height: 26.h,
                      decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
                    ),
                    8.width,
                    Expanded(
                      child: Text(
                          selectedDate != null
                              ? DateFormat("EEEE dd, MMMM")
                                  .format(selectedDate!)
                              : 'Select date',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: AppColors.subtitle3)),
                    ),
                  ],
                ),
              ),
            ),
            16.height,
            const FormHeaderText(title: "Time"),
            6.height,
            InkWell(
              onTap: () => _selectTime(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ImageIcon(
                      AssetImage("clock".iconPath),
                      size: 12.w,
                    ),
                    8.width,
                    Container(
                      width: 1.w,
                      height: 26.h,
                      decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
                    ),
                    8.width,
                    Text(
                        selectedTime != null
                            ? selectedTime!.format(context)
                            : 'Select Time',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: AppColors.subtitle3)),
                  ],
                ),
              ),
            ),
            16.height,
            const FormHeaderText(title: "Sub-Task"),
            6.height,
            if (subTask.isEmpty || newTask)
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      controller: subTextController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8)),
                        hintText: "Add sub-task",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: AppColors.subtitle3),
                      ),
                    ),
                  ),
                  8.width,
                  InkWell(
                    onTap: () {
                      //Add subTask
                      if (subTextController.text.isNotEmpty) {
                        subTask.add(subTextController.text);
                        subTextController.clear();
                        newTask = false;
                        setState(() {});
                      }
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.check,
                          size: 18.5.w,
                        ),
                        8.width,
                        Text(
                          "Add",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ...List.generate(
                subTask.length,
                (index) => Padding(
                      padding: EdgeInsets.fromLTRB(12.w, 12.h, 0, 0),
                      child: Row(
                        children: [
                          Text(subTask[index]),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              subTask.removeAt(index);
                              setState(() {});
                            },
                            child: Row(
                              children: [
                                ImageIcon(
                                  AssetImage("delete".iconPath),
                                  size: 12.w,
                                  color: AppColors.red,
                                ),
                                12.width,
                                Text(
                                  "Remove",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.red),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
            12.height,
            InkWell(
              onTap: () {
                setState(() {
                  newTask = true;
                });
              },
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: AppColors.teal,
                    size: 20.w,
                  ),
                  4.width,
                  Text(
                    "New sub-task",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500, color: AppColors.teal),
                  )
                ],
              ),
            ),
            16.height,
            const FormHeaderText(title: "Category"),
            6.height,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Row(
                    children: List.generate(
                      categories.length,
                      (index) {
                        final selected = selectedIndex == index;
                        return Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: SelectCategoryCard(
                            selected: selected,
                            onSelected: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            title: categories[index],
                          ),
                        );
                      },
                    ),
                  ),
                  const Icon(Icons.add),
                  const SizedBox(width: 8),
                  Text(
                    'Add\nCategories',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            16.height,
            //Additional Text
            const FormHeaderText(title: "Additional detail"),
            6.height,
            Container(
              height: 80.h,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: TextField(
                maxLines: null,
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                controller: additionalDetailController,
                decoration: InputDecoration(
                  // contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  hintText: "Write about the to-do",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColors.subtitle3),
                ),
              ),
            ),
            70.height,
            InkWell(
              onTap: () {
                if (todoController.text.isNotEmpty &&
                    selectedDate != null &&
                    selectedTime != null) {
                  ref.read(todosProvider.notifier).addTodo(Todo(
                      time: selectedTime!.format(context),
                      //id: const Uuid().v4(),
                      category: categories[selectedIndex],
                      title: todoController.text,
                      subTasks: subTask,
                      description: additionalDetailController.text,
                      date: selectedDate.toString()));
                  BaseNavigator.pushNamed(TodoAddedScreen.routeName);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: ShapeDecoration(
                  color: (todoController.text.isNotEmpty &&
                          selectedDate != null &&
                          selectedTime != null)
                      ? AppColors.primaryColor
                      : const Color(0xFFB6AFA8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    8.width,
                    Text('Add To-do',
                        style: Theme.of(context).textTheme.labelLarge),
                  ],
                ),
              ),
            ),
            48.height,
          ],
        ),
      ),
    );
  }
}

class SelectCategoryCard extends StatelessWidget {
  const SelectCategoryCard({
    super.key,
    required this.selected,
    required this.onSelected,
    required this.title,
  });

  final bool selected;
  final VoidCallback onSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelected,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: ShapeDecoration(
          color: selected ? const Color(0xFF10CFB1) : const Color(0xFF92A19F),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (selected)
              Icon(
                Icons.check,
                color: Colors.white,
                size: 20.w,
              ),
            if (selected) 4.width,
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class FormHeaderText extends StatelessWidget {
  const FormHeaderText({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.bodyMedium);
  }
}
