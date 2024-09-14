import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/constants.dart';
import '../../../data/resources/resources.dart';
import '../../../domain/entity/agency/agency_detail.dart';
import '../../../shared/bloc/get_image/get_image_bloc.dart';
import '../../../shared/utils/view_utils.dart';
import '../../../shared/widgets/button/primary_group_radio_button.dart';
import '../../../shared/widgets/container/primary_container.dart';
import '../../../shared/widgets/image/primary_reorder_grid_image.dart';
import '../cubit/agency_cubit.dart';

class UserPaymentBlock extends StatelessWidget {
  final int shipFee;
  final AgencyDetail agencyDetail;

  const UserPaymentBlock({super.key, required this.shipFee, required this.agencyDetail});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetImageBloc>.value(
      value: context.read(),
      child: Column(
        children: [
          PrimaryContainer(
              padding: const EdgeInsets.only(right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16),
                    child: Row(
                      children: [
                        SvgPicture.asset(Assets.icDollar),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Phương thức thanh toán',
                          style: AppTextTheme.bodyStrong,
                        ),
                      ],
                    ),
                  ),
                  PrimaryGroupRadioButton(
                    items: const [
                      Expanded(
                        child: Text(
                          'Thanh toán khi nhận hàng',
                          style: AppTextTheme.bodyRegular,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Thanh toán qua chuyển khoản',
                          style: AppTextTheme.bodyRegular,
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value[0]) {
                        context.read<AgencyCubit>().changePaymentMethod(PaymentMethod.cash);
                      } else {
                        context.read<AgencyCubit>().changePaymentMethod(PaymentMethod.internetBanking);
                      }
                    },
                    initialValue: const [true, false],
                  )
                ],
              )),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<AgencyCubit, AgencyState>(
            buildWhen: (previous, current) => current is ChangePaymentMethodSuccess,
            builder: (context, state) {
              return state is ChangePaymentMethodSuccess && state.paymentMethod == PaymentMethod.internetBanking
                  ? BankPaymentInfo(
                      agencyDetail: agencyDetail,
                      getImageBloc: context.read(),
                    )
                  : const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}

class PaymentItem extends StatelessWidget {
  const PaymentItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class BankPaymentInfo extends StatelessWidget {
  final AgencyDetail agencyDetail;
  final GetImageBloc getImageBloc;
  const BankPaymentInfo({super.key, required this.agencyDetail, required this.getImageBloc});

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      child: PrimaryContainer(
        borderColor: AppColor.primaryColor,
        backgroundColor: AppColor.primaryBackgroundContainer,
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Thanh toán',
              style: AppTextTheme.bodyStrong,
            ),
            const Text(
              'Chuyển khoản vào số tài khoản và chụp ảnh chuyển khoản thành công vào đây:',
              style: AppTextTheme.bodyMedium,
            ),
            Row(
              children: [
                const Text(
                  'Số tài khoản:',
                  style: AppTextTheme.bodyMedium,
                ),
                TextButton(
                    onPressed: () {
                      Clipboard.setData(const ClipboardData(text: 'asdasd'));
                      toastSuccess('Sap chép thành công');
                    },
                    child: Row(
                      children: [
                        if (agencyDetail.path != null && agencyDetail.path!.isNotEmpty)
                          Text(
                            agencyDetail.path!.last.value ?? '',
                            style: AppTextTheme.bodyStrong.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        const SizedBox(
                          width: 4,
                        ),
                        SvgPicture.asset(Assets.icCopy),
                      ],
                    )),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Ngân hàng: ',
                  style: AppTextTheme.bodyMedium,
                ),
                if (agencyDetail.path != null && agencyDetail.path!.isNotEmpty)
                  Expanded(
                    child: Text(
                      agencyDetail.path!.last.type ?? '',
                      style: AppTextTheme.bodyStrong,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Chủ tài khoản: ',
                  style: AppTextTheme.bodyMedium,
                ),
                if (agencyDetail.path != null && agencyDetail.path!.isNotEmpty)
                  Expanded(
                    child: Text(
                      agencyDetail.path!.last.title ?? '',
                      style: AppTextTheme.bodyStrong,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(text: 'Nội dung chuyển khoản: '),
                  TextSpan(
                    text: '[Họ tên nhận hàng + SĐT nhận hàng + Mã sản phẩm đã đặt]',
                    style: AppTextTheme.bodyStrong,
                  ),
                ],
                style: AppTextTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Hình ảnh chuyển khoản:',
              style: AppTextTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            BlocProvider.value(
              value: getImageBloc,
              child: PrimaryReorderGridImage(
                initialData: const [],
                getImageBloc: getImageBloc,
                maxQuantity: 1,
                crossAxisCount: 1,
                // childAspectRatio: 9 / 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
