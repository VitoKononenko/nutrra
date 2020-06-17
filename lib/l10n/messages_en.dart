// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String getRequiredField(String field) => 'Please fill the $field field';
  static String welcome(int id) => 'Welcome user, your id is: $id';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "title": MessageLookupByLibrary.simpleMessage("Nutrra Test"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "confirmPassword": MessageLookupByLibrary.simpleMessage("Confirm password"),
        "register": MessageLookupByLibrary.simpleMessage("Register"),
        "getRequiredField": getRequiredField,
        "invalidEmail": MessageLookupByLibrary.simpleMessage("Invalid email"),
        "passwordLength":
            MessageLookupByLibrary.simpleMessage("Password must have a length between 6 and 25 characters"),
        "equalPasswords": MessageLookupByLibrary.simpleMessage("Passwords must be equal"),
        "emailInUse": MessageLookupByLibrary.simpleMessage("Email Address already in use"),
        "somethingWentWrong": MessageLookupByLibrary.simpleMessage("Something went wrong"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "invalidAuthData": MessageLookupByLibrary.simpleMessage("Wrong email or password"),
        "noAccount": MessageLookupByLibrary.simpleMessage("No account?"),
        "logOut": MessageLookupByLibrary.simpleMessage("Logout"),
        "welcome": welcome,
      };
}
