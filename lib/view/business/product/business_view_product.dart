import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import '../../../config/routes.dart';
import '../../../data/constants.dart';
import '../../../data/resources/resources.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/utils/view_utils.dart';
import '../../../shared/widgets/carousel/primary_carousel.dart';
import '../../../shared/widgets/loading.dart';
import '../../../shared/widgets/primary_app_bar.dart';
import '../../../shared/widgets/primary_button.dart';
import '../bloc/business_bloc.dart';
import '../category_manage/category_detail/bloc/category_call_action_bloc/category_call_action_bloc.dart';
import '../category_manage/category_detail/bloc/category_detail_bloc.dart';
import '../category_manage/category_detail/component/category_call_action.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../shared/widgets/primary_icon_button.dart';
import '../../../shared/widgets/quill/primary_editor.dart';

class BusinessViewProduct extends StatelessWidget {
  const BusinessViewProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actionWidgetKey = GlobalKey();
    final BusinessBloc businessBloc = BusinessBloc();
    late CategoryCallActionBloc callActionBloc = CategoryCallActionBloc();

    final args =
        ModalRoute.of(context)?.settings.arguments as BusinessViewProductArgs;
    return BlocProvider(
      create: (context) =>
          businessBloc..add(BusinessGetProductDetailEvent(pid: args.productId)),
      child: Scaffold(
        backgroundColor: AppColor.primaryBackgroundColor,
        appBar: const PrimaryAppBar(
          title: 'Chi tiết bài đăng',
        ),
        body: SafeArea(child: BlocBuilder<BusinessBloc, BusinessState>(
          builder: (context, state) {
            if (state is BusinessGetProductDetailSuccessState) {
              final productDetail = state.productDetailResponse;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (productDetail.images ?? []).isNotEmpty
                        ? PrimaryCarousel(data: productDetail.images)
                        : const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            productDetail.postName ?? '',
                            style: AppTextTheme.textPrimaryBoldMedium,
                          ),
                          const SizedBox(height: 20),
                          Wrap(
                            children: [
                              Text(
                                Utils.formatMoney(
                                    productDetail.discountPrices ?? 0),
                                style: AppTextTheme.textPrimaryBold
                                    .copyWith(color: AppColor.secondaryColor),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                Utils.formatMoney(productDetail.prices ?? 0),
                                style: AppTextTheme.textPrimaryBold.copyWith(
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PrimaryButton(
                                  context: context,
                                  icon: Assets.icInterest,
                                  onPressed: () {
                                    Scrollable.ensureVisible(
                                        actionWidgetKey.currentContext!);
                                  },
                                  label: 'Quan tâm'),
                              const SizedBox(width: 10),
                              PrimaryButton(
                                context: context,
                                icon: Assets.icShare,
                                onPressed: () {},
                                label: 'Chia sẻ',
                                backgroundColor: AppColor.white,
                                borderColor: AppColor.primaryColor,
                                textStyle: AppTextTheme.textPrimary,
                              ),
                              const SizedBox(width: 10),
                              PrimaryIconButton(
                                context: context,
                                icon: Assets.icQrCode,
                                iconColor: AppColor.primaryColor,
                                onPressed: () {},
                                borderColor: AppColor.primaryColor,
                              ),
                            ],
                          ),
                          SizedBox(
                              height: productDetail.description1 != null &&
                                      productDetail.description1 !=
                                          "[{\"insert\":\"\\n\"}]"
                                  ? 20
                                  : 0),
                          ProductInfo(
                            description: productDetail.description1,
                            link: productDetail.link1,
                            titleLink: productDetail.titleLink1,
                          ),
                          SizedBox(
                              height: productDetail.description2 != null &&
                                      productDetail.description2 !=
                                          "[{\"insert\":\"\\n\"}]"
                                  ? 20
                                  : 0),
                          ProductInfo(
                            description: productDetail.description2,
                            link: productDetail.link2,
                            titleLink: productDetail.titleLink2,
                          ),
                          const SizedBox(height: 20),
                          BlocProvider(
                            create: (context) => callActionBloc,
                            child: BlocListener<CategoryCallActionBloc,
                                CategoryCallActionState>(
                              listener: (context, state) {
                                if (state
                                    is CategoryCallActionCreateSuccessState) {
                                  Navigator.pop(context);
                                  toastSuccess(
                                      'Bạn đã quan tâm sản phẩm thành công');
                                }
                                if (state
                                    is CategoryCallActionCreateFailedState) {
                                  Navigator.pop(context);
                                  toastWarning(AlertText.error);
                                }
                              },
                              child: CategoryCallAction(
                                key: actionWidgetKey,
                                categoryDetailBloc: CategoryDetailBloc(),
                                index: 0,
                                callActionBloc: callActionBloc,
                                viewType: LandingPageItemViewType.forPostView,
                                concernId: productDetail.id,
                                title: productDetail.actionInfor,
                                background: AppColor.actionBackgroundColor,
                                concernName: productDetail.postName,
                                concernType: CategoryType.post,
                                concernImage:
                                    (productDetail.images ?? []).isNotEmpty
                                        ? productDetail.images!.first
                                        : null,
                              ),
                            ),
                          ),
                          const SizedBox(height: 200),
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const Center(
                child: Loading(),
              );
            }
          },
        )),
      ),
    );
  }
}

class ProductInfo extends StatelessWidget {
  final String? description;
  final String? titleLink;
  final String? link;
  const ProductInfo({Key? key, this.description, this.titleLink, this.link})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimaryEditor(
          readOnly: true,
          controller: QuillController.basic()
            ..document = Utils.parseQuillDocument(description),
        ),
        SizedBox(height: link != null ? 20 : 0),
        link != null
            ? YoutubePlayer.convertUrlToId(link!) != null
                ? Column(
                    children: [
                      YoutubePlayer(
                          bufferIndicator: const Loading(),
                          controller: YoutubePlayerController(
                            initialVideoId:
                                YoutubePlayer.convertUrlToId(link!)!,
                            flags: const YoutubePlayerFlags(
                              autoPlay: false,
                            ),
                          )),
                      const SizedBox(height: 10),
                      Text(
                        titleLink ?? '',
                        style: AppTextTheme.textPrimarySmallItalic,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\u2022 ${titleLink!}',
                        style: AppTextTheme.textPrimary,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(horizontal: 0))),
                        onPressed: () {
                          Utils.launchUri(link!, UriType.website);
                        },
                        child: Text(link!,
                            style: AppTextTheme.textPrimary.copyWith(
                                color: AppColor.inform,
                                decoration: TextDecoration.underline)),
                      ),
                    ],
                  )
            : const SizedBox(),
      ],
    );
  }
}
