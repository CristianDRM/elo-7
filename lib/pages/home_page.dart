import 'package:elo_7/generated/i18n.dart';
import 'package:elo_7/routing/router_contract.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RouterContract router = Provider.of<RouterContract>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context).home),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: router.openSearch),
        ],
      ),
    );
  }
}
