import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'l10n/messages_all.dart';

class NutrraLocalizations {
  static Future<NutrraLocalizations> load(Locale locale) {
    final String name = locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new NutrraLocalizations();
    });
  }

  static NutrraLocalizations of(BuildContext context) {
    return Localizations.of<NutrraLocalizations>(context, NutrraLocalizations);
  }

  String get title {
    return Intl.message(
      'Nutrra Test',
      name: 'title',
    );
  }

  String get email {
    return Intl.message(
      'Email',
      name: 'email',
    );
  }

  String get password {
    return Intl.message(
      'Password',
      name: 'password',
    );
  }

  String get confirmPassword {
    return Intl.message(
      'Confirm password',
      name: 'confirmPassword',
    );
  }

  String get register {
    return Intl.message(
      'Register',
      name: 'register',
    );
  }

  String getRequiredField(String field) {
    return Intl.message(
      '$field is required',
      args: [field],
      name: 'getRequiredField',
    );
  }

  String get invalidEmail {
    return Intl.message(
      'Invalid email',
      name: 'invalidEmail',
    );
  }

  String get passwordLength {
    return Intl.message(
      'Password must have a length between 6 and 25 characters',
      name: 'passwordLength',
    );
  }

  String get equalPasswords {
    return Intl.message(
      'Passwords must be equal',
      name: 'equalPasswords',
    );
  }

  String get emailInUse {
    return Intl.message(
      'Email Address already in use',
      name: 'emailInUse',
    );
  }

  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
    );
  }

  String get login {
    return Intl.message(
      'Login',
      name: 'login',
    );
  }

  String get invalidAuthData {
    return Intl.message(
      'Wrong email or password',
      name: 'invalidAuthData',
    );
  }

  String get noAccount {
    return Intl.message(
      'No account?',
      name: 'noAccount',
    );
  }

  String get logOut {
    return Intl.message(
      'Logout',
      name: 'logOut',
    );
  }

  String welcome(int id) {
    return Intl.message(
      'Welcome user, your id is: $id',
      args: [id],
      name: 'welcome',
    );
  }
}

class NutrraLocalizationsDelegate extends LocalizationsDelegate<NutrraLocalizations> {
  const NutrraLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en'].contains(locale.languageCode);
  }

  @override
  Future<NutrraLocalizations> load(Locale locale) {
    return NutrraLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<NutrraLocalizations> old) {
    return false;
  }
}
