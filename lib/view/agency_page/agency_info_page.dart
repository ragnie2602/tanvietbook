import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../../data/resources/resources.dart';
import '../../domain/entity/agency/agency_detail.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/quill/primary_editor.dart';
import 'agency_page.dart';

class AgencyInfoPage extends StatefulWidget {
  final AgencyDetail agencyDetail;
  const AgencyInfoPage({super.key, required this.agencyDetail});

  @override
  State<AgencyInfoPage> createState() => _AgencyInfoPageState();
}

class _AgencyInfoPageState extends State<AgencyInfoPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: AppColor.white,
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông tin mô tả',
            style: AppTextTheme.bodyStrong.copyWith(
              color: AppColor.primaryColor,
              fontSize: 20,
              decoration: TextDecoration.underline,
              decorationColor: AppColor.secondaryColor,
              // decorationStyle: TextDecorationStyle.dashed,
              decorationThickness: 1.5,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          PrimaryEditor(
            controller: QuillController.basic()
              ..document =
                  Utils.parseQuillDocument(widget.agencyDetail.description),
            readOnly: true,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '${widget.agencyDetail.name}',
            style: AppTextTheme.bodyStrong.copyWith(
              color: AppColor.primaryColor,
              fontSize: 20,
              decoration: TextDecoration.underline,
              decorationColor: AppColor.secondaryColor,
              // decorationStyle: TextDecorationStyle.dashed,
              decorationThickness: 1.5,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Lĩnh vực hoạt động: ${widget.agencyDetail.field}',
            style:
                AppTextTheme.bodyMedium.copyWith(color: AppColor.primaryColor),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: (widget.agencyDetail.path ?? [])
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child:
                          getAgencyInfoItemByType(e.type ?? '', e.value ?? ''),
                    ))
                .toList()
              ..add(
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: getAgencyInfoItemByType(
                      'Address', widget.agencyDetail.address ?? ''),
                ),
              ),
          )
        ],
      )),
    );
  }
}
