import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../data/resources/colors.dart';

const Color primaryColor = Color.fromARGB(255, 14, 175, 143);
const Color secondaryColor = Color.fromARGB(255, 249, 23, 23);
const Color labelColor = primaryColor; //Color.fromARGB(255, 14, 175, 143);
const Color bgColor = Color.fromARGB(255, 255, 255, 255);
const Color titleColor = Color.fromARGB(255, 0, 0, 0);
const Color iconColor = Colors.black;
const Color iconProfileColor = secondaryColor;
const Color textColor = Color.fromARGB(255, 0, 0, 0);
const Color textBioStoreColor = Color.fromARGB(255, 113, 118, 123);
const Color bgItemColor = Color.fromARGB(255, 245, 245, 245);
const Color divColor = Color.fromARGB(255, 85, 84, 98);
const Color borColor = Colors.black;
const Color borStoreColor = Color.fromARGB(255, 72, 69, 107);
const Color bgCardColor = primaryColor; //Color.fromARGB(255, 21, 207, 170);
const Color btIcColor = Color.fromARGB(255, 25, 75, 255);
const Color iconCheckColor = Color.fromARGB(255, 40, 167, 69);
const Color iconWarningColor = Color.fromARGB(255, 255, 193, 7);
const Color iconErrorColor = Color.fromARGB(255, 220, 53, 69);

createPrimaryButton(BuildContext context, Function function, String label) => SizedBox(
    width: MediaQuery.of(context).size.width - 20,
    height: 48,
    child: ElevatedButton(
      onPressed: () {
        function();
      },
      style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
      child: Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
    ));

const TextStyle titleStyle =
    TextStyle(fontWeight: FontWeight.w700, fontFamily: "Quicksand", fontSize: 20, color: Colors.black);
const matchParent = double.infinity;

class Environment {
  final AppFlavor flavor;

  Environment({this.flavor = AppFlavor.dev});
  String get fileName => (kDebugMode && flavor == AppFlavor.dev)
      ? 'app_config_test.env'
      : (kDebugMode && flavor == AppFlavor.prod)
          ? 'app_config_product.env'
          : (kReleaseMode && flavor == AppFlavor.prod)
              ? 'app_config_product.env'
              : (kReleaseMode && flavor == AppFlavor.dev)
                  ? 'app_config_test.env'
                  : '';

  static String domain = dotenv.env['DOMAIN'] ?? '';
  static String webMiniDomain = dotenv.env['WEB_MINI_DOMAIN'] ?? '';
  static String profileDomain = dotenv.env['PROFILE_DOMAIN'] ?? '';
  static String resourcesBaseUrl = dotenv.env['BASE_RESOURCE_URL'] ?? '';
  static String agencyBaseUrl = dotenv.env['BASE_AGENCY_URL'] ?? '';
  static String notificationServiceBaseUrl = dotenv.env['NOTIFICATION_SERVICE_BASE_URL'] ?? '';
  static String cdnBaseUrl = dotenv.env['CDN_BASE_URL'] ?? '';
}

enum AppFlavor {
  dev,
  staging,
  prod,
}

class EndPoints {
  static const String publicAddressBaseUrl = "https://provinces.open-api.vn/api/p";

  // sso related
  static const String getUserInfoSSO = '/user/updateinfo';
  static const String deactiveUser = '/users/de-active';
  static const String getCurrentMemberSettingInfo = '/users/info';

  // user related
  static const String login = '/connect/login';
  static const String getAccountInfo = '/api/account';
  static const String changePassword = '/api/account/change-password';

  // member
  static const String updateMemberBaseInfo = '/gateway/member/member-base';
  static const String getMemberOwnInfo = '/gateway/member/view-own';
  static const String getMemberInfoByUsername = '/gateway/member/view';
  static const String updateMemberInfo = '/gateway/member/update';
  static const String getContactDefaultTypeInfo = '/gateway/member/contact/defaultValueList';
  static const String getContactInfo = '/gateway/member/contact/view';
  static const String getContactInfoViewOwn = '/gateway/member/contact/view-own';
  static const String swapDisplayPosition = '/gateway/member/member-base/swap';
  static const String swapAdditionalPathPosition = '/gateway/member/additional-path/swap';
  static const String swapContactPosition = '/gateway/member/contact/swap';
  static const String addContactInfo = '/gateway/member/contact/add';
  static const String deleteContactInfo = '/gateway/member/contact/delete';
  static const String getOrganizationInfo = '/gateway/member/organization/view';
  static const String getOrganizationInfoViewOwn = '/gateway/member/organization/view-own';
  static const String addOrganizationInfoViewOwn = '/gateway/member/organization/add';
  static const String getAdditionalPathInfo = '/gateway/member/additional-path/view';
  static const String getAdditionalPathInfoViewOwn = '/gateway/member/additional-path/view-own';
  static const String addAdditionalPathInfo = '/gateway/member/additional-path/add';
  static const String deleteAdditionalPathInfo = '/gateway/member/additional-path/delete';
  static const String getQrCode = '/QR';

  static const String getCollabInfo = '/user/GetCurrentInfo';
  static const String getCollabTree = '/user/GetCurrentTree';
  static const String checkCollaborator = '/user/GetCheck';
  static const String getMemberBasicInfo = '/api/getInformation';
  static const String getBusinessTab = '/gateway/business-tab/list-all';
  static const String getSubTab = '/gateway/sub-tab/list-all';
  static const String getGroupProductList = '/gateway/Product/groupProductList';
  static const String swapPositionGroupProductList = '/gateway/Product/groupProductSwap';
  static const String getProductList = '/gateway/Product/productList';
  static const String getProductViewDetail = '/gateway/Product/productViewDetail';

  // storage
  static String uploadImage = "/gateway/Media/Upload";

  // phonebook related
  static String addPhonebook = "/gateway/Phonebook/add";
  static String updatePhonebook = "/gateway/Phonebook/update";
  static String deletePhonebook = "/gateway/Phonebook/delete";
  static String viewPhonebook = "/gateway/Phonebook/view";
  static String searchPhonebook = "/gateway/Phonebook/search";
  static String suggestPhonebook = "/gateway/Phonebook/suggest";

  // business related
  static String getBusinessInfoViewOwn = '/gateway/website/own/';
  static String getBusinessOverall = '/gateway/website/over-view';
  static String getAllBusiness = '/gateway/website/list-all';
  static String createBusiness = '/gateway/website/create';
  static String getAllBusinessSubTab = '/gateway/sub-tab/list-all';
  static String createBusinessCategory = '/gateway/category/create';
  static String updateBusinessCategory = '/gateway/category/update';
  static String getAllBusinessCategory = '/gateway/category/list';
  static String getAllBusinessCategoryByType = '/gateway/category/list-by-type';
  static String updateBusinessDetail = '/gateway/website/update';
  static String updateBusinessProduct = '/gateway/post/update';
  static String createBusinessProduct = '/gateway/post/create';
  static String swapBusinessProduct = '/gateway/post/swap';
  static String deleteBusinessProduct = '/gateway/post';
  static String getAllBusinessProduct = '/gateway/post/list-all';
  static String getBusinessProductDetail = '/gateway/post';

  //category related
  static String createCategory = "/gateway/category/create";
  static String swapCategory = "/gateway/category/swap";
  static String getListCategory = "/gateway/category/list";
  static String getCategory = "/gateway/category";
  static String getCategoryByType = "/gateway/category/list-by-type";
  static String deleteCategory = "/gateway/category";
  static String searchCategory = "/gateway/category/search";
  static String getUninitializedList = "/gateway/category/list-uninitialized";

  //landing page related
  static String createLandingPage = "/gateway/landingpage/create";
  static String deleteLandingPage = "/gateway/landingpage";
  static String swapLandingPage = "/gateway/landingpage/swap-item";
  static String getLandingPage = "/gateway/landingpage/get-all";
  static String addContent = "/gateway/content/add";
  static String deleteContent = "/gateway/content";
  static String getContent = "/gateway/content";
  static String addConnective = "/gateway/connective/add";
  static String deleteConnective = "/gateway/connective";
  static String getConnective = "/gateway/connective/get-list";
  static String addAction = "/gateway/action/add";
  static String deleteAction = "/gateway/action";
  static String getAction = "/gateway/action";
  static String addImage = "/gateway/image/add";
  static String addImageList = "/gateway/image/add-list";
  static String deleteImage = "/gateway/image";
  static String getImageList = "/gateway/image/get-list";
  static String addButton = "/gateway/button/add";
  static String deleteButton = "/gateway/button";
  static String getButtons = "/gateway/buttons";

  // concern related
  static String createConcern = "/gateway/concern/create";
  static String concernGetAll = "/gateway/concern/get-all";

  //affiliate
  static String getCollaboratorInfo = "/gateway/collaborators/own/requests";
  static String checkCollaboratorExist = "/gateway/collaborators/check";
  static String regsiterCollaborator = "/gateway/collaborators/requests/create";
  static String getComissionInfo = "/gateway/commissions/tree";
  static String getComissionHistory = "/gateway/commission/search";

  // ano card
  static String activeAnoCard = "/gateway/ano-cards/activate";

  // notification
  static String registerFCMToken = "/registerToken";
  static String getAllNotifications = "/gateway/delivery/notification/search";
  static String getAllNotificationCategories = "/gateway/delivery/notificationtype/search";

  // agency
  static String getAgencyDetail = '/gateway/agency/detail';
  static String getAllAgencyProduct = '/gateway/agency/products';
  static String getProductDetail = '/gateway/agency/product';
  static String getAllAddressByUser = '/gateway/agency/addressUser/get-all-by-userId';
  static String addUserAddress = '/gateway/agency/addressUser';
  static String addOrder = '/gateway/agency/order/create';
  static String updateOrder = '/gateway/agency/order/update-status';
  static String getAgencyOrderDetail = '/gateway/agency/order';
  static String getAllAgencyOrders = '/gateway/agency/orders';
  static String getAllCategories = '/gateway/agency/category/view-all';
  static String getAllCartItems = '/gateway/agency/carts/';
  static String viewUser = '/gateway/agency/view/';

  // sale staff
  static String checkRole = '/gateway/user/check-role';
  static String checkSaleStaff = '/gateway/sale-staff/check';

  // route
  static String routes = '/gateway/routes';

  // customer
  static String addCustomer = '/gateway/sale/customer';
  static String editCustomer = '/gateway/customer';
  static String getAllPurpose = '/gateway/purpose/view-all';
  static String getCustomer = '/gateway/customer/';
  static String searchCustomerByRoute = '/gateway/sale/customer';

  // checkin
  static String checkin = '/gateway/checkin/checkin';
  static String checkinDetail = '/gateway/checkin/detail-checkin';
  static String checkout = '/gateway/checkin/checkout';
  static String getJourneys = '/gateway/checkin/journey-sale';

  // upload
  static String upload = '/gateway/Media/Upload';

  // appointment
  static String addApppointment = '/gateway/appointment/create';
  static String calendarDayEvent = '/gateway/appointment/calendar-a-day';
  static String calendarEvent = '/gateway/appointment/calendar';
  static String editAppointment = '/gateway/appointment/update';
}

class SSOConfig {
  static String fileName = kDebugMode ? 'app_config_test.env' : 'app_config_product.env';

  static String issuer = dotenv.env['SSO_ISSUER'] ?? '';
  static String clientId = dotenv.env['SSO_CLIENT_ID'] ?? '';
  static String clientSecret = dotenv.env['SSO_CLIENT_SECRET'] ?? '';
  static String ssoApiUrl = dotenv.env['SSO_API_URL'] ?? '';
  static const String redirectUrl = "com.eztek.trueconnect://login-callback";
  static const String postLogoutRedirectUrl = "com.eztek.trueconnect://signout-callback-oidc";

  static const List<String> scope = ["openid", "profile", "email", "roles", "offline_access"];

  static String register = '$issuer/Account/Register';
}

class AppConfig {
  static const String appName = "Tân Việt Book";
  static const String agencyName = 'tanvietbook';
  static const String agencySenderAddress = 'Trương Định, Hai Bà Trưng, Hà Nội';
  static const String fontFamily = "Quicksand";
  static const Color primaryColor = AppColor.primaryColor;
  static const MaterialColor primarySwatch = AppColor.primarySwatch;
}
