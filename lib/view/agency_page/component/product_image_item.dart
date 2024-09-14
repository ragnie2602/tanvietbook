import 'package:flutter/material.dart';

import '../../../data/constants.dart';
import '../../../data/resources/resources.dart';
import '../../../shared/widgets/carousel/primary_carousel.dart';

class ProductImageItemWidget extends StatelessWidget {
  final List<String> images;
  final int? productStatus;
  const ProductImageItemWidget(
      {super.key, required this.images, required this.productStatus});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: PrimaryCarousel(
              data: images,
              fit: BoxFit.contain,
              aspectRatio: 1,
              showIndicator: false,
              autoPlay: true,
            ),
          ),
          if (productStatus == ProductStatus.outOfStock)
            Positioned(
              right: 0,
              child: Image.asset(
                Assets.imOutOfStock,
                width: constraints.maxWidth / 2,
                height: constraints.maxWidth / 2,
              ),
            ),
          if (productStatus == ProductStatus.outOfProduct)
            Positioned(
              right: 0,
              child: Image.asset(
                Assets.imOutProduct,
                width: constraints.maxWidth / 2,
                height: constraints.maxWidth / 2,
              ),
            ),
        ],
      );
    });
  }
}
