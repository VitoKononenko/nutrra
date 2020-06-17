import 'package:flutter/material.dart';

import 'package:nutrra/nutrra_localizations.dart';
import 'package:nutrra/user/user.dart';

import 'enhanced_text_form_field.dart';

class PasswordFormField extends StatefulWidget {
  final Key formFieldKey;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final String label;

  PasswordFormField({
    Key key,
    @required this.onSaved,
    this.formFieldKey,
    this.validator,
    this.label,
  })  : assert(onSaved != null),
        super(key: key);

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool hide = true;

  @override
  Widget build(BuildContext context) {
    final localizations = NutrraLocalizations.of(context);

    return EnhancedTextFormField(
      key: widget.formFieldKey,
      obscureText: hide,
      decoration: InputDecoration(
        labelText: widget.label ?? localizations.password,
        suffixIcon: IconButton(
          icon: Icon(hide ? Icons.visibility : Icons.visibility_off),
          onPressed: toggleHide,
        ),
      ),
      onSaved: widget.onSaved,
      validator: widget.validator ?? validator,
    );
  }

  void toggleHide() {
    setState(() {
      hide = !hide;
    });
  }

  String validator(String password) {
    final localizations = NutrraLocalizations.of(context);

    if (password == null || password.isEmpty) {
      return localizations.getRequiredField(localizations.password);
    } else if (!AuthPayload.validatePassword(password)) {
      return localizations.passwordLength;
    }

    return null;
  }
}
