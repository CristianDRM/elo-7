import 'package:elo_7/design_tokens.dart';
import 'package:flutter/material.dart';

import 'product_view_model.dart';

class ProductView extends StatelessWidget {
  const ProductView({
    @required this.product,
  }) : assert(product != null);
  final ProductViewModel product;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final LayoutTheme customTheme = LayoutTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: customTheme.product.imageHeight,
          child: product.picture.isNotEmpty
              ? Image.network(
                  product.picture,
                  fit: BoxFit.cover,
                )
              : Placeholder(),
        ),
        Text(
          product.title,
          style: theme.textTheme.subhead,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          children: <Widget>[
            Text(
              product.price,
              style: theme.textTheme.subhead.copyWith(
                color: customTheme.colors.price,
              ),
            ),
            if (product.hasDiscount) ...[
              SizedBox(width: customTheme.edges.small),
              Text(
                product.priceWithDiscount,
                style: theme.textTheme.caption.copyWith(
                  fontWeight: FontWeight.w300,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ],
        ),
        if (product.hasInstallment)
          Text(
            product.installment,
            style: theme.textTheme.caption,
          ),
      ],
    );
  }
}
