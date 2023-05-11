import 'package:consultant_app/repositories/Admin/Category/all_categories.dart';
import 'package:consultant_app/repositories/Admin/Category/category_create.dart';
import 'package:consultant_app/repositories/Admin/Status/r_status_screen.dart';
import 'package:consultant_app/repositories/Admin/Users/all_users.dart';
import 'package:consultant_app/repositories/Admin/Users/create_user.dart';
import 'package:consultant_app/utils/SharedPref.dart';
import 'package:consultant_app/view/auth/login/login_screen.dart';
import 'package:consultant_app/view/auth/login/login_vm.dart';
import 'package:consultant_app/view/auth/register/register_screen.dart';
import 'package:consultant_app/view/auth/register/register_vm.dart';
import 'package:consultant_app/view/auth/splach/splash_screen.dart';
import 'package:consultant_app/view/auth/tab_bar_screen.dart';
import 'package:consultant_app/view/category/categoriy_screen.dart';
import 'package:consultant_app/view/details/details_screen.dart';
import 'package:consultant_app/view/details/details_vm.dart';
import 'package:consultant_app/view/filter/filter_vm.dart';
import 'package:consultant_app/view/home/home_vm.dart';
import 'package:consultant_app/view/mails_by_status/mails_by_status_screen.dart';
import 'package:consultant_app/view/mails_by_status/mails_by_status_vm.dart';
import 'package:consultant_app/view/mails_by_tag/mails_by_tag_screen.dart';
import 'package:consultant_app/view/mails_by_tag/mails_by_tag_vm.dart';
import 'package:consultant_app/view/new_inbox/new_inbox_screen.dart';
import 'package:consultant_app/view/new_inbox/new_inbox_vm.dart';
import 'package:consultant_app/view/search/SearchVM.dart';
import 'package:consultant_app/view/status/StatusScreen.dart';
import 'package:consultant_app/view/tag/TagScreen.dart';
import 'package:consultant_app/view/tag/TagVM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'view/status/StatusVM.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final applicationDocDir = await getApplicationDocumentsDirectory();
  // await Hive.initFlutter(applicationDocDir.path);
  await SharedPref.inst.onInit();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginVM()),
        ChangeNotifierProvider(create: (_) => RegisterVM()),
        ChangeNotifierProvider(create: (_) => StatusVM()),
        ChangeNotifierProvider(create: (_) => HomeVM()),
        ChangeNotifierProvider(create: (_) => DetailsVM()),
        ChangeNotifierProvider(create: (_) => ProviderTags()),
        ChangeNotifierProvider(create: (_) => MailsByTagVM()),
        ChangeNotifierProvider(create: (_) => MailsByStatusVM()),
        ChangeNotifierProvider(create: (_) => SearchVM()),
        ChangeNotifierProvider(create: (_) => FilterVM()),
        ChangeNotifierProvider(create: (_) => NewInboxVM()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 780),
        builder: (context, child) => MaterialApp(
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
                //  '/Home': (context) => HomeScreen(),
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
                '/NewInbox': (context) => NewInboxScreen(),
              },
            ));
  }
}
