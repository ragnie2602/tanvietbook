import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import '../../../../../data/constants.dart';
import '../../../../../data/resources/colors.dart';
import 'category_base_item.dart';

import '../../../../../shared/utils/utils.dart';
import '../../../../../shared/widgets/container/primary_container.dart';
import '../../../../../shared/widgets/loading.dart';
import '../../../../../shared/widgets/quill/primary_editor.dart';
import '../bloc/category_content_bloc/category_content_bloc.dart';
import '../bloc/category_detail_bloc.dart';

class CategoryContent extends CategoryBaseItem {
  final CategoryDetailBloc categoryDetailBloc;
  final LandingPageItemViewType viewType;
  final int index;
  final String id;

  const CategoryContent(
      {this.viewType = LandingPageItemViewType.forLandingPageEdit,
      required this.id,
      required this.categoryDetailBloc,
      required this.index,
      Key? key})
      : super(key: key);

  @override
  State<CategoryContent> createState() => _CategoryContentState();
}

class _CategoryContentState extends CategoryBaseItemState<CategoryContent>
    with CategoryBaseItemScreen {
  final QuillController controller = QuillController.basic();
  CategoryContentBloc categoryContentBloc = CategoryContentBloc();

  @override
  void initState() {
    categoryContentBloc.add(CategoryContentInitEvent(landingId: widget.id));
    super.initState();
  }

  @override
  String type() {
    return CategoryContentType.content;
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
  String landingId() {
    return widget.id;
  }

  @override
  itemBloc() {
    return categoryContentBloc;
  }

  @override
  Widget body() {
    return BlocProvider.value(
      value: categoryContentBloc,
      child: BlocBuilder<CategoryContentBloc, CategoryContentState>(
        builder: (context, state) {
          if (state is CategoryContentInitial) {
            return PrimaryContainer(
              borderColor: AppColor.white,
              child: PrimaryEditor(
                readOnly: true,
                controller: controller
                  ..document =
                      Utils.parseQuillDocument(state.valueContent.value),
              ),
            );
          } else {
            return const Loading();
          }
        },
      ),
    );
  }
}
