import 'package:elo_7/components/presentation/products_result_info/products_result_info_view_bloc.dart';
import 'package:elo_7/design_tokens.dart';
import 'package:elo_7/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProductsResultInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductsResultInfoViewBloc bloc =
        Provider.of<ProductsResultInfoViewBloc>(context);
    final LayoutTheme customTheme = LayoutTheme.of(context);
    final ThemeData theme = Theme.of(context);
    return StreamBuilder(
      stream: bloc.observeCountOfProducts,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return _shimmerView(customTheme);
        }
        return DecoratedBox(
          decoration: BoxDecoration(color: theme.backgroundColor),
          child: LimitedBox(
            maxHeight: customTheme.button.height,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: customTheme.edges.regular,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: Center(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                I18n.of(context).products_summary(
                                  snapshot.data.toString(),
                                ),
                                style: Theme.of(context).textTheme.body2,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Scaffold.of(context).openEndDrawer(),
                          child: Container(
                            color: Theme.of(context).backgroundColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: customTheme.edges.regular,
                            ),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  I18n.of(context).filter,
                                  style: Theme.of(context).textTheme.button,
                                ),
                                SizedBox(
                                  width: customTheme.edges.regular,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  size: customTheme.edges.regular,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  color: theme.dividerColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _shimmerView(LayoutTheme theme) => Container(
        padding: EdgeInsets.all(theme.edges.regular),
        child: Shimmer.fromColors(
          baseColor: theme.colors.shimmerBase,
          highlightColor: theme.colors.shimmerHighlight,
          child: SizedBox(
            height: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(color: theme.colors.shimmerBackground, width: 120),
                Spacer(),
                Row(
                  children: <Widget>[
                    Container(color: theme.colors.shimmerBackground, width: 40),
                    SizedBox(width: theme.edges.small),
                    Container(color: theme.colors.shimmerBackground, width: 40),
                  ],
                ),
                SizedBox(height: theme.edges.xLarge)
              ],
            ),
          ),
        ),
      );
}
