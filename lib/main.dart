import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:townhall_todo/object_box_store.dart';
import 'package:townhall_todo/router/app_router.dart';
import 'package:townhall_todo/router/base_navigator.dart';
import 'package:townhall_todo/screens/navigation.dart';
import 'package:townhall_todo/utils/constants.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  objectbox = await ObjectBox.create();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        // minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: BaseNavigator.key,
            theme: ThemeData(
                textTheme: TextTheme(
                  bodySmall: TextStyle(
                    fontSize: 10.sp,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w400,
                  ),
                  bodyMedium: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w400,
                  ),
                  bodyLarge: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w400,
                  ),
                  headlineMedium: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w500,
                  ),
                  labelLarge: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xFFFF8C22),
                ),
                fontFamily: "SFPro"),
            onGenerateRoute: AppRouter.onGenerateRoute,
            initialRoute: Navigation.routeName,
          );
        });
  }
}
