import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes.dart';
import '../../../data/resources/resources.dart';
import '../../../domain/entity/user_address/user_address.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/image/primary_svg_picture.dart';
import '../cubit/agency_cubit.dart';

class UserAddressItem extends StatelessWidget {
  final UserAddress userAddress;
  final bool showSettingButton;
  final bool showLocationIcon;
  final Function()? onSettingPressed;
  const UserAddressItem({
    super.key,
    required this.userAddress,
    this.showSettingButton = true,
    this.onSettingPressed,
    this.showLocationIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (showLocationIcon)
                  const PrimarySvgPicture(
                    Assets.icLocation,
                    color: AppColor.secondaryColor,
                  ),
                if (showLocationIcon) const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${userAddress.name} | ${userAddress.phoneNumber}',
                    style: AppTextTheme.textPrimaryBold,
                  ),
                ),
                if (showSettingButton)
                  TextButton(
                    onPressed: onSettingPressed ??
                        () async {
                          final addressSelected = await Navigator.pushNamed(
                            context,
                            AppRoute.agencyUserAddressPage,
                            arguments: AgencyUserAddressPageAgrs(
                                currentUserAddress: userAddress,
                                agencyCubit: context.read()),
                          );
                          if (addressSelected != null) {
                            context.read<AgencyCubit>();
                          }
                        },
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(30, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Thiết lập'),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward_ios, size: 12)
                      ],
                    ),
                  ),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
            if (userAddress.email != null && userAddress.email!.isNotEmpty)
              const SizedBox(height: 10),
            if (userAddress.email != null && userAddress.email!.isNotEmpty)
              Text('${userAddress.email}'),
            const SizedBox(height: 10),
            Text(
              Utils.formatAddress(userAddress.address, userAddress.commune,
                  userAddress.district, userAddress.province),
            ),
          ],
        ),
      ],
    );
  }
}
