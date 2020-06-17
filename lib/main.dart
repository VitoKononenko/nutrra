import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';

import 'package:nutrra/nutrra_localizations.dart';
import 'package:nutrra/user/api/http_user_repo.dart';
import 'package:nutrra/user/user.dart';
import 'package:nutrra/user/view/home_screen/home_screen.dart';
import 'package:nutrra/user/view/login_screen/login_screen.dart';
import 'package:nutrra/utils/store_interactor.dart';

const supportedLocales = [Locale("en")];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GetIt.I.registerSingleton<StoreInteractor>(StoreInteractor());
  GetIt.I.registerSingleton<UserRepo>(HttpUserRepo());
  GetIt.I.registerSingleton<UserService>(UserService());

  final currentUser = await GetIt.I.get<UserService>().getCurrentUser();

  runApp(
    MyApp(
      isLoggedIn: currentUser != null,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({
    Key key,
    @required this.isLoggedIn,
  })  : assert(isLoggedIn != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: MaterialApp(
        title: 'Nutrra Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        localizationsDelegates: [
          NutrraLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: supportedLocales,
        onGenerateRoute: (settings) {
          if (isLoggedIn) {
            return HomeScreen.getRoute();
          }
          return LoginScreen.getRoute();
        },
      ),
    );
  }
}
