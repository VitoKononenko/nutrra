import 'package:flutter/material.dart';
import 'package:nutrra/nutrra_localizations.dart';
import 'package:nutrra/user/view/login_screen/login_screen.dart';
import 'package:nutrra/widgets/common_button.dart';
import 'package:provider/provider.dart';

import 'home_screen_presenter.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/';
  static PageRoute<HomeScreen> getRoute() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) {
        return ChangeNotifierProvider(
          create: (_) => HomeScreenPresenter(),
          child: HomeScreen(),
        );
      },
    );
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final presenter = context.watch<HomeScreenPresenter>();
    final localizations = NutrraLocalizations.of(context);

    if (presenter.user == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              localizations.welcome(presenter.user.id),
              style: theme.textTheme.headline5,
            ),
            Divider(
              color: Colors.transparent,
            ),
            CommonButton(
              child: Text(localizations.logOut),
              onPressed: () async {
                await presenter.logOut();
                Navigator.of(context).pushAndRemoveUntil(LoginScreen.getRoute(), (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
