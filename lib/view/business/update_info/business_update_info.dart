import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/resources/resources.dart';
import '../../../model/business/detail/business_detail_response.dart';
import '../../../shared/utils/view_utils.dart';
import '../../../shared/widgets/button/action_button.dart';
import '../../../shared/widgets/dialog_helper.dart';
import '../bloc/business_update_bloc.dart';
import 'component/banner_info.dart';

import '../../../config/routes.dart';
import '../../../data/constants.dart';
import '../../../shared/bloc/get_image/get_image_bloc.dart';
import '../../../shared/widgets/container_shimmer.dart';
import '../../../shared/widgets/primary_app_bar.dart';
import '../../../shared/widgets/primary_shimmer.dart';
import '../bloc/business_bloc.dart';
import 'component/contact_info.dart';
import 'component/general_info.dart';

typedef BusinessUpdateCallBack = Function(
    BusinessDetailResponse businessDetail);

class BusinessUpdateInfo extends StatelessWidget {
  const BusinessUpdateInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final getImageBloc = GetImageBloc();
    final businessUpdateBloc = BusinessUpdateBloc();

    final BusinessUpdateInfoArgs args =
        ModalRoute.of(context)!.settings.arguments as BusinessUpdateInfoArgs;

    final BusinessBloc businessBloc = args.businessBloc;
    final defaultName = args.defaultName;

    late Function() businessGeneralDetailUpdate;
    late Function() businessContactDetailUpdate;
    late Map<String, dynamic> Function() businessBannerDetailUpdate;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: businessBloc..add(BusinessGetDetailEvent()),
        ),
        BlocProvider<GetImageBloc>(
          create: (context) => getImageBloc,
        ),
        BlocProvider<BusinessUpdateBloc>(
          create: (context) => businessUpdateBloc,
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColor.primaryBackgroundColor,
        appBar: PrimaryAppBar(
          title: 'Thông tin $defaultName',
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: BlocBuilder<BusinessBloc, BusinessState>(
                    builder: (context, state) {
                      if (state is BusinessGetDetailSuccessState) {
                        final businessDetail = state.businessDetailResponse;
                        businessUpdateBloc.businessDetailResponse =
                            businessUpdateBloc.businessDetailResponse
                                .copyWith(id: businessDetail.id);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BusinessUpdateGeneral(
                              businessDetail: businessDetail,
                              defaultName: defaultName,
                              businessUpdateCallBack: (callback) {
                                businessGeneralDetailUpdate = callback;
                              },
                              businessUpdateBloc: businessUpdateBloc,
                              getImageBloc: getImageBloc,
                            ),
                            const SizedBox(height: 30),
                            BusinessUpdateContactInfo(
                              businessUpdateCallBack: (callback) {
                                businessContactDetailUpdate = callback;
                              },
                              businessDetailResponse: businessDetail,
                              businessUpdateBloc: businessUpdateBloc,
                            ),
                            const SizedBox(height: 30),
                            BusinessUpdateBannerInfo(
                              businessUpdateCallBack: (callback) {
                                businessBannerDetailUpdate = callback;
                              },
                              getImageBloc: getImageBloc,
                              defaultName: defaultName,
                              banner: businessDetail.banners ?? [],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            MultiBlocListener(
                              listeners: [
                                BlocListener<GetImageBloc, GetImageState>(
                                  listener: (context, state) {
                                    if (state
                                        is GetImageGetImageUrlSuccessState) {
                                      businessUpdateBloc
                                              .businessDetailResponse =
                                          businessUpdateBloc
                                              .businessDetailResponse
                                              .copyWith(logo: state.imageUrl);
                                      // if get avatar url is got successfully,
                                      // check whether banners is changed -> wait the banner is upload -> update business info
                                      getImageBloc
                                          .add(GetImageGetMultiImageUrlEvent());
                                      // if (!getImageBloc.hasNewImageData()) {
                                      //   businessUpdateBloc
                                      //       .add(BusinessUpdateInfoEvent());
                                      // }
                                    }
                                    if (state
                                        is GetImageGetImageUrlErrorState) {
                                      Navigator.pop(context);
                                    }
                                    if (state
                                        is GetImageGetMultiImageUrlSuccessState) {
                                      // the end of flow is ended with this process
                                      // businessUpdateBloc
                                      //         .businessDetailResponse =
                                      //     businessUpdateBloc
                                      //         .businessDetailResponse
                                      //         .copyWith(
                                      //             banners: List<
                                      //                         String>.from(
                                      //
                                      //                         .where((element) =>
                                      //                             element
                                      //                                 .type !=
                                      //                             ImageDataType
                                      //                                 .addNew)
                                      //                         .map(
                                      //                             (e) => e.data)
                                      //                         .toList())
                                      //                 .toList());
                                      businessUpdateBloc.add(
                                          BusinessUpdateInfoEvent(
                                              bannersImagePath:
                                                  List<String>.from(state
                                                      .imageData
                                                      .where((element) =>
                                                          element.type !=
                                                          ImageDataType.addNew)
                                                      .map((e) => e.data)
                                                      .toList())));
                                    }
                                    if (state
                                        is GetImageGetMultiImageUrlErrorState) {
                                      Navigator.pop(context);
                                    }
                                  },
                                ),
                                BlocListener<BusinessUpdateBloc,
                                    BusinessUpdateState>(
                                  listener: (context, state) {
                                    if (state
                                        is BusinessUpdateInfoSuccessState) {
                                      businessBloc.businessOverallResponse =
                                          businessBloc.businessOverallResponse
                                              .copyWith(
                                                  logo: state
                                                      .businessDetailResponse
                                                      .logo,
                                                  websiteName: state
                                                      .businessDetailResponse
                                                      .websiteName);
                                      businessBloc.add(BusinessRebuildEvent());
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      toastSuccess(AlertText.updateSuccess);
                                    }
                                    if (state
                                        is BusinessUpdateInfoFailedState) {
                                      Navigator.pop(context);
                                    }
                                  },
                                ),
                              ],
                              child: ActionButton(onSave: () {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) => getLoadingDialog());
                                businessGeneralDetailUpdate.call();
                                businessContactDetailUpdate.call();
                                businessBannerDetailUpdate.call();

                                // if avatar & banner is not changed -> update info immediately
                                // if (getImageBloc.currentImagePathList.isEmpty) {
                                //   businessUpdateBloc
                                //       .add(BusinessUpdateInfoEvent());
                                //   return; //
                                // }

                                // check if avatar image has changed
                                if (getImageBloc
                                    .currentImagePathList.isNotEmpty) {
                                  getImageBloc.add(GetImageGetImageUrlEvent(
                                      imagePath:
                                          getImageBloc.currentImagePathList[0],
                                      imageType: ImageType.none));
                                }

                                // update add the banner change event -> bloc will detect banner has changed or not
                                else {
                                  getImageBloc
                                      .add(GetImageGetMultiImageUrlEvent());
                                }

                                // businessBloc
                              }, onCancel: () {
                                Navigator.pop(context);
                              }),
                            ),
                          ],
                        );
                      } else {
                        return const PrimaryShimmer(child: ContainerShimmer());
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
