import 'package:consultant_app/repositories/Admin/Category/all_categories.dart';
import 'package:consultant_app/repositories/Admin/Category/category_create.dart';
import 'package:consultant_app/repositories/Admin/Status/r_status_screen.dart';
import 'package:consultant_app/repositories/Admin/Users/all_users.dart';
import 'package:consultant_app/repositories/Admin/Users/create_user.dart';
import 'package:consultant_app/utils/SharedPref.dart';
import 'package:consultant_app/view/auth/TabBarScreen.dart';
import 'package:consultant_app/view/auth/login/LoginScreen.dart';
import 'package:consultant_app/view/auth/login/LoginVM.dart';
import 'package:consultant_app/view/auth/register/RegisterScreen.dart';
import 'package:consultant_app/view/auth/register/RegisterVM.dart';
import 'package:consultant_app/view/auth/splach/SplashScreen.dart';
import 'package:consultant_app/view/category/categoriy_screen.dart';
import 'package:consultant_app/view/details/DetailsScreen.dart';
import 'package:consultant_app/view/details/DetailsVM.dart';
import 'package:consultant_app/view/filter/FilterVM.dart';
import 'package:consultant_app/view/home/HomeScreen.dart';
import 'package:consultant_app/view/home/HomeVM.dart';
import 'package:consultant_app/view/mails_by_status/MailsByStatusScreen.dart';
import 'package:consultant_app/view/mails_by_status/MailsByStatusVM.dart';
import 'package:consultant_app/view/mails_by_tag/MailsByTagScreen.dart';
import 'package:consultant_app/view/mails_by_tag/MailsByTagVM.dart';
import 'package:consultant_app/view/search/SearchVM.dart';
 import 'package:consultant_app/view/status/StatusScreen.dart';
import 'package:consultant_app/view/tag/TagScreen.dart';
import 'package:consultant_app/view/tag/TagVM.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'view/status/StatusVM.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final applicationDocDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(applicationDocDir.path);
  await Hive.openBox("myBox");
  await SharedPref.inst.onInit();

  //
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => LoginVM()),
        ChangeNotifierProvider(
            create: (_) => RegisterVM(sharedPref: SharedPref())),
        ChangeNotifierProvider(create: (_) => StatusVM()),
        ChangeNotifierProvider(create: (_) => HomeVM()),
        ChangeNotifierProvider(create: (_) => DetailsVM()),
        ChangeNotifierProvider(create: (_) => ProviderTags()),
        ChangeNotifierProvider(create: (_) => MailsByTagVM()),
        ChangeNotifierProvider(create: (_) => MailsByStatusVM()),
        ChangeNotifierProvider(create: (_) => SearchVM()),
        ChangeNotifierProvider(create: (_) => FilterVM()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, child!),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(color: const Color(0xFFF5F5F5))),
      debugShowCheckedModeBanner: false,
      title: 'Pal Mail',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/TabBar': (context) => TabBarScreen(),
        '/Login': (context) => LoginScreen(),
        '/Register': (context) => RegisterScreen(),
        '/Home': (context) => HomeScreen(),
        '/Details': (context) => DetailsScreen(),
        '/Statuses': (context) => StatusScreen(),
        '/Tags': (context) => TagScreen(),
        '/MailByTag': (context) => MailsByTagScreen(),
        '/MailByStatus': (context) => MailsByStatusScreen(),
        '/Admin/CreateUser': (context) => CreateUser(),
        '/Admin/Users': (context) => AllUsers(),
        'Admin/Category': (context) => AdminCatgeoryScreen(),
        'Admin/status': (context) => RStatusScreen(),
        '/Admin/Category/create': (context) => CreateCategory(),
        '/Category': (context) => CategoriyScreen(),
      },
    );
  }
}
