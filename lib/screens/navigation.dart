import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:townhall_todo/router/base_navigator.dart';
import 'package:townhall_todo/screens/add_todo/add_todo_screen.dart';
import 'package:townhall_todo/screens/done/done_screen.dart';
import 'package:townhall_todo/screens/home/home_screen.dart';
import 'package:townhall_todo/utils/colors.dart';
import 'package:townhall_todo/utils/extensions.dart';

class Navigation extends StatefulWidget {
  static const routeName = "navigation";
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: () {
        switch (currentIndex) {
          case 0:
            return const HomeScreen();

          case 1:
            return const DoneScreen();
          default:
        }
      }(),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.grey,
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("home_unfilled".iconPath)),
                activeIcon: ImageIcon(AssetImage("home".iconPath)),
                label: "Home"),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("done".iconPath)),
                activeIcon: ImageIcon(AssetImage("checkbox_checked".iconPath)),
                label: "Done"),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("setting".iconPath)),
                label: "Settings"),
          ]),
      floatingActionButton: SpeedDial(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        icon: Icons.add,
        activeIcon: Icons.close,
        animatedIconTheme: const IconThemeData(size: 22),
        backgroundColor: AppColors.primaryColor,
        activeBackgroundColor: const Color(0xff645A51),
        visible: true,
        curve: Curves.bounceIn,
        iconTheme: const IconThemeData(color: Colors.white),
        overlayColor: const Color(0xff1B1818),
        overlayOpacity: 0.16,
        children: [
          // FAB 1
          SpeedDialChild(
            labelWidget: InkWell(
              child: Container(
                decoration: ShapeDecoration(
                  color: const Color(0xFF51526B),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  children: [
                    ImageIcon(
                      AssetImage("note".iconPath),
                      color: Colors.white,
                    ),
                    10.width,
                    Text(
                      "Add Note",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
            backgroundColor: const Color(0xFF801E48),
          ),
          // FAB 2
          SpeedDialChild(
            labelWidget: Container(
              decoration: ShapeDecoration(
                color: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                children: [
                  ImageIcon(
                    AssetImage("todo".iconPath),
                    color: Colors.white,
                  ),
                  10.width,
                  Text(
                    "Add To-do",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            onTap: () {
              // BaseNavigator.pop();
              BaseNavigator.pushNamed(AddTodoScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
