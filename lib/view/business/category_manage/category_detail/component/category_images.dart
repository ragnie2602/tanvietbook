import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/constants.dart';
import '../../../../../shared/widgets/carousel/primary_carousel.dart';

import '../../../../../shared/widgets/loading.dart';
import '../bloc/category_detail_bloc.dart';
import '../bloc/category_images_bloc/category_images_bloc.dart';
import 'category_base_item.dart';

class CategoryImages extends CategoryBaseItem {
  final String title;
  final String id;
  final LandingPageItemViewType viewType;
  final CategoryDetailBloc categoryDetailBloc;
  final int index;

  const CategoryImages(
      {required this.categoryDetailBloc,
      required this.index,
      Key? key,
      this.viewType = LandingPageItemViewType.forLandingPageEdit,
      required this.title,
      required this.id})
      : super(key: key);

  @override
  State<CategoryImages> createState() => _CategoryImagesState();
}

class _CategoryImagesState extends CategoryBaseItemState<CategoryImages>
    with CategoryBaseItemScreen {
  CategoryImagesBloc categoryImagesBloc = CategoryImagesBloc();

  @override
  String type() {
    return CategoryContentType.images;
  }

  @override
  CategoryDetailBloc categoryDetailBloc() {
    return widget.categoryDetailBloc;
  }

  @override
  int index() {
    return widget.index;
  }

  @override
  LandingPageItemViewType viewType() {
    return widget.viewType;
  }

  @override
  itemBloc() {
    return categoryImagesBloc;
  }

  @override
  String landingId() {
    return widget.id;
  }

  @override
  void initState() {
    categoryImagesBloc.add(CategoryImagesInitEvent(landingId: widget.id));
    super.initState();
  }

  @override
  Widget body() {
    return BlocProvider.value(
      value: itemBloc() as CategoryImagesBloc,
      child: BlocBuilder<CategoryImagesBloc, CategoryImagesState>(
        builder: (context, state) {
          if (state is CategoryImagesInitial) {
            if (state.listImage.isEmpty) {
              return Image.asset(
                "assets/images/placeholder.png",
                fit: BoxFit.cover,
              );
            } else {
              return PrimaryCarousel(
                autoPlay: false,
                data: state.listImage.map((e) => e.value ?? '').toList(),
              );
            }
          } else {
            return const Loading();
          }
        },
      ),
    );
  }
}
