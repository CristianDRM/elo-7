import 'package:elo_7/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'products_category_filter_view_bloc.dart';

class ProductsCategoryFilterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductsCategoryFilterViewBloc bloc =
        Provider.of<ProductsCategoryFilterViewBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          I18n.of(context).category,
          style: Theme.of(context).textTheme.subhead,
        ),
        StreamBuilder(
            stream: bloc.selectedItem,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              return DropdownButton<String>(
                isExpanded: true,
                value: snapshot.data,
                items: bloc
                    .filters()
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ),
                    )
                    .toList(),
                onChanged: bloc.onChangeCategory,
              );
            }),
      ],
    );
  }
}
