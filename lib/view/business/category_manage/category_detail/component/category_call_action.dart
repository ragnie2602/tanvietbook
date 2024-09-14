import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/constants.dart';
import '../../../../../shared/widgets/container/primary_container.dart';
import '../../../../../shared/widgets/dialog_helper.dart';
import '../../../../../shared/widgets/primary_button.dart';
import '../../../../../shared/widgets/secondary_text_field.dart';
import '../bloc/category_call_action_bloc/category_call_action_bloc.dart';
import '../bloc/category_detail_bloc.dart';
import 'category_base_item.dart';

import '../../../../../data/resources/resources.dart';
import '../../../../../model/business/landing_page/landing_page_call_action_response.dart';
import '../../../../../shared/widgets/loading.dart';
import '../../../../../shared/utils/utils.dart';

class CategoryCallAction extends CategoryBaseItem {
  final CategoryDetailBloc categoryDetailBloc;
  final CategoryCallActionBloc callActionBloc;
  final LandingPageItemViewType viewType;
  final int index;
  final String? title;
  final String? id;
  final String? concernId;
  final String? concernName;
  final String? concernType;
  final String? concernImage;
  final LandingPageCallActionResponse? callActionInfo;
  final dynamic background;

  const CategoryCallAction({
    Key? key,
    this.title,
    required this.categoryDetailBloc,
    required this.index,
    this.id,
    this.viewType = LandingPageItemViewType.forLandingPageEdit,
    this.callActionInfo,
    this.background,
    this.concernId,
    this.concernName,
    this.concernType,
    this.concernImage,
    required this.callActionBloc,
  }) : super(key: key);

  @override
  State<CategoryCallAction> createState() => _CategoryCallActionState();
}

class _CategoryCallActionState extends CategoryBaseItemState<CategoryCallAction>
    with CategoryBaseItemScreen {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final noteController = TextEditingController();
  final addressController = TextEditingController();

  final nameFormKey = GlobalKey<FormState>();
  final phoneFormKey = GlobalKey<FormState>();

  CategoryCallActionBloc categoryCallActionBloc = CategoryCallActionBloc();

  @override
  String type() {
    return CategoryContentType.callAction;
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
    return categoryCallActionBloc;
  }

  @override
  String landingId() {
    return widget.id ?? '';
  }

  @override
  void initState() {
    if (viewType() == LandingPageItemViewType.forLandingPageEdit ||
        viewType() == LandingPageItemViewType.forLandingPageView) {
      categoryCallActionBloc
          .add(CategoryCallActionInitEvent(landingId: widget.id ?? ''));
    }
    super.initState();
  }

  @override
  Widget body() {
    final textTheme = widget.background is Color
        ? AppTextTheme.textPrimaryBold
        : AppTextTheme.textPrimaryBold.copyWith(color: AppColor.white);
    if (viewType() == LandingPageItemViewType.forPostView) {
      return Stack(
        children: [
          widget.background is Color
              ? const SizedBox()
              : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset("assets/images/bg_call_action.png",
                      fit: BoxFit.fitWidth)),
          PrimaryContainer(
            padding: const EdgeInsets.all(16),
            backgroundColor: widget.background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title ??
                      'Bạn có thắc mắc? Đừng lo, hãy để lại liên hệ ngay cho chúng tôi',
                  style: textTheme,
                ),
                const SizedBox(height: 10),
                SecondaryTextField(
                  controller: nameController,
                  label: 'Họ tên',
                  labelStyle: textTheme,
                  isRequired: true,
                  textCapitalization: TextCapitalization.words,
                  validator: Utils.textEmptyValidator,
                  formKey: nameFormKey,
                ),
                const SizedBox(height: 10),
                SecondaryTextField(
                    label: 'Email',
                    labelStyle: textTheme,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController),
                const SizedBox(height: 10),
                SecondaryTextField(
                    label: 'Số điện thoại',
                    labelStyle: textTheme,
                    isRequired: true,
                    validator: Utils.textEmptyValidator,
                    keyboardType: TextInputType.phone,
                    formKey: phoneFormKey,
                    controller: phoneController),
                const SizedBox(height: 10),
                SecondaryTextField(
                  label: 'Địa chỉ',
                  labelStyle: textTheme,
                  controller: addressController,
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: 10),
                SecondaryTextField(
                  label: 'Lời nhắn',
                  labelStyle: textTheme,
                  controller: noteController,
                  textCapitalization: TextCapitalization.sentences,
                  minLines: 3,
                ),
                const SizedBox(height: 10),
                if (widget.viewType == LandingPageItemViewType.forPostView)
                  PrimaryButton(
                      context: context,
                      onPressed: () {
                        bool checkName = nameFormKey.currentState!.validate();
                        bool checkPhoneNumber =
                            phoneFormKey.currentState!.validate();

                        if (!checkName || !checkPhoneNumber) return;

                        widget.callActionBloc.concernResponse =
                            widget.callActionBloc.concernResponse.copyWith(
                          concernId: widget.concernId,
                          fullName: nameController.text.trim(),
                          type: widget.concernType,
                          email: emailController.text.trim(),
                          address: addressController.text.trim(),
                          phonenumber: phoneController.text.trim(),
                          status: 0,
                          concernName: widget.concernName,
                          concernImage: widget.concernImage != null
                              ? [widget.concernImage!]
                              : null,
                          note: noteController.text.trim(),
                        );

                        showDialog(
                            context: context,
                            builder: (builder) => getLoadingDialog(),
                            barrierDismissible: false);
                        widget.callActionBloc
                            .add(CategoryCallActionCreateActionEvent());
                      },
                      label: 'Gửi lời nhắn')
              ],
            ),
          )
        ],
      );
    } else if (viewType() == LandingPageItemViewType.forButtonShow) {
      return SingleChildScrollView(
        child: PrimaryContainer(
          padding: const EdgeInsets.all(16),
          backgroundColor: widget.background ?? AppColor.primarySwatch,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.callActionInfo?.title ??
                    'Bạn có thắc mắc? Đừng lo, hãy để lại liên hệ ngay cho chúng tôi',
                style: textTheme,
              ),
              const SizedBox(height: 10),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: widget.callActionInfo?.actions?.length ?? 0,
                  itemBuilder: (context, index) {
                    return SecondaryTextField(
                      controller: nameController,
                      label: LandingPageCallActionOptions.list[int.parse(
                          widget.callActionInfo?.actions?[index] ?? "0")],
                      labelStyle: textTheme,
                      textCapitalization: TextCapitalization.words,
                      isRequired: true,
                      // formKey: nameFormKey,
                      validator: Utils.textEmptyValidator,
                    );
                  }),
              const SizedBox(height: 20),
              // if (widget.forView == true)
              PrimaryButton(
                  context: context,
                  onPressed: () {
                    bool checkName = nameFormKey.currentState!.validate();
                    bool checkPhoneNumber =
                        phoneFormKey.currentState!.validate();
                    if (!checkName || !checkPhoneNumber) return;
                    widget.callActionBloc.concernResponse =
                        widget.callActionBloc.concernResponse.copyWith(
                      concernId: widget.concernId,
                      fullName: nameController.text.trim(),
                      type: widget.concernType,
                      email: emailController.text.trim(),
                      phonenumber: phoneController.text.trim(),
                      status: 0,
                      concernName: widget.concernName,
                      concernImage: widget.concernImage != null
                          ? [widget.concernImage!]
                          : null,
                      note: noteController.text.trim(),
                    );
                    showDialog(
                        context: context,
                        builder: (builder) => getLoadingDialog(),
                        barrierDismissible: false);
                    widget.callActionBloc
                        .add(CategoryCallActionCreateActionEvent());
                  },
                  label: widget.callActionInfo?.actionInfor ?? 'Gửi yêu cầu')
            ],
          ),
        ),
      );
    } else {
      return BlocProvider.value(
        value: categoryCallActionBloc,
        child: BlocBuilder<CategoryCallActionBloc, CategoryCallActionState>(
          builder: (context, state) {
            if (state is CategoryCallActionInitial) {
              return Stack(
                children: [
                  widget.background is Color
                      ? const SizedBox()
                      : const SizedBox(
                          // width: MediaQuery.of(context).size.width,
                          // child: Image.asset("assets/images/bg_call_action.png",
                          //     fit: BoxFit.fill),
                          ),
                  PrimaryContainer(
                    padding: const EdgeInsets.all(16),
                    backgroundColor:
                        widget.background ?? AppColor.primarySwatch,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title ??
                              'Bạn có thắc mắc? Đừng lo, hãy để lại liên hệ ngay cho chúng tôi',
                          style: textTheme,
                        ),
                        const SizedBox(height: 10),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemCount:
                                state.callActionInfo.actions?.length ?? 0,
                            itemBuilder: (context, index) {
                              return SecondaryTextField(
                                controller: nameController,
                                label: LandingPageCallActionOptions.list[
                                    int.parse(
                                        state.callActionInfo.actions?[index] ??
                                            "0")],
                                labelStyle: textTheme,
                                textCapitalization: TextCapitalization.words,
                                isRequired: true,
                                // formKey: nameFormKey,
                                validator: Utils.textEmptyValidator,
                              );
                            }),
                        const SizedBox(height: 20),
                        // if (widget.forView == true)
                        PrimaryButton(
                            context: context,
                            onPressed: () {
                              bool checkName =
                                  nameFormKey.currentState!.validate();
                              bool checkPhoneNumber =
                                  phoneFormKey.currentState!.validate();

                              if (!checkName || !checkPhoneNumber) return;

                              widget.callActionBloc.concernResponse = widget
                                  .callActionBloc.concernResponse
                                  .copyWith(
                                concernId: widget.concernId,
                                fullName: nameController.text.trim(),
                                type: widget.concernType,
                                email: emailController.text.trim(),
                                phonenumber: phoneController.text.trim(),
                                status: 0,
                                concernName: widget.concernName,
                                concernImage: widget.concernImage != null
                                    ? [widget.concernImage!]
                                    : null,
                                note: noteController.text.trim(),
                              );
                              showDialog(
                                  context: context,
                                  builder: (builder) => getLoadingDialog(),
                                  barrierDismissible: false);
                              widget.callActionBloc
                                  .add(CategoryCallActionCreateActionEvent());
                            },
                            label: state.callActionInfo.actionInfor ??
                                'Gửi yêu cầu')
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const Loading();
            }
          },
        ),
      );
    }
  }
}
