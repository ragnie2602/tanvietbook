import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../data/constants.dart';
import '../../../../../../data/resources/resources.dart';
import '../../../../../../shared/widgets/button/action_button_edit_category.dart';
import '../../../../../../shared/widgets/secondary_text_field.dart';
import '../../../../../../shared/widgets/share_popup/primary_bottom_sheet.dart';
import '../../bloc/category_detail_bloc.dart';
import '../../bloc/category_link_bloc/category_link_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AddEditCategoryLink extends StatefulWidget {
  final CategoryLinkBloc categoryLinkBloc;
  final LandingPageViewType viewType;
  final CategoryDetailBloc? categoryDetailBloc;
  final int? position;

  const AddEditCategoryLink(
      {Key? key,
      required this.categoryLinkBloc,
      required this.viewType,
      this.categoryDetailBloc,
      this.position})
      : super(key: key);

  @override
  State<AddEditCategoryLink> createState() => _AddEditCategoryLinkState();
}

class _AddEditCategoryLinkState extends State<AddEditCategoryLink> {
  late YoutubePlayerController controller;
  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  Widget currentVid = const SizedBox();

  YoutubePlayerController createYoutubePlayerController(String vidUrl) {
    return YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(vidUrl)!,
        flags: const YoutubePlayerFlags(
          hideThumbnail: true,
          disableDragSeek: true,
          autoPlay: true,
          showLiveFullscreenButton: true,
        ));
  }

  @override
  void initState() {
    titleController.text = widget.categoryLinkBloc.currentLink.title ?? '';
    linkController.text = widget.categoryLinkBloc.currentLink.value ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryBottomSheet(
      title: 'Chỉnh sửa video',
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tiêu đề video', style: AppTextTheme.textPrimary),
                  SecondaryTextField(controller: titleController),
                  const SizedBox(height: 10),
                  SecondaryTextField(
                    controller: linkController,
                    label: 'Liên kết video',
                    onChanged: (value) {
                      try {
                        controller = createYoutubePlayerController(value!);
                        setState(() {
                          currentVid = YoutubePlayerBuilder(
                              player: YoutubePlayer(
                                controller: controller,
                              ),
                              builder: (context, player) => player);
                        });
                      } catch (e) {
                        setState(() {
                          currentVid = SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 10),
                                SvgPicture.asset(
                                    'assets/images/something_when_wrong.svg'),
                                const Text(
                                    'Liên kết video không đúng!\nSẽ không hiển thị được video')
                              ],
                            ),
                          );
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  currentVid,
                ],
              ),
            ),
            ActionButtonEditCategory(
              onCancel: () {},
              onSave: () {
                if (widget.viewType == LandingPageViewType.edit) {
                  widget.categoryLinkBloc.add(
                    CategoryLinkUpdateEvent(
                      title: titleController.text,
                      link: linkController.text,
                    ),
                  );
                } else {
                  widget.categoryDetailBloc?.add(
                    CategoryLinkAddEvent(
                      position: widget.position!,
                      title: titleController.text,
                      link: linkController.text,
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
