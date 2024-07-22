import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:task_27_03/color/app_color.dart';
import 'package:task_27_03/provider/cart_total.dart';
import 'package:task_27_03/provider/chat_provider.dart';

import 'generated/l10n.dart';
import 'router/my_router.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(
    const Duration(seconds: 3),
  );
  FlutterNativeSplash.remove();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ChatProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => TotalProvider(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (BuildContext context) => S.of(context).appTitle,
          theme: ThemeData(
            primaryColor: Colors.green,
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple, primary: AppColor.green),
            useMaterial3: true,
          ),
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          initialRoute: MyRouter.root,
          onGenerateRoute: (settings) {
            return MyRouter.onGenerateRoute(settings);
          },
          onUnknownRoute: (settings) {
            return MyRouter.onUnknownRoute(settings);
          },
          // home: const BrandingScreen(),
        ),
      ),
    );
  }
}
