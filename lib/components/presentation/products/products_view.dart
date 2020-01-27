import 'package:elo_7/components/presentation/products/product/product_view.dart';
import 'package:elo_7/components/presentation/products/product/product_view_model.dart';
import 'package:elo_7/design_tokens.dart';
import 'package:elo_7/routing/router_contract.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math';
import 'products_view_bloc.dart';

class ProductsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductsViewBloc bloc = Provider.of<ProductsViewBloc>(context);
    final RouterContract router = Provider.of<RouterContract>(context);
    return StreamBuilder(
      stream: bloc.observeProducts,
      builder: (BuildContext context,
          AsyncSnapshot<Iterable<ProductViewModel>> snapshot) {
        if (!snapshot.hasData) {
          return _ShimmerView();
        }
        return GridView.builder(
          physics: ScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.86,
          ),
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            final ProductViewModel product = snapshot.data.elementAt(index);
            return GestureDetector(
              onTap: () {
                if (product.detailUrl != null && product.detailUrl.isNotEmpty) {
                  router.openWebView(
                    url: product.detailUrl,
                    title: product.title,
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductView(
                  product: product,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _ShimmerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = Size(MediaQuery.of(context).size.width * 0.42, 160);
    final LayoutTheme theme = LayoutTheme.of(context);
    return Padding(
      padding: EdgeInsets.all(LayoutTheme.of(context).edges.regular),
      child: Column(
        children: <Widget>[
          Flexible(
            child: Wrap(
              runAlignment: WrapAlignment.spaceBetween,
              spacing: LayoutTheme.of(context).edges.regular,
              children: <Widget>[
                for (int i = 0; i < 5; i++) _itemView(size, theme)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemView(Size size, LayoutTheme theme) => Shimmer.fromColors(
        baseColor: theme.colors.shimmerBase,
        highlightColor: theme.colors.shimmerHighlight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: theme.colors.shimmerBackground,
              width: size.width,
              height: size.height * 0.6,
            ),
            SizedBox(height: theme.edges.small),
            Container(
              color: theme.colors.shimmerBackground,
              width: _generateRandomWithMinPercentage(80) * size.width,
              height: size.height * 0.1,
            ),
            SizedBox(height: theme.edges.small),
            Container(
              color: theme.colors.shimmerBackground,
              width: _generateRandomWithMinPercentage(10) * size.width,
              height: size.height * 0.1,
            ),
            SizedBox(height: theme.edges.small),
            Container(
              color: theme.colors.shimmerBackground,
              width: _generateRandomWithMinPercentage(60) * size.width,
              height: size.height * 0.1,
            ),
            SizedBox(height: theme.edges.xLarge),
          ],
        ),
      );

  double _generateRandomWithMinPercentage(int percentage) =>
      (percentage + Random().nextInt(100 - percentage)) / 100;
}
