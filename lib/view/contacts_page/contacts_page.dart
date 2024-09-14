import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/resources/colors.dart';
import '../../data/resources/themes.dart';
import '../../shared/widgets/loading.dart';
import 'bloc/contacts_page_bloc/contacts_page_bloc.dart';
import 'component/saved_contacts.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  ContactsPageBloc contactsPageBloc = ContactsPageBloc();

  PageController pageController = PageController(initialPage: 0);

  final List<Widget> _page = [
    const SavedContactScreen(),
    // const SuggestedContactsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => contactsPageBloc..add(ContactsPageInitEvent()),
      child: BlocBuilder<ContactsPageBloc, ContactsPageState>(
        builder: (context, state) {
          if (state is ContactsPageInitial) {
            return Scaffold(
              backgroundColor: AppColor.bgColor,
              body: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 15),
                    Container(
                      alignment: Alignment.center,
                      height: max(MediaQuery.of(context).size.height / 16, 50),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: AppColor.gray09,
                        ),
                        child: ListView.builder(
                          itemCount: 2,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: index == state.screenIndex
                                    ? AppColor.primaryColor
                                    : AppColor.gray09,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              width: max(
                                  MediaQuery.of(context).size.width / 5, 75),
                              height: max(
                                  MediaQuery.of(context).size.height / 20, 22),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    contactsPageBloc.add(
                                        ContactsPageChangePageEvent(index));
                                    pageController.animateToPage(
                                      index,
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.ease,
                                    );
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        index == 0
                                            ? 'assets/icons/ic_contact.svg'
                                            : 'assets/icons/ic_suggest.svg',
                                        color: index == state.screenIndex
                                            ? AppColor.white
                                            : AppColor.black,
                                      ),
                                      const SizedBox(width: 3),
                                      Text(
                                        index == 0 ? 'Đã lưu' : 'Gợi ý',
                                        style: index == state.screenIndex
                                            ? AppTextTheme.textPrimaryWhite
                                            : AppTextTheme.textPrimary,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: pageController,
                        children: _page,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Loading();
          }
        },
      ),
    );
  }
}
