import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nutrra/user/view/home_screen/home_screen.dart';
import 'package:nutrra/user/view/register_screen/register_screen.dart';
import 'package:provider/provider.dart';

import 'package:nutrra/nutrra_localizations.dart';
import 'package:nutrra/user/user.dart';
import 'package:nutrra/widgets/common_button.dart';
import 'package:nutrra/widgets/email_form_field.dart';
import 'package:nutrra/widgets/focus_remover.dart';
import 'package:nutrra/widgets/password_form_field.dart';

import 'login_screen_presenter.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login';
  static PageRoute<LoginScreen> getRoute() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) {
        return ChangeNotifierProvider(
          create: (_) => LoginScreenPresenter(),
          child: LoginScreen(),
        );
      },
    );
  }

  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<FormFieldState> _passwordFieldKey = GlobalKey();

  TapGestureRecognizer _registerRecognizer;

  @override
  void initState() {
    _registerRecognizer = TapGestureRecognizer()..onTap = onRegister;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = NutrraLocalizations.of(context);
    final presenter = context.watch<LoginScreenPresenter>();

    return FocusRemover(
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EmailFormField(
                        onSaved: (email) {
                          presenter.email = email;
                        },
                      ),
                      PasswordFormField(
                        formFieldKey: _passwordFieldKey,
                        onSaved: (password) {
                          presenter.password = password;
                        },
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      CommonButton(
                        child: Text(localizations.login),
                        onPressed: onLogin,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text.rich(
                  TextSpan(text: localizations.noAccount, children: [
                    TextSpan(text: ' '),
                    TextSpan(
                      text: localizations.register,
                      recognizer: _registerRecognizer,
                      style: TextStyle(color: theme.primaryColorDark),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onRegister() {
    Navigator.of(context).push(RegisterScreen.getRoute());
  }

  Future<void> onLogin() async {
    final localizations = NutrraLocalizations.of(context);
    final presenter = context.read<LoginScreenPresenter>();

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await presenter.login();
        Navigator.of(context).pushAndRemoveUntil(HomeScreen.getRoute(), (route) => false);
      } on InvalidLoginDataException {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(localizations.invalidAuthData),
          ),
        );
      } catch (error) {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(localizations.somethingWentWrong),
          ),
        );
      }
    }
  }
}
