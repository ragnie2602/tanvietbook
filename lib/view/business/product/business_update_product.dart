import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/routes.dart';
import '../../../data/constants.dart';
import '../../../data/resources/resources.dart';
import '../../../shared/widgets/button/action_button.dart';
import '../../../shared/widgets/dialog_helper.dart';
import '../../../shared/widgets/loading.dart';
import '../../../shared/widgets/primary_app_bar.dart';
import 'component/product_description.dart';
import 'component/product_update_additional_link.dart';
import 'component/product_update_image.dart';

import '../../../model/business/product/product_detail_response.dart';
import '../../../shared/bloc/get_image/get_image_bloc.dart';
import '../bloc/business_bloc.dart';
import '../bloc/business_update_bloc.dart';

class BusinessUpdateProduct extends StatelessWidget {
  const BusinessUpdateProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GetImageBloc getImageBloc = GetImageBloc();
    final businessUpdateBloc = BusinessUpdateBloc();
    final BusinessBloc businessBloc = BusinessBloc();

    late bool Function() updateProductDescriptionInfo;
    late Function() updateBusinessAdditionalLink1;
    late Function() updateBusinessAdditionalLink2;
    final args =
        ModalRoute.of(context)!.settings.arguments as BusinessUpdateProductArgs;
    if (args.isAddNew) {
      businessUpdateBloc.productDetailResponse = const ProductDetailResponse();
      businessBloc.add(BusinessGetCategoryEvent(
          subTabId: args.subTabId, type: CategoryType.post));
    } else {
      businessBloc.add(BusinessGetProductDetailEvent(pid: args.productId!));
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<GetImageBloc>(
          create: (context) => getImageBloc,
        ),
        BlocProvider<BusinessUpdateBloc>(
          create: (context) => businessUpdateBloc,
        ),
        BlocProvider<BusinessBloc>(create: (context) => businessBloc),
      ],
      child: Scaffold(
        backgroundColor: AppColor.primaryBackgroundColor,
        appBar: PrimaryAppBar(
            title: args.isAddNew ? 'Thêm mới bài đăng' : 'Chỉnh sửa bài đăng'),
        body: SafeArea(
            child: BlocConsumer<BusinessBloc, BusinessState>(
          listener: (context, state) {
            if (state is BusinessGetProductDetailSuccessState) {
              // assert that this is called after product detail is got
              businessBloc.add(BusinessGetCategoryEvent(
                  subTabId: args.subTabId, type: CategoryType.post));
              businessUpdateBloc.productDetailResponse =
                  state.productDetailResponse;
            }
          },
          buildWhen: (pre, current) =>
              (current is BusinessGetProductDetailSuccessState &&
                  pre is BusinessInitial) ||
              current is BusinessGetProductDetailFailedState,
          builder: (context, state) {
            if (state is BusinessGetProductDetailSuccessState ||
                args.isAddNew) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductDescription(
                        isAddNew: args.isAddNew,
                        businessUpdateBloc: businessUpdateBloc,
                        productDescriptionUpdateCallback: (callbackFunc) {
                          updateProductDescriptionInfo = callbackFunc;
                        },
                      ),
                      const SizedBox(height: 20),
                      ProductUpdateAdditionalLink(
                        businessUpdateBloc: businessUpdateBloc,
                        index: 0,
                        updateCallback: (callback) {
                          updateBusinessAdditionalLink1 = callback;
                        },
                      ),
                      const SizedBox(height: 20),
                      ProductUpdateAdditionalLink(
                        businessUpdateBloc: businessUpdateBloc,
                        index: 1,
                        updateCallback: (callback) {
                          updateBusinessAdditionalLink2 = callback;
                        },
                      ),
                      const SizedBox(height: 20),
                      ProductUpdateImage(
                        getImageBloc: getImageBloc,
                        businessUpdateBloc: businessUpdateBloc,
                      ),
                      const SizedBox(height: 30),
                      MultiBlocListener(
                        listeners: [
                          BlocListener<BusinessUpdateBloc, BusinessUpdateState>(
                            listener: (context, state) {
                              if (state is BusinessUpdateProductSuccessState) {
                                Navigator.pop(context);
                                Navigator.pop(
                                    context, state.productDetailResponse);
                              }
                              if (state is BusinessUpdateProductFailedState) {
                                Navigator.pop(context);
                              }
                              if (state is BusinessCreateProductSuccessState) {
                                Navigator.pop(context);
                                Navigator.pop(
                                    context, state.productDetailResponse);
                              }
                              if (state is BusinessCreateProductFailedState) {
                                Navigator.pop(context);
                              }
                            },
                          ),
                          BlocListener<GetImageBloc, GetImageState>(
                            listener: (context, state) {
                              if (state
                                  is GetImageGetMultiImageUrlSuccessState) {
                                // the end of flow is ended with this process
                                businessUpdateBloc.productDetailResponse =
                                    businessUpdateBloc.productDetailResponse
                                        .copyWith(
                                  images: List<String>.from(state.imageData
                                      .where((element) =>
                                          element.type != ImageDataType.addNew)
                                      .map((e) => e.data)
                                      .toList()),
                                );
                                args.isAddNew
                                    ? businessUpdateBloc
                                        .add(BusinessCreateNewProductEvent())
                                    : businessUpdateBloc
                                        .add(BusinessUpdateProductEvent());
                              }
                              if (state is GetImageGetMultiImageUrlErrorState) {
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ],
                        child: ActionButton(
                          onSave: () {
                            bool isValidate =
                                updateProductDescriptionInfo.call();
                            if (!isValidate) return;
                            updateBusinessAdditionalLink1.call();
                            updateBusinessAdditionalLink2.call();
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) => getLoadingDialog());
                            getImageBloc.add(GetImageGetMultiImageUrlEvent());
                          },
                          onCancel: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: Loading());
            }
          },
        )),
      ),
    );
  }
}
