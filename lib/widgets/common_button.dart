import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  CommonButton({
    Key key,
    @required this.child,
    @required this.onPressed,
  })  : assert(child != null),
        assert(onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: FlatButton(
        color: theme.primaryColor,
        child: DefaultTextStyle(
          style: theme.accentTextTheme.button,
          child: child,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
