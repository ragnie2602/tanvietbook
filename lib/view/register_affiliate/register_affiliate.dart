import 'package:flutter/material.dart';
import '../../config/config.dart';

class RegisterAffiliate extends StatefulWidget {
  const RegisterAffiliate({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterAffiliateState();
}

class _RegisterAffiliateState extends State<RegisterAffiliate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(
          'Đăng kí Cộng Tác Viên',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            letterSpacing: 1.1,
          ),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: textColor,
          ),
        ),
        backgroundColor: bgColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              decoration: const BoxDecoration(
                  border: Border(
                top: BorderSide(),
                bottom: BorderSide(),
                left: BorderSide(),
                right: BorderSide(),
              )),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Thông tin cá nhân',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    createTextFormField(
                        prefixIcon: const Icon(
                          Icons.person,
                          color: primaryColor,
                        ),
                        hintText: 'Username'),
                    createTextFormField(
                        prefixIcon: const Icon(
                          Icons.person,
                          color: primaryColor,
                        ),
                        hintText: 'Họ Và Tên'),
                    createTextFormField(
                        prefixIcon: const Icon(
                          Icons.cake,
                          color: primaryColor,
                        ),
                        hintText: 'Ngày Sinh',
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.calendar_today_outlined,
                              color: primaryColor,
                            ))),
                    createTextFormField(
                        prefixIcon: const Icon(
                          Icons.mail,
                          color: primaryColor,
                        ),
                        hintText: 'Email'),
                    createTextFormField(
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: primaryColor,
                        ),
                        hintText: 'Số Điện Thoại'),
                    createTextFormField(
                        prefixIcon: const Icon(
                          Icons.home,
                          color: primaryColor,
                        ),
                        hintText: 'Địa Chỉ Thường Trú'),
                    createTextFormField(
                        prefixIcon: const Icon(
                          Icons.home,
                          color: primaryColor,
                        ),
                        hintText: 'Địa Chỉ Liên Hệ'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget createTextFormField(
    {Widget? suffixIcon,
    Widget? prefixIcon,
    String? hintText,
    TextEditingController? controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none),
        fillColor: textBioStoreColor.withOpacity(0.1),
        filled: true,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
      ),
      controller: controller,
    ),
  );
}
