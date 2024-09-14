import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../data/constants.dart';
import '../../../data/repository/remote/phonebook_repository.dart';
import '../../../data/resources/resources.dart';
import '../../../di/di.dart';
import '../../../model/phonebook/saved_contact_response.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/image/primary_circle_image.dart';
import '../../../shared/widgets/list_view/primary_paged_list_view.dart';
import '../bloc/saved_contacts_bloc/saved_contacts_bloc.dart';
import '../bloc/saved_contacts_bloc/saved_contacts_event.dart';
import '../../user_profile/user_profile.dart';

class SavedContactScreen extends StatefulWidget {
  const SavedContactScreen({Key? key}) : super(key: key);

  @override
  State<SavedContactScreen> createState() => _SavedContactScreenState();
}

class _SavedContactScreenState extends State<SavedContactScreen>
    with AutomaticKeepAliveClientMixin {
  final SavedContactsBloc bloc =
      SavedContactsBloc(phonebookRepository: getIt.get<PhonebookRepository>());

  @override
  void initState() {
    bloc.savedContactPagingController.addPageRequestListener((pageKey) {
      bloc.add(SavedContactsEventInit(pageNum: pageKey, pageSize: 15));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
        create: (context) => bloc,
        lazy: false,
        child: PrimaryPagedListView<SavedContactResponseData>(
          itemBuilder: (context, item, index) => ListTile(
            hoverColor: AppColor.gray,
            focusColor: AppColor.gray,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfile(
                    viewType: ViewType.viewMember,
                    memberUserName: item.name,
                    memberFullName: item.displayname,
                  ),
                ),
              );
            },
            leading: PrimaryCircleImage(
              imageUrl: item.avatar ?? '',
              placeholder: SvgPicture.asset(
                Assets.icPerson,
                color: AppColor.neutral5,
              ),
            ),
            title: Text(item.displayname.toString()),
            subtitle: Text('@${item.name}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () async {
                    Utils.launchUri(
                      item.phoneNumber ?? '',
                      UriType.phone,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      'assets/icons/ic_call.svg',
                    ),
                  ),
                ),
                PopupMenuButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      height: 32,
                      child: const Text('Xóa'),
                      onTap: () {
                        // getAlertDialog(
                        //   context: context,
                        //   title: "Xác nhận",
                        //   message:
                        //       "Bạn muốn xóa tài khoản này khỏi danh bạ",
                        //   onPositivePressed: bloc.add(
                        //     SavedContactsEventDelete(
                        //       savedContacts:
                        //           item,
                        //     ),
                        //   ) as void Function(),
                        // );
                        bloc.add(
                          SavedContactsEventDelete(
                            savedContacts: item,
                          ),
                        );
                      },
                    ),
                    PopupMenuItem(
                      height: 32,
                      child: const Text('Nhắn tin'),
                      onTap: () {
                        Utils.launchUri(
                          item.phoneNumber ?? '',
                          UriType.sms,
                        );
                      },
                    ),
                  ],
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        'assets/icons/ic_more_vert.svg',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          pagingController: bloc.savedContactPagingController,
          onRefresh: () {},
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
