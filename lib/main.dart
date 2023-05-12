import 'package:consultant_app/utils/app_localizations.dart';
import 'package:consultant_app/utils/shared_pref.dart';
import 'package:consultant_app/view/screens/auth/login/login_screen.dart';
import 'package:consultant_app/view/screens/auth/login/login_vm.dart';
import 'package:consultant_app/view/screens/auth/register/register_screen.dart';
import 'package:consultant_app/view/screens/auth/register/register_vm.dart';
import 'package:consultant_app/view/screens/auth/splach/splash_screen.dart';
import 'package:consultant_app/view/screens/auth/tab_bar_screen.dart';
import 'package:consultant_app/view/screens/category/category_vm.dart';
import 'package:consultant_app/view/screens/details/details_vm.dart';
import 'package:consultant_app/view/screens/filter/filter_vm.dart';
import 'package:consultant_app/view/screens/home/home_vm.dart';
import 'package:consultant_app/view/screens/mails_by_status/mails_by_status_screen.dart';
import 'package:consultant_app/view/screens/mails_by_status/mails_by_status_vm.dart';
import 'package:consultant_app/view/screens/mails_by_tag/mails_by_tag_screen.dart';
import 'package:consultant_app/view/screens/mails_by_tag/mails_by_tag_vm.dart';
import 'package:consultant_app/view/screens/new_inbox/new_inbox_screen.dart';
import 'package:consultant_app/view/screens/new_inbox/new_inbox_vm.dart';
import 'package:consultant_app/view/screens/search/SearchVM.dart';
import 'package:consultant_app/view/screens/status/status_screen.dart';
import 'package:consultant_app/view/screens/status/status_vm.dart';
import 'package:consultant_app/view/screens/tags/tags_screen.dart';
import 'package:consultant_app/view/screens/tags/tags_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.inst.onInit();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginVM()),
        ChangeNotifierProvider(create: (_) => RegisterVM()),
        ChangeNotifierProvider(create: (_) => StatusVM()),
        ChangeNotifierProvider(create: (_) => HomeVM()),
        ChangeNotifierProvider(create: (_) => DetailsVM()),
        ChangeNotifierProvider(create: (_) => TagsVM()),
        ChangeNotifierProvider(create: (_) => MailsByTagVM()),
        ChangeNotifierProvider(create: (_) => MailsByStatusVM()),
        ChangeNotifierProvider(create: (_) => SearchVM()),
        ChangeNotifierProvider(create: (_) => FilterVM()),
        ChangeNotifierProvider(create: (_) => NewInboxVM()),
        ChangeNotifierProvider(create: (_) => CategoryVM()),
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
              // Set the fallback locale to English
              locale: const Locale('en'),
              // Define the supported locales for your app
              supportedLocales: const [
                Locale('en', 'US'), // English
                Locale('ar', 'SA'), // Arabic
              ],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                // Add the generated AppLocalizations.delegate
                AppLocalizations.delegate,
              ],
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
                // '/Home': (context) => HomeScreen(),
                // '/Details': (context) => DetailsScreen(),
                '/Statuses': (context) => StatusScreen(),
                '/Tags': (context) => TagsScreen(),
                '/MailByTag': (context) => MailsByTagScreen(),
                '/MailByStatus': (context) => MailsByStatusScreen(),
                // '/Category': (context) => CategoriyScreen(),
                '/NewInbox': (context) => NewInboxScreen(),
              },
            ));
  }
}
