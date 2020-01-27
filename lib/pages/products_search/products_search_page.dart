import 'package:elo_7/components/presentation/offline/offline_tile.dart';
import 'package:elo_7/components/presentation/products/products_view.dart';
import 'package:elo_7/components/presentation/products_filter/name/products_filter_name_view.dart';
import 'package:elo_7/components/presentation/products_filter/category/products_category_filter_view.dart';
import 'package:elo_7/components/presentation/products_result_info/products_result_info_view.dart';
import 'package:elo_7/design_tokens.dart';
import 'package:elo_7/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'products_search_page_bloc.dart';

class ProductsSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LayoutTheme customTheme = LayoutTheme.of(context);
    final ProductsSearchPageBloc bloc =
        Provider.of<ProductsSearchPageBloc>(context);
    return Scaffold(
      endDrawer: SafeArea(
        child: Drawer(
          child: Padding(
            padding: EdgeInsets.all(customTheme.edges.regular),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  I18n.of(context).filter_by,
                  style: Theme.of(context).textTheme.subhead,
                ),
                SizedBox(height: customTheme.edges.large),
                ProductsCategoryFilterView(),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        actions: <Widget>[Container()],
        title: StreamBuilder(
          stream: bloc.observeInternetAvailability,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData && snapshot.data) {
              return ProductsFilterNameView();
            }
            return Container();
          },
        ),
      ),
      body: StreamBuilder(
        stream: bloc.observeInternetAvailability,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && !snapshot.data) {
            return Center(
              child: OfflineTile(
                onRetry: () {},
              ),
            );
          }
          return Column(
            children: <Widget>[
              ProductsResultInfoView(),
              Expanded(
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverFillRemaining(child: ProductsView()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
