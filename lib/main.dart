// Main app
import 'package:flutter/services.dart';
import 'package:walking_app/providers/hive_helper.dart';
import 'package:walking_app/providers/home_provider.dart';
import 'package:walking_app/providers/rive_helper.dart';
import 'package:walking_app/utils/app_colors.dart';
import 'package:walking_app/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HiveHelper.instance.initHive();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(
          create: (context) => RiveHelper(),
        ),
      ],
      child: MaterialApp(
        title: 'Walking App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.bgColor,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.darkRedBorderColor,
              fontSize: 20,
            ),
            iconTheme: IconThemeData(color: AppColors.darkRedBorderColor),
            actionsIconTheme:
                IconThemeData(color: AppColors.darkRedBorderColor),
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
        routes: AppRouter.instance.routes(),
        initialRoute: RouteNames.home.name,
      ),
    );
  }
}
