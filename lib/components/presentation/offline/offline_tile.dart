import 'package:elo_7/design_tokens.dart';
import 'package:elo_7/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class OfflineTile extends StatelessWidget {
  OfflineTile({@required this.onRetry}) : assert(onRetry != null);
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) {
    final LayoutTheme customTheme = LayoutTheme.of(context);
    final ThemeData theme = Theme.of(context);
    return SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Transform.rotate(
            angle: 90 * math.pi / 180,
            child: Text(
              ':(',
              style: theme.textTheme.subhead.copyWith(fontSize: 80),
            ),
          ),
          SizedBox(height: customTheme.edges.large),
          Text(
            I18n.of(context).connection_error_title,
            textAlign: TextAlign.center,
            style: theme.textTheme.subhead,
          ),
          SizedBox(height: customTheme.edges.small),
          Text(
            I18n.of(context).connection_error_content,
            textAlign: TextAlign.center,
            style: theme.textTheme.subhead,
          ),
          SizedBox(height: customTheme.edges.xLarge),
          RaisedButton(
            color: theme.primaryColor,
            textColor: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(''),
                Icon(Icons.replay),
              ],
            ),
            onPressed: onRetry,
          ),
        ],
      ),
    );
  }
}
