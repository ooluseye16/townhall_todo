import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:townhall_todo/router/base_navigator.dart';
import 'package:townhall_todo/screens/home/category_screen.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.colors,
    required this.title,
  });

  final List<Color> colors;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BaseNavigator.pushNamed(CategoryScreen.routeName, args: title);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.00, -1.00),
            end: const Alignment(0, 1),
            colors: colors,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
