import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/routes.dart';
import '../../data/constants.dart';
import '../../data/resources/resources.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/widgets/button/primary_group_radio_button.dart';
import '../../shared/widgets/container/primary_container.dart';
import '../../shared/widgets/loading.dart';
import '../../shared/widgets/primary_app_bar.dart';
import '../../shared/widgets/primary_divider.dart';
import '../base/base_page_sate.dart';
import 'component/user_address_item.dart';
import 'cubit/agency_cubit.dart';

class AgencyUserAddressPage extends StatefulWidget {
  const AgencyUserAddressPage({super.key});

  @override
  State<AgencyUserAddressPage> createState() => _AgencyUserAddressPageState();
}

class _AgencyUserAddressPageState extends BasePageState<AgencyUserAddressPage, AgencyCubit> {
  @override
  PreferredSizeWidget? get appBar => const PrimaryAppBar(
        title: 'Chọn địa chỉ nhận hàng',
      );

  @override
  EdgeInsets get padding => const EdgeInsets.symmetric(vertical: 16);

  @override
  Color? get backgroundColor => AppColor.white;

  @override
  bool get useBlocProviderValue => true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = context.arguments as AgencyUserAddressPageAgrs;
    setCubit = args.agencyCubit;
    cubit.getAllAddressByUser();
  }

  late final AgencyUserAddressPageAgrs args;

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<AgencyCubit, AgencyState>(
      buildWhen: (previous, current) => current is GetAllUserAddresslSuccess,
      builder: (context, state) {
        return state.maybeWhen(getAllAddressByUserSuccess: (userAddresses) {
          return SingleChildScrollView(
            child: Column(
              children: [
                PrimaryGroupRadioButton(
                  key: UniqueKey(),
                  items: userAddresses
                      .map((e) => Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),
                                        UserAddressItem(
                                          userAddress: e,
                                          showSettingButton: false,
                                        ),
                                        const SizedBox(height: 10),
                                        if (e.status == AddressStatus.main)
                                          PrimaryContainer(
                                            borderColor: AppColor.secondaryColor,
                                            padding: const EdgeInsets.all(4),
                                            child: Text(
                                              'Mặc định',
                                              style: AppTextTheme.bodyMedium.copyWith(color: AppColor.secondaryColor),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoute.agencyAddUserAddress,
                                          arguments: AgencyAddUserAddressPageAgrs(userAddress: e, agencyCubit: cubit),
                                        );
                                      },
                                      child: SvgPicture.asset(Assets.icEdit)),
                                ],
                              ),
                              if (e.status == AddressStatus.main) const SizedBox(height: 10),
                              const PrimaryDivider(),
                            ],
                          ))
                      .toList(),
                  onChanged: (value) {
                    context.pop();
                    cubit.changeCurrentUserAddress(userAddresses[value.indexWhere((element) => element == true)]);
                  },
                  initialValue:
                      // init data with id == current selected user address
                      userAddresses.map((e) => e.id == args.currentUserAddress?.id).toList(),
                ),
                // const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoute.agencyAddUserAddress,
                        arguments: AgencyAddUserAddressPageAgrs(agencyCubit: cubit));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(Assets.iconAddCircle),
                      const SizedBox(width: 10),
                      const Text('Thêm địa chỉ nhận hàng'),
                    ],
                  ),
                )
              ],
            ),
          );
        }, orElse: () {
          return const Loading();
        });
      },
    );
  }
}
