import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../bloc/app_bloc.dart';
import '../../../../config/config.dart';
import '../../../../domain/entities/product_model.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) => current is ThemeChangedAppState,
      builder: (context, state) {
        return Card(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: AppColors.white,
                  padding: const EdgeInsets.all(10),
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: AppColors.primary),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        RatingBar(
                          itemSize: 15,
                          initialRating: product.rating.rate,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          ratingWidget: RatingWidget(
                            full: const Icon(Icons.star_rounded,
                                color: AppColors.rating, size: 18),
                            half: const Icon(Icons.star_half_rounded,
                                color: AppColors.rating, size: 18),
                            empty: const Icon(Icons.star_border_rounded,
                                color: AppColors.rating, size: 18),
                          ),
                          glow: false,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 0.0),
                          ignoreGestures: true,
                          onRatingUpdate: (double value) {},
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '(${product.rating.count})',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(product.category,
                        style: Theme.of(context).textTheme.headlineSmall),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Spacer(),
                        Text('\$${product.price}',
                            style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
      },
    );
  }
}
