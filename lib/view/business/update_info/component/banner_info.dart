import 'package:flutter/material.dart';
import '../../../../data/resources/themes.dart';
import '../../../../model/business/detail/business_detail_response.dart';
import '../../../../shared/widgets/image/primary_reorder_grid_image.dart';

import '../../../../shared/bloc/get_image/get_image_bloc.dart';

class BusinessUpdateBannerInfo extends StatelessWidget {
  final String defaultName;
  final List<BusinessBanner> banner;
  final GetImageBloc getImageBloc;

  const BusinessUpdateBannerInfo(
      {Key? key,
      required this.defaultName,
      required this.banner,
      required this.businessUpdateCallBack,
      required this.getImageBloc})
      : super(key: key);

  final Function(Map<String, dynamic> Function() updateBusinessDetail)
      businessUpdateCallBack;

  Map<String, dynamic> updateBusinessDetail() {
    return {
      "bannerList": "imageDataWrappers",
    };
  }

  @override
  Widget build(BuildContext context) {
    businessUpdateCallBack.call(updateBusinessDetail);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Banner $defaultName',
          style: AppTextTheme.textPrimaryBoldMedium,
        ),
        const SizedBox(height: 10),
        const Text(
          'Thu hút khách hàng hơn với banner thật chuyên nghiệp',
          style: AppTextTheme.textPrimary,
        ),
        const Text(
          '(Kéo thả để thay đổi vị trí)',
          style: AppTextTheme.textPrimarySmall,
        ),
        const SizedBox(height: 10),
        PrimaryReorderGridImage(
          maxQuantity: 5,
          initialData:
              List<String>.from(banner.map((e) => e.value ?? '')).toList(),
          getImageBloc: getImageBloc,
        )
      ],
    );
  }
}
