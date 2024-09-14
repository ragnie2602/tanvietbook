import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/routes.dart';
import '../../data/resources/resources.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/utils/utils.dart';
import '../../shared/utils/view_utils.dart';
import '../../shared/widgets/container/primary_container.dart';
import '../../shared/widgets/image/primary_circle_image.dart';
import '../../shared/widgets/primary_app_bar.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/secondary_text_field.dart';
import '../base/base_page_sate.dart';
import '../user_profile/bloc/user_info_bloc.dart';
import 'cubit/ano_card_cubit.dart';

class AnoCardActivationPage extends StatefulWidget {
  const AnoCardActivationPage({super.key});

  @override
  State<AnoCardActivationPage> createState() => _AnoCardActivationPageState();
}

class _AnoCardActivationPageState
    extends BasePageState<AnoCardActivationPage, AnoCardCubit> {
  @override
  void didChangeDependencies() {
    final args = context.arguments as AnoCardActivationPageArgs;
    super.didChangeDependencies();
    usernameController.text =
        context.read<UserInfoBloc>().memberInfo?.login ?? '';
    cardIdController.text = args.cardId;
  }

  @override
  PreferredSizeWidget? get appBar => const PrimaryAppBar(
        title: 'Kích hoạt thẻ',
      );
  @override
  bool get isUseLoading => true;

  final usernameController = TextEditingController();
  final cardIdController = TextEditingController();
  final keyController = TextEditingController();

  final usernameFormKey = GlobalKey<FormState>();
  final cardIdFormKey = GlobalKey<FormState>();
  final keyFormKey = GlobalKey<FormState>();

  String? keyErrorText;

  @override
  Widget buildPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset(Assets.imBgAnocard),
          const SizedBox(height: 20),
          PrimaryContainer(
            borderColor: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PrimaryCircleImage(
                  radius: 12,
                  imageUrl:
                      context.read<UserInfoBloc>().memberInfo?.avatar ?? '',
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  context.read<UserInfoBloc>().memberInfo?.fullName ?? '',
                  style: AppTextTheme.bodyRegular,
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          SecondaryTextField(
            controller: usernameController,
            formKey: usernameFormKey,
            label: 'Tên tài khoản',
            readOnly: true,
            isRequired: true,
            validator: Utils.textEmptyValidator,
          ),
          const SizedBox(height: 20),
          SecondaryTextField(
            controller: cardIdController,
            formKey: cardIdFormKey,
            label: 'Mã định danh(ID thẻ)',
            readOnly: true,
            isRequired: true,
            validator: Utils.textEmptyValidator,
          ),
          const SizedBox(height: 20),
          SecondaryTextField(
            controller: keyController,
            formKey: keyFormKey,
            label: 'Mã xác nhận (Key)',
            isRequired: true,
            onChanged: (value) {
              keyErrorText = null;
              setState(() {});
            },
            validator: Utils.textEmptyValidator,
            errorText: keyErrorText,
          ),
          const SizedBox(height: 20),
          const Text(
              'Nếu muốn kích hoạt thẻ với tài khoản khác. Vui lòng đăng nhập với tài khoản đó và kích hoạt thẻ.'),
          const SizedBox(height: 20),
          BlocListener<AnoCardCubit, AnoCardState>(
            listener: (context, state) {
              state.when(
                initial: () {},
                activeSuccess: () {
                  hideLoading();
                  toastSuccess('Chúc mừng bạn đã kích hoạt thẻ thành công.');
                  context.pop(true);
                },
                activeFailed: (message) {
                  hideLoading();
                  // keyFormKey.currentState?.validate();
                  setState(() {
                    keyErrorText = '*Mã xác nhận không chính xác ';
                  });
                },
              );
            },
            child: PrimaryButton(
              context: context,
              onPressed: () {
                showLoading();
                cubit.activeAnoCard(
                  cardId: cardIdController.text.trim(),
                  key: keyController.text.trim(),
                );
              },
              label: 'Kích hoạt thẻ',
            ),
          )
        ],
      ),
    );
  }
}
