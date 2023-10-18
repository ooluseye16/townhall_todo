import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:townhall_todo/screens/home/widgets/categories/categories_view.dart';
import 'package:townhall_todo/screens/home/widgets/expansion_tiles/overdue_expansion_tile.dart';
import 'package:townhall_todo/screens/home/widgets/expansion_tiles/upcoming_expansion_tiles.dart';
import 'package:townhall_todo/utils/colors.dart';
import 'package:townhall_todo/utils/extensions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 45.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey,
                      ),
                    ),
                    8.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, Samuel I.',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: AppColors.black,
                              ),
                        ),
                        4.height,
                        Text('What do you have planned',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: AppColors.grey)),
                      ],
                    ),
                    const Spacer(),
                    ImageIcon(AssetImage("notification".iconPath)),
                  ],
                ),
                24.height,
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search for task, date or categories..",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.grey),
                    prefixIconConstraints:
                        BoxConstraints(minHeight: 16.h, minWidth: 16.h),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 12.w, right: 8.w),
                      child: ImageIcon(
                        AssetImage("search".iconPath),
                        color: const Color(0xff9CA2AA),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(width: 1.w, color: AppColors.borderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            width: 1.w, color: AppColors.borderColor)),
                  ),
                ),
              ],
            ),
          ),
          24.height,
          const CategoriesView(),
          24.height,
          Consumer(builder: (context, ref, _) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  const UpcomingExpansionTile(),
                  12.height,
                  const OverdueExpansionTile(),
                  12.height,
                  ExpansionTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    title: Text(
                      "Note",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: AppColors.black),
                    ),
                    // children: List.generate(
                    //     todos.length,
                    //     (index) => Padding(
                    //           padding: EdgeInsets.symmetric(horizontal: 12.w),
                    //           child: TodoListTile(
                    //             todo: todos[index],
                    //           ),
                    //         )),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
