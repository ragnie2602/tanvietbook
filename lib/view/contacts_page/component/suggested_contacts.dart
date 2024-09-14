import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/constants.dart';
import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';
import '../../../shared/widgets/loading.dart';
import '../bloc/suggested_contact_bloc/suggested_contact_bloc.dart';
import '../../user_profile/user_profile.dart';

class SuggestedContactsScreen extends StatefulWidget {
  const SuggestedContactsScreen({Key? key}) : super(key: key);

  @override
  State<SuggestedContactsScreen> createState() =>
      _SuggestedContactsScreenState();
}

class _SuggestedContactsScreenState extends State<SuggestedContactsScreen>
    with AutomaticKeepAliveClientMixin {
  final SuggestedContactBloc suggestedContactBloc = SuggestedContactBloc();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) =>
          suggestedContactBloc..add(SuggestedContactInitEvent()),
      child: BlocBuilder<SuggestedContactBloc, SuggestedContactState>(
        builder: (context, state) {
          if (state is SuggestedContactInitial) {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                      color: AppColor.cyanBorderColor,
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    child: Text(
                      'Đang có ${state.suggestedContactsResponse.totalUserCount} người dùng hệ thống!',
                      style: AppTextTheme.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16, bottom: 20),
                  child: Text(
                    'Danh sách đề xuất (${state.suggestedContactsResponse.suggestedCount})',
                    style: AppTextTheme.textPrimaryBold,
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.suggestedContactsResponse.data?.length ?? 0,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfile(
                            viewType: ViewType.viewMember,
                            memberUserName: state.suggestedContactsResponse
                                    .data?[index].login ??
                                '',
                            memberFullName: state.suggestedContactsResponse
                                .data?[index].fullName,
                          ),
                        ),
                      );
                    },
                    hoverColor: AppColor.gray,
                    focusColor: AppColor.gray,
                    leading: SizedBox(
                      height: 44,
                      width: 44,
                      child: ClipOval(
                        child: Image.network(
                            '${state.suggestedContactsResponse.data?[index].avatar}',
                            fit: BoxFit.cover),
                      ),
                    ),
                    title: Text(
                      state.suggestedContactsResponse.data?[index].fullName ??
                          '',
                    ),
                    // subtitle: Text('@${listSavedContacts[index].name}'),
                    trailing: MaterialButton(
                      color: AppColor.primaryColor,
                      child: const Text(
                        'Lưu danh bạ',
                        style: AppTextTheme.textPrimaryWhite,
                      ),
                      onPressed: () {
                        suggestedContactBloc.add(SuggestedContactAddEvent(
                            memberId: state.suggestedContactsResponse
                                    .data?[index].id ??
                                '',
                            username: state
                                .suggestedContactsResponse.data?[index].login));
                      },
                    ),
                  ),
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 5);
                  },
                )
              ],
            );
          } else {
            return const Loading();
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
