import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../data/constants.dart';
import '../domain/entity/agency/agency_detail.dart';
import '../domain/entity/agency_category/agency_category.dart';
import '../domain/entity/appointment/appointment_entity.dart';
import '../domain/entity/appointment/event_entity.dart';
import '../domain/entity/cart/agency_cart_item_entity/agency_cart_item_entity.dart';
import '../domain/entity/customer/customer.dart';
import '../domain/entity/user_address/user_address.dart';
import '../model/business/category/business_category_response.dart';
import '../model/member/collaborator/collaborator_response.dart';
import '../model/route.dart';
import '../shared/bloc/sso/sso_cubit.dart';
import '../view/affiliate/affiliate_comission_history_list_page.dart';
import '../view/affiliate/affiliate_comission_history_page.dart';
import '../view/affiliate/affiliate_comission_info_page.dart';
import '../view/affiliate/affiliate_register_info_page.dart';
import '../view/affiliate/affiliate_register_page.dart';
import '../view/affiliate/cubit/affiliate_cubit.dart';
import '../view/agency_page/agency_add_address.dart';
import '../view/agency_page/agency_cart_page.dart';
import '../view/agency_page/agency_detail_page.dart';
import '../view/agency_page/agency_order_detail_page.dart';
import '../view/agency_page/agency_order_list_page.dart';
import '../view/agency_page/agency_order_product_page.dart';
import '../view/agency_page/agency_order_product_success_page.dart';
import '../view/agency_page/agency_product_detail_page.dart';
import '../view/agency_page/agency_user_address_page.dart';
import '../view/agency_page/cubit/agency_cubit.dart';
import '../view/ano_card/ano_card_activation_page.dart';
import '../view/appointment/appointment.dart';
import '../view/appointment/appointment_add.dart';
import '../view/appointment/appointment_detail.dart';
import '../view/business/bloc/business_bloc.dart';
import '../view/business/category_manage/bloc/category_manage_bloc/category_manage_bloc.dart';
import '../view/business/category_manage/category_detail/category_content_detail.dart';
import '../view/business/category_manage/category_manage.dart';
import '../view/business/category_manage/category_rearrange.dart';
import '../view/business/customer_interested/customer_interested.dart';
import '../view/business/detail/business_detail_page.dart';
import '../view/business/product/business_manage_product.dart';
import '../view/business/product/business_rearrange_product.dart';
import '../view/business/product/business_update_product.dart';
import '../view/business/product/business_view_product.dart';
import '../view/business/update_info/business_update_info.dart';
import '../view/customer/checkin.dart';
import '../view/customer/cubit/customer_cubit.dart';
import '../view/customer/customer_add_page.dart';
import '../view/customer/customer_all_products.dart';
import '../view/customer/customer_choose_page.dart';
import '../view/customer/journey_page.dart';
import '../view/edit_profile/component/update_highlight_info.dart';
import '../view/event_page/event_page.dart';
import '../view/home_page/home_screen.dart';
import '../view/login_screens/login_screen.dart';
import '../view/qrcode/scan_qrcode.dart';
import '../view/splash/splash_screen.dart';
import '../view/user_profile/bloc/user_info_bloc.dart';

class AppRoute {
  static const String splash = "/";
  static const String home = "/home";
  static const String login = "/login";
  static const String register = "/register";

  static const String userUpdateHighlight = "/userUpdateHighlight";

  static const String businessUpdateInfo = "/businessUpdateInfo";
  static const String businessCategory = "/businessCategory";
  static const String categoryRearrange = "/categoryRearrange";
  static const String categoryContentDetail = "/categoryContentDetail";
  static const String customerInterested = "/customerInterested";
  static const String businessProductManage = "/businessProductManage";
  static const String businessProductRearrange = "/businessProductRearrange";
  static const String businessUpdateProduct = "/businessUpdateProduct";
  static const String businessViewProduct = "/businessViewProduct";

  static const String businessDetail = "/businessDetail";
  static const String scannerPage = "/scannerPage";
  static const String anoCardActivate = "/anoCardActivate";

  static const String agencyProductDetailPage = "/agencyProductDetailPage";
  static const String agencyOrderProductPage = "/agencyOrderProductPage";
  static const String agencyOrderProductSuccessPage =
      "/agencyOrderProductSuccessPage";
  static const String agencyUserAddressPage = "/agencyUserAddressPage";
  static const String agencyAddUserAddress = "/agencyAddUserAddress";
  static const String agencyCartPage = "/agencyCartPage";
  static const String agencyOrderListPage = "/agencyOrderListPage";
  static const String agencyDetailPage = "/agencyDetailPage";
  static const String agencyGetOrderDetailPage = "/agencyGetOrderDetailPage";
  static const String affiliateRegisterPage = "/affiliateRegisterPage";
  static const String affiliateRegisterInfoPage = "/affiliateRegisterInfoPage";
  static const String affiliateComissionInfoPage =
      "/affiliateComissionInfoPage";
  static const String affiliateComissionHistoryPage =
      "/affiliateComissionHistoryPage";
  static const String affiliateComissionHistoryListPage =
      "/affiliateComissionHistoryListPage";

  // Customer
  static const String checkin = '/checkin';
  static const String customerAddPage = '/customerAddPage';
  static const String customerChoosePage = '/customerChoosePage';
  static const String customerChooseProduct = '/customerChooseProduct';
  static const String journeyPage = '/journeyPage';

  // Appointment
  static const String appointment = '/appointment';
  static const String appointment2 = '/appointment2';
  static const String appointmentAdd = '/appointmentAdd';
  static const String eventDetail = '/eventDetail';

  // events
  static const String eventList = '/eventList';

  static dynamic generateRoute() => {
        AppRoute.login: (context) => const LoginScreen(),
        AppRoute.home: (context) => const HomeScreen(),

        AppRoute.userUpdateHighlight: (context) =>
            const UserUpdateHighlightInfo(),

        // AppRoute.splash: (context) =>  const SplashScreen(),
        AppRoute.businessUpdateInfo: (context) => const BusinessUpdateInfo(),
        AppRoute.businessCategory: (context) => CategoryManage(),
        AppRoute.categoryRearrange: (context) => const CategoryRearrange(),
        AppRoute.categoryContentDetail: (context) =>
            const CategoryContentDetail(),
        AppRoute.businessDetail: (context) => const BusinessDetailPage(),
        AppRoute.customerInterested: (context) => const CustomerInterested(),
        AppRoute.businessProductManage: (context) =>
            const BusinessManageProductPage(),
        AppRoute.businessProductRearrange: (context) =>
            const BusinessProductRearrange(),
        AppRoute.businessUpdateProduct: (context) =>
            const BusinessUpdateProduct(),
        AppRoute.businessViewProduct: (context) => const BusinessViewProduct(),
        AppRoute.scannerPage: (context) => const CustomQrCode(),
        AppRoute.anoCardActivate: (context) => const AnoCardActivationPage(),
        AppRoute.agencyProductDetailPage: (context) =>
            const AgencyProductDetailPage(),
        AppRoute.agencyOrderProductPage: (context) =>
            const AgencyOrderProductPage(),
        AppRoute.agencyOrderProductSuccessPage: (context) =>
            const AgencyOrderProductSuccessPage(),
        AppRoute.agencyUserAddressPage: (context) =>
            const AgencyUserAddressPage(),
        AppRoute.agencyAddUserAddress: (context) =>
            const AgencyAddUserAddressPage(),
        AppRoute.agencyCartPage: (context) => const AgencyCartPage(),
        AppRoute.agencyOrderListPage: (context) => const AgencyOrderListPage(),
        AppRoute.agencyDetailPage: (context) => const AgencyDetailPage(),
        AppRoute.agencyGetOrderDetailPage: (context) =>
            const AgencyOrderDetailPage(),

        // affiliate
        AppRoute.affiliateRegisterPage: (context) =>
            const AffiliateRegisterPage(),
        AppRoute.affiliateRegisterInfoPage: (context) =>
            const AffiliateRegisterInfoPage(),
        AppRoute.affiliateComissionInfoPage: (context) =>
            const AffiliateComissionInfoPage(),
        AppRoute.affiliateComissionHistoryPage: (context) =>
            const AffiliateComissionHistoryPage(),
        AppRoute.affiliateComissionHistoryListPage: (context) =>
            const AffiliateComissionHistoryListPage(),

        // Customer
        AppRoute.checkin: (context) => const Checkin(),
        AppRoute.customerAddPage: (context) => const CustomerAddPage(),
        AppRoute.customerChoosePage: (context) => const CustomerChoosePage(),
        AppRoute.customerChooseProduct: (context) =>
            const CustomerAllProducts(),
        AppRoute.journeyPage: (context) => const JourneyPage(),

        // Appointment
        AppRoute.appointment: (context) => const Appointment(),
        AppRoute.appointment2: (context) => const Appointment2(),
        AppRoute.appointmentAdd: (context) => const AppointmentAdd(),
        AppRoute.eventDetail: (context) => const EventDetail(),

        // events
        AppRoute.eventList: (context) => const EventListPage()
      };

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name!) {
      case AppRoute.splash:
        return MaterialPageRoute(
            builder: (context) => const SplashScreen(), settings: settings);
      default:
        return null;
    }
  }
}

class SplashScreenArgs {
  final String appLinkUsernameReceived;

  SplashScreenArgs({required this.appLinkUsernameReceived});
}

class UserUpdateHighlightInfoArgs {
  final UserInfoBloc userInfoBloc;

  UserUpdateHighlightInfoArgs({required this.userInfoBloc});
}

class BusinessOverallArgs {
  final String id;

  BusinessOverallArgs({
    required this.id,
  });
}

class BusinessUpdateInfoArgs {
  final BusinessBloc businessBloc;
  final String defaultName;

  BusinessUpdateInfoArgs({
    required this.businessBloc,
    required this.defaultName,
  });
}

class BusinessDetailPageArgs {
  final BusinessBloc businessBloc;
  final ViewType viewType;

  BusinessDetailPageArgs({
    required this.businessBloc,
    required this.viewType,
  });
}

class BusinessProductManageArgs {
  final String? categoryId;
  final String? categoryName;
  final String subTabId;

  BusinessProductManageArgs({
    required this.subTabId,
    this.categoryId,
    this.categoryName,
  });
}

class BusinessProductRearrangeArgs {
  final BusinessBloc businessBloc;

  BusinessProductRearrangeArgs({required this.businessBloc});
}

class BusinessUpdateProductArgs {
  final bool isAddNew;
  final String? productId;
  final String subTabId;

  BusinessUpdateProductArgs({
    required this.isAddNew,
    required this.subTabId,
    this.productId,
  });
}

class BusinessViewProductArgs {
  final String productId;

  BusinessViewProductArgs({
    required this.productId,
  });
}

class CategoryManageArgs {
  final String subTabId;

  CategoryManageArgs({
    required this.subTabId,
  });
}

class CategoryContentDetailArgs {
  final String categoryId;
  final String subTabId;
  final LandingPageViewType type;

  CategoryContentDetailArgs({
    required this.categoryId,
    required this.subTabId,
    required this.type,
  });
}

class CategoryRearrangeArgs {
  final List<BusinessCategoryResponse> categoryList;
  final CategoryManageBloc categoryManageBloc;

  CategoryRearrangeArgs(
      {required this.categoryManageBloc, required this.categoryList});
}

class AnoCardActivationPageArgs {
  final String cardId;

  AnoCardActivationPageArgs({required this.cardId});
}

class AgencyProductDetailPageAgrs {
  final String productId;
  final AgencyCubit agencyCubit;

  AgencyProductDetailPageAgrs(
      {required this.agencyCubit, required this.productId});
}

class AgencyOrderListPageArgs {
  final List<String> orders;

  AgencyOrderListPageArgs({required this.orders});
}

class AgencyOderProductPageAgrs {
  final List<AgencyCartItemEntity>? cartItems;
  final Customer? customer;

  final AgencyCubit agencyCubit;

  AgencyOderProductPageAgrs(
      {required this.agencyCubit, required this.cartItems, this.customer});
}

class AgencyUserAddressPageAgrs {
  final UserAddress? currentUserAddress;
  final AgencyCubit agencyCubit;

  AgencyUserAddressPageAgrs({
    this.currentUserAddress,
    required this.agencyCubit,
  });
}

class AgencyAddUserAddressPageAgrs {
  final UserAddress? userAddress;
  final AgencyCubit agencyCubit;

  AgencyAddUserAddressPageAgrs({
    this.userAddress,
    required this.agencyCubit,
  });
}

class AgencyDetailPageAgrs {
  final AgencyCubit agencyCubit;
  final AgencyDetail agencyDetail;

  AgencyDetailPageAgrs({
    required this.agencyDetail,
    required this.agencyCubit,
  });
}

class AgencyGetAllProductPageAgrs {
  final AgencyCategory agencyCategory;

  AgencyGetAllProductPageAgrs({
    required this.agencyCategory,
  });
}

class AgencyGetOrderDetailPageAgrs {
  final AgencyCubit agencyCubit;
  final String orderId;

  AgencyGetOrderDetailPageAgrs({
    required this.agencyCubit,
    required this.orderId,
  });
}

class AffiliateRegisterPageArgs {
  final AffiliateCubit affiliateCubit;
  final SsoCubit ssoCubit;
  final AgencyCubit agencyCubit;
  final CollaboratorResponse? collaboratorResponse;

  AffiliateRegisterPageArgs({
    required this.affiliateCubit,
    required this.ssoCubit,
    required this.agencyCubit,
    this.collaboratorResponse,
  });
}

class AffiliateRegisterInfoPageArgs {
  final AffiliateCubit affiliateCubit;

  AffiliateRegisterInfoPageArgs({required this.affiliateCubit});
}

class AffiliateComissionInfoPageArgs {
  final AffiliateCubit affiliateCubit;

  AffiliateComissionInfoPageArgs({required this.affiliateCubit});
}

class AffiliateComissionHistoryPageArgs {
  final AffiliateCubit affiliateCubit;

  AffiliateComissionHistoryPageArgs({required this.affiliateCubit});
}

class AffiliateComissionHistoryListPageArgs {
  final AffiliateCubit affiliateCubit;

  AffiliateComissionHistoryListPageArgs({required this.affiliateCubit});
}

class CheckinPageArgs {
  final Customer customer;
  final bool isLimitedDistance;
  final Location location;
  final String? purpose;

  const CheckinPageArgs(this.customer, {this.isLimitedDistance = true, required this.location, this.purpose});
}

class CustomerPageArgs {
  final bool isGetCustomerByCurrentRoute;
  final Function(Customer customer)? onCustomerSelected;

  CustomerPageArgs(
      {this.isGetCustomerByCurrentRoute = false, this.onCustomerSelected});
}

class CustomerAddPageArgs {
  final CustomerCubit cubit;
  final Customer? customer;
  final List<RouteEntity> routes;
  final String? routeName;

  CustomerAddPageArgs(this.cubit, this.routes, {this.customer, this.routeName});
}

class CustomerAllProductsArgs {
  final Customer customer;

  CustomerAllProductsArgs(this.customer);
}

class PointLocationArgs {
  Position p;
  Function(String, String, String, Position) getAddr;

  PointLocationArgs(this.p, this.getAddr);
}

class AppointmentAddArgs {
  final AppointmentEntity? appointment;

  AppointmentAddArgs({this.appointment});
}

class AppointmentDetailArgs {
  final DateTime focusDate;

  const AppointmentDetailArgs(this.focusDate);
}

class EventDetailArgs {
  EventEntity event;

  EventDetailArgs(this.event);
}
