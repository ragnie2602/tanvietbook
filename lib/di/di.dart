import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/mapper/agency_cart_data_mapper.dart';
import '../data/mapper/agency_data_mapper.dart';
import '../data/mapper/appointment_data_mapper.dart';
import '../data/mapper/checkin_data_mapper.dart';
import '../data/mapper/customer_data_mapper.dart';
import '../data/mapper/route_data_mapper.dart';
import '../data/repository/interceptor/interceptor.dart';
import '../data/repository/local/local_data_access.dart';
import '../data/repository/local/shared_pref_helper.dart';
import '../data/repository/remote/agency_repository.dart';
import '../data/repository/remote/agency_repository_impl.dart';
import '../data/repository/remote/appointment_repository.dart';
import '../data/repository/remote/appointment_repository_impl.dart';
import '../data/repository/remote/landing_page_repository.dart';
import '../data/repository/remote/landing_page_repository_impl.dart';
import '../data/repository/remote/repository.dart';
import '../services/api_service.dart';
import '../services/notification/notification_contract.dart';
import '../services/notification/signalr_notification_helper.dart';
import '../view/affiliate/cubit/affiliate_cubit.dart';
import '../view/agency_page/cubit/agency_cubit.dart';
import '../view/agency_page/cubit/cart_cubit.dart';
import '../view/ano_card/cubit/ano_card_cubit.dart';
import '../view/appointment/cubit/appointment_cubit.dart';
import '../view/base/bloc/common/common_cubit.dart';
import '../view/customer/cubit/customer_cubit.dart';

final getIt = GetIt.instance;

configureInjection() async {
  getIt.registerFactory(() => Dio());
  getIt.registerLazySingleton<Api>(() => Api(getIt<Dio>()));

  final sharedPref = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<LocalDataAccess>(
      () => SharePrefHelper(sharedPref: sharedPref));

  getIt.registerFactory<AgencyRepository>(() => AgencyRepositoryImpl());

  getIt.registerFactory<UserRepository>(() => UserRepositoryImpl(
      dio: getIt.get<Dio>(), localDataAccess: getIt.get<LocalDataAccess>()));
  getIt.registerFactory<CategoryRepository>(
      () => CategoryRepositoryImpl(dio: getIt<Dio>()));
  getIt.registerFactory<ConcernRepository>(
      () => ConcernRepositoryImpl(dio: getIt<Dio>()));
  getIt.registerFactory<AppRepository>(
    // instanceName: 'original',
    () => AppRepositoryImpl(
      dio: getIt<Dio>(),
      openIdRepository: getIt.get<OpenIDRepository>(),
      appInterceptor: getIt.get<AppInterceptor>(),
      localDataAccess: getIt.get<LocalDataAccess>(),
    ),
  );
  getIt.registerFactory<AppointmentRepository>(
      () => AppointmentRepositoryImpl());

  getIt.registerFactory<PhonebookRepository>(() => PhonebookRepositoryImpl(
      dio: getIt<Dio>(), openIdRepository: getIt.get<OpenIDRepository>()));
  getIt.registerFactory<UtilityRepository>(
      () => UtilitiesRepositoryImpl(dio: getIt<Dio>()));

  getIt.registerFactory<OpenIDRepository>(
      () => OpenIDRepositoryImpl(dio: getIt<Dio>()));

  getIt.registerFactory<StorageRepository>(() => StorageRepositoryImpl(
      dio: getIt<Dio>(), localDataAccess: getIt.get<LocalDataAccess>()));

  getIt.registerFactory<LandingPageRepository>(
      () => LandingPageRepositoryImpl(dio: getIt<Dio>()));

  getIt.registerFactory<NotificationRepository>(
      () => NotificationRepositoryImpl());
  // interceptor
  getIt.registerLazySingleton<AppInterceptor>(() => AppInterceptor());

  // notification
  getIt.registerLazySingleton<NotificationServiceContract>(
      () => SignalRNotificationHelper());

  // mapper
  getIt.registerFactory<AgencyDetailMapper>(() => AgencyDetailMapper());
  getIt.registerFactory<AgencyProductDataMapper>(
      () => AgencyProductDataMapper());
  getIt.registerFactory<AgencyOrderDataMapper>(() => AgencyOrderDataMapper());
  getIt.registerFactory<AgencyCartDatalMapper>(() => AgencyCartDatalMapper());
  getIt.registerFactory<AppointmentDataMapper>(() => AppointmentDataMapper());
  getIt.registerFactory<CalendarEventDataMapper>(
      () => CalendarEventDataMapper());
  getIt.registerFactory<CheckinDetailDataMapper>(
      () => CheckinDetailDataMapper());
  getIt.registerFactory<AgencyVoucherValidateDataMapper>(
      () => AgencyVoucherValidateDataMapper());
  getIt.registerFactory<CustomerDataMapper>(() => CustomerDataMapper());
  getIt.registerFactory<PurposeDataMapper>(() => PurposeDataMapper());
  getIt.registerFactory<RouteDataMapper>(() => RouteDataMapper());
  getIt.registerFactory<EventDataMapper>(() => EventDataMapper());

  // cubit
  getIt.registerFactory<CommonCubit>(() => CommonCubit());
  getIt.registerFactory<AnoCardCubit>(() => AnoCardCubit());
  getIt.registerFactory<AgencyCubit>(() => AgencyCubit());
  getIt.registerLazySingleton<AppointmentCubit>(() => AppointmentCubit());
  getIt.registerFactory<CartCubit>(() => CartCubit());
  getIt.registerFactory<AffiliateCubit>(() => AffiliateCubit());
  getIt.registerFactory(() => CustomerCubit());
  getIt.registerLazySingleton(() => CustomerCubit(), instanceName: 'singleton');
}
