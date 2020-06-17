import 'package:flutter/material.dart';

import 'package:nutrra/nutrra_localizations.dart';
import 'package:nutrra/user/user.dart';

import 'enhanced_text_form_field.dart';

class EmailFormField extends StatelessWidget {
  final FormFieldSetter<String> onSaved;

  const EmailFormField({
    Key key,
    @required this.onSaved,
  })  : assert(onSaved != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = NutrraLocalizations.of(context);

    return EnhancedTextFormField(
      decoration: InputDecoration(labelText: localizations.email),
      onSaved: onSaved,
      validator: (String email) {
        if (email == null || email.isEmpty) {
          return localizations.getRequiredField(localizations.email);
        } else if (!AuthPayload.validateEmail(email)) {
          return localizations.invalidEmail;
        }

        return null;
      },
    );
  }
}
