import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../data/resources/resources.dart';
import '../../../../model/business/business_get_all_response/business_get_all_response.dart';
import '../../../../shared/widgets/image/primary_image.dart';
import '../../../../shared/widgets/primary_button.dart';

import '../../bloc/business_bloc.dart';
import 'item_web_mini_info.dart';

class WebMiniConfig extends StatefulWidget {
  const WebMiniConfig({Key? key, required this.businessBloc}) : super(key: key);
  final BusinessBloc businessBloc;

  @override
  State<WebMiniConfig> createState() => _WebMiniConfigState();
}

class _WebMiniConfigState extends State<WebMiniConfig> {
  String currentValue = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BusinessBloc>.value(
      value: widget.businessBloc,
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Expanded(
                  child: Text('Thay đổi Website Mini',
                      style: AppTextTheme.textPrimary),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
          ),
          const Divider(color: AppColor.gray09, height: 0),
          BlocBuilder<BusinessBloc, BusinessState>(
            builder: (context, state) {
              final List<BusinessGetAllResponse> businessList =
                  widget.businessBloc.businessList;
              if (businessList.isNotEmpty) {
                currentValue = businessList
                        .where((element) =>
                            element.id ==
                            widget.businessBloc.currentSelectedBusinessId)
                        .first
                        .websiteName ??
                    '';

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: businessList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      setState(() {
                        currentValue = businessList[index].websiteName ?? '';
                      });
                    },
                    leading: PrimaryNetworkImage(
                        imageUrl: businessList[index].logo ?? '', height: 32),
                    title: Text(
                      businessList[index].websiteName ?? '',
                      style: AppTextTheme.textPrimary,
                    ),
                    trailing: Radio<String>(
                      groupValue: currentValue,
                      value: businessList[index].websiteName.toString(),
                      onChanged: (value) {
                        setState(() {
                          currentValue =
                              businessList[index].websiteName.toString();
                        });
                        widget.businessBloc
                            .currentSelectedBusinessId = businessList
                                .where(
                                    (element) => element.websiteName == value)
                                .first
                                .websiteName ??
                            '';
                        widget.businessBloc.add(BusinessGetOverallEvent());
                      },
                    ),
                  ),
                );
              } else {
                return Center(
                  child: SvgPicture.asset(Assets.icNoData),
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                PrimaryButton(
                  context: context,
                  onPressed: () {},
                  iconColor: AppColor.white,
                  icon: Icons.add,
                  label: 'Tạo mới Website Mini',
                ),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/ic_setting.svg"),
                      const SizedBox(width: 10),
                      const Text('Quản lý Website Mini',
                          style: AppTextTheme.textPrimaryColor)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: const BoxDecoration(color: AppColor.primaryFadeColor),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/icons/ic_crown.svg"),
                    const SizedBox(width: 5),
                    const Text(
                      "Đang xử dụng gói Website 1",
                      style: AppTextTheme.textPrimaryBold,
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ItemWebMiniInfo(text: "2 danh mục website"),
                        SizedBox(height: 15),
                        ItemWebMiniInfo(text: "4 bài đăng"),
                        SizedBox(height: 15),
                        ItemWebMiniInfo(text: "5 hình ảnh, 2 liên kết"),
                      ],
                    ),
                    SvgPicture.asset("assets/icons/ic_trophy.svg")
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/ic_timer'),
                    RichText(
                      text: const TextSpan(
                        text: "Còn lại: ",
                        style: AppTextTheme.textPrimaryBold,
                        children: [
                          TextSpan(
                              text: "36 ngày 24 giờ",
                              style: AppTextTheme.textRed)
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Tăng số lượng danh mục website, bài đăng, hình ảnh để Website của bạn nổi bật và thu hút hơn!',
                  style: AppTextTheme.textPrimarySmall,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text('Tham khảo thêm',
                        style: AppTextTheme.textPrimaryColor),
                    const SizedBox(width: 5),
                    SvgPicture.asset(
                      "assets/icons/ic_arrow_direct.svg",
                      width: 12,
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 23),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                SvgPicture.asset("assets/icons/ic_earphone.svg"),
                const SizedBox(width: 13),
                const Text(
                  'Trợ giúp và phản hồi',
                  style: AppTextTheme.textPrimary,
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
