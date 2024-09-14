import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../shared/bloc/get_image/get_image_bloc.dart';
import '../../../../shared/widgets/image/primary_reorder_grid_image.dart';
import '../../bloc/business_update_bloc.dart';

import '../../../../data/resources/themes.dart';

class ProductUpdateImage extends StatelessWidget {
  final GetImageBloc getImageBloc;
  final BusinessUpdateBloc businessUpdateBloc;

  const ProductUpdateImage(
      {Key? key, required this.getImageBloc, required this.businessUpdateBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset('assets/icons/ic_camera.svg',
                color: Colors.black, height: 18, width: 18),
            const SizedBox(width: 10),
            const Text('Hình ảnh minh họa',
                style: AppTextTheme.textPrimaryBold),
            const SizedBox(width: 10),
          ],
        ),
        const SizedBox(height: 10),
        PrimaryReorderGridImage(
            childAspectRatio: 1,
            initialData: businessUpdateBloc.productDetailResponse.images ?? [],
            getImageBloc: getImageBloc)
      ],
    );
  }
}
