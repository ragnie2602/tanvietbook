import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/resources/themes.dart';
import '../../../../../shared/widgets/dot.dart';
import '../../../../../shared/widgets/loading.dart';
import 'category_base_item.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../data/constants.dart';
import '../../../../../data/resources/colors.dart';
import '../bloc/category_detail_bloc.dart';
import '../bloc/category_link_bloc/category_link_bloc.dart';

class CategoryLink extends CategoryBaseItem {
  final CategoryDetailBloc categoryDetailBloc;
  final String id;
  final int index;
  final LandingPageItemViewType viewType;

  const CategoryLink(
      {this.viewType = LandingPageItemViewType.forLandingPageEdit,
      required this.categoryDetailBloc,
      required this.index,
      required this.id,
      Key? key})
      : super(key: key);

  @override
  State<CategoryLink> createState() => _CategoryLinksState();
}

class _CategoryLinksState extends CategoryBaseItemState<CategoryLink>
    with CategoryBaseItemScreen {
  CategoryLinkBloc categoryLinkBloc = CategoryLinkBloc();
  late YoutubePlayerController controller;
  Widget currentVid = const SizedBox();

  YoutubePlayerController createYoutubePlayerController(String vidUrl) {
    return YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(vidUrl)!,
        flags: const YoutubePlayerFlags(
          hideThumbnail: true,
          disableDragSeek: true,
          autoPlay: false,
          showLiveFullscreenButton: true,
        ));
  }

  @override
  String type() {
    return CategoryContentType.link;
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
    return categoryLinkBloc;
  }

  @override
  void initState() {
    categoryLinkBloc.add(CategoryLinkInitEvent(landingId: widget.id));
    super.initState();
  }

  @override
  Widget body() {
    return BlocProvider.value(
      value: categoryLinkBloc,
      child: Container(
        color: AppColor.white,
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        child: BlocConsumer<CategoryLinkBloc, CategoryLinkState>(
          listener: (context, state) {
            if (state is CategoryLinkInitial) {
              try {
                controller = createYoutubePlayerController(
                    state.currentLink.value ?? '');
                currentVid = Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    YoutubePlayerBuilder(
                        player: YoutubePlayer(
                          controller: controller,
                        ),
                        builder: (context, player) => player),
                    const SizedBox(height: 5),
                    Text(
                      state.currentLink.title ?? '',
                      style: AppTextTheme.textPrimary.copyWith(fontSize: 12),
                    )
                  ],
                );
              } catch (e) {
                currentVid = Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Dot(),
                        const SizedBox(width: 5),
                        Text(
                          state.currentLink.title ?? '',
                          style:
                              AppTextTheme.textPrimary.copyWith(fontSize: 12),
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      state.currentLink.value ?? '',
                      style: AppTextTheme.textLink,
                    ),
                  ],
                );
              }
            }
          },
          builder: (context, state) {
            if (state is CategoryLinkInitial) {
              return currentVid;
            } else {
              return const Loading();
            }
          },
        ),
      ),
    );
  }
}
