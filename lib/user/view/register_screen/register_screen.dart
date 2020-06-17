import 'package:flutter/material.dart';
import 'package:nutrra/user/view/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

import 'package:nutrra/nutrra_localizations.dart';
import 'package:nutrra/user/user.dart';
import 'package:nutrra/user/view/register_screen/register_screen_presenter.dart';
import 'package:nutrra/widgets/common_button.dart';
import 'package:nutrra/widgets/email_form_field.dart';
import 'package:nutrra/widgets/focus_remover.dart';
import 'package:nutrra/widgets/password_form_field.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = '/register';
  static PageRoute<RegisterScreen> getRoute() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) {
        return ChangeNotifierProvider(
          create: (_) => RegisterScreenPresenter(),
          child: RegisterScreen(),
        );
      },
    );
  }

  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<FormFieldState> _passwordFieldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final localizations = NutrraLocalizations.of(context);
    final presenter = context.watch<RegisterScreenPresenter>();

    return FocusRemover(
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Form(
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
                  PasswordFormField(
                    label: localizations.confirmPassword,
                    onSaved: (confirmPassword) {
                      presenter.confirmPassword = confirmPassword;
                    },
                    validator: (String confirmPassword) {
                      if (confirmPassword == null || confirmPassword.isEmpty) {
                        return localizations.getRequiredField(localizations.confirmPassword);
                      } else if (_passwordFieldKey.currentState.value != confirmPassword) {
                        return localizations.equalPasswords;
                      }

                      return null;
                    },
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                  CommonButton(
                    child: Text(localizations.register),
                    onPressed: onRegister,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onRegister() async {
    final localizations = NutrraLocalizations.of(context);
    final presenter = context.read<RegisterScreenPresenter>();

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await presenter.register();
        Navigator.of(context).pushAndRemoveUntil(HomeScreen.getRoute(), (route) => false);
      } on EmailAlreadyInUseException {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(localizations.emailInUse),
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
