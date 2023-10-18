import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:townhall_todo/router/base_navigator.dart';
import 'package:townhall_todo/screens/navigation.dart';
import 'package:townhall_todo/utils/colors.dart';
import 'package:townhall_todo/utils/extensions.dart';

class TodoAddedScreen extends StatelessWidget {
  static const routeName = "todo_added";
  const TodoAddedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            const Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'To-do Added',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF192028),
                        fontSize: 32,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    Text(
                      'Successfully',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF192028),
                        fontSize: 23,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                BaseNavigator.pushNamedAndclear(Navigation.routeName);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: ShapeDecoration(
                  color: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Center(
                  child: Text('Close',
                      style: Theme.of(context).textTheme.labelLarge),
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
