import 'package:elo_7/design_tokens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'products_filter_name_view_bloc.dart';

class ProductsFilterNameView extends StatefulWidget {
  @override
  _ProductsFilterNameViewState createState() => _ProductsFilterNameViewState();
}

class _ProductsFilterNameViewState extends State<ProductsFilterNameView> {
  bool _isNotEmptySearch = true;
  TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController(text: '');

    _textController.addListener(() {
      if (_isNotEmptySearch != _textController.text.isNotEmpty) {
        setState(() => {_isNotEmptySearch = _textController.text.isNotEmpty});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ProductsFilterNameViewBloc bloc =
        Provider.of<ProductsFilterNameViewBloc>(context);
    final LayoutTheme customTheme = LayoutTheme.of(context);

    return TextFormField(
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        height: 1.5,
      ),
      controller: _textController,
      autofocus: true,
      cursorColor: Colors.white,
      onChanged: (a) => bloc.onNameChange(a),
      decoration: InputDecoration(
        focusColor: Colors.white,
        hintStyle: TextStyle(color: Colors.white),
        suffix: _isNotEmptySearch
            ? IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Colors.white,
                  size: customTheme.edges.regular,
                ),
                onPressed: () {
                  _textController.text = '';
                },
              )
            : null,
        hintText: 'Buscar',
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    );
  }
}
