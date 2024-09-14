import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/routes.dart';
import '../../data/constants.dart';
import '../../data/resources/resources.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/carousel/primary_carousel.dart';
import '../../shared/widgets/container/primary_container.dart';
import '../../shared/widgets/image/primary_image.dart';
import '../../shared/widgets/loading.dart';
import '../../shared/widgets/no_data.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/quill/primary_editor.dart';
import '../base/base_page_sate.dart';
import 'component/agency_product_container.dart';
import 'component/folder_container_item.dart';
import 'component/widget_options.dart';
import 'cubit/agency_cubit.dart';

class AgencyPage extends StatefulWidget {
  const AgencyPage({super.key});

  @override
  State<AgencyPage> createState() => _AgencyPageState();
}

class _AgencyPageState extends BasePageState<AgencyPage, AgencyCubit> {
  @override
  bool get useBlocProviderValue => true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setCubit = context.read();
    cubit.getAgencyDetail();
  }

  @override
  EdgeInsets get padding => EdgeInsets.zero;

  @override
  Widget buildPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocConsumer<AgencyCubit, AgencyState>(
            listener: (context, state) {
              state.maybeWhen(
                  getDetailAgencySuccess: (agencyDetail) {
                    cubit.getAllAgencyProducts(pageSize: 15);
                  },
                  orElse: () {});
            },
            buildWhen: (previous, current) => current is DetailAgencySuccess,
            builder: (context, state) {
              return state.maybeWhen(
                initial: () {
                  return const Loading();
                },
                getDetailAgencySuccess: (agencyDetail) {
                  final descriptionController = QuillController.basic();
                  descriptionController.document =
                      Utils.parseQuillDocument(agencyDetail.description);
                  return Column(
                    children: [
                      PrimaryCarousel(
                        data: agencyDetail.background ?? [],
                        showIndicator: false,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FolderContainerItem(
                        header: PrimaryNetworkImage(
                            imageUrl: agencyDetail.logo ?? ''),
                        child: PrimaryEditor(
                          controller: descriptionController,
                          readOnly: true,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FolderContainerItem(
                        title: agencyDetail.name ?? '',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lĩnh vực hoạt động: ${agencyDetail.field}',
                              style: AppTextTheme.bodyMedium
                                  .copyWith(color: AppColor.primaryColor),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: (agencyDetail.path ?? [])
                                          .map((e) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: getAgencyInfoItemByType(
                                                    e.type ?? '',
                                                    e.value ?? ''),
                                              ))
                                          .toList()
                                        ..add(Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: getAgencyInfoItemByType(
                                              'Address',
                                              agencyDetail.address ?? ''),
                                        )),
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: SvgPicture.asset(
                                      Assets.icPendingCollaborator),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FolderContainerItem(
                        header: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Những sản phẩm nổi bật của',
                                style: AppTextTheme.titleMedium
                                    .copyWith(color: AppColor.primaryColor)),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('${agencyDetail.name}',
                                    style: AppTextTheme.titleMedium.copyWith(
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.w700)),
                                const Icon(
                                  Icons.keyboard_arrow_right_sharp,
                                  color: AppColor.primaryColor,
                                )
                              ],
                            ),
                          ],
                        ),
                        child:
                            AgencyProductContainer(agencyDetail: agencyDetail),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoute.agencyDetailPage,
                            arguments: AgencyDetailPageAgrs(
                              agencyCubit: cubit,
                              agencyDetail: agencyDetail,
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (agencyDetail.listAgencyCateProd != null &&
                          agencyDetail.listAgencyCateProd!.isNotEmpty)
                        ListView.builder(
                          itemCount: agencyDetail.listAgencyCateProd?.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final category =
                                agencyDetail.listAgencyCateProd![index];
                            return PrimaryContainer(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: Column(
                                children: [
                                  Text(category.name.toString(),
                                      style: AppTextTheme.titleMedium.copyWith(
                                        color: AppColor.primaryColor,
                                        fontSize: 20,
                                      )),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  PrimaryNetworkImage(
                                    imageUrl: category.image ?? '',
                                    height: context.screenWidth * 9 / 16,
                                    width: context.screenWidth,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  PrimaryButton(
                                    context: context,
                                    onPressed: () {
                                      Utils.launchUri(
                                          category.link ?? '', UriType.website);
                                    },
                                    label: category.description.toString(),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  );
                },
                getDetailAgencyFailed: () {
                  return const NoData();
                },
                orElse: () {
                  return const NoData();
                },
              );
            },
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: AppColor.bgColor,
            child: Column(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height / 8),
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Center(
                  child: Text(
                      'Hệ sinh thái công nghệ giúp doanh nghiệp tăng trưởng trên nền tảng số',
                      textAlign: TextAlign.center,
                      style: AppTextTheme.textPrimaryBoldLarge.copyWith(
                          color: const Color(0xFF1F1B63),
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: WidgetOption(
                        path: Assets.icWebsiteMini,
                        widgetName: "Website mini",
                        align: 1,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: WidgetOption(
                        path: Assets.icVisitCard,
                        widgetName: "Danh thiếp",
                        align: 0,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: WidgetOption(
                        path: Assets.icBlueVisa,
                        widgetName: "Visa xanh",
                        align: -1,
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}

Widget getAgencyInfoItemByType(String type, String data) {
  switch (type) {
    case "Email":
      return Row(
        children: [
          SvgPicture.asset(
            Assets.icEmail,
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              data,
              style: AppTextTheme.bodyRegular,
            ),
          )
        ],
      );
    case "Số điện thoại":
      return Row(
        children: [
          SvgPicture.asset(
            Assets.icPhone,
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              data,
              style: AppTextTheme.bodyRegular,
            ),
          )
        ],
      );
    case "Address":
      return Row(
        children: [
          SvgPicture.asset(
            Assets.icLocation,
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              data,
              style: AppTextTheme.bodyRegular,
            ),
          )
        ],
      );

    default:
      return Row(
        children: [
          SvgPicture.asset(
            Assets.icSolution,
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              data,
              style: AppTextTheme.bodyRegular,
            ),
          )
        ],
      );
  }
}
