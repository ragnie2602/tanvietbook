import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/resources/resources.dart';
import '../../di/di.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/widgets/container/primary_container.dart';
import '../../shared/widgets/loading.dart';
import 'bloc/common/common_cubit.dart';

class BasePageState<T extends StatefulWidget, C extends Cubit>
    extends BasePageStateDelegate<T, C> {}

abstract class BasePageStateDelegate<T extends StatefulWidget, C extends Cubit>
    extends State<T> {
  final CommonCubit _commonCubit = CommonCubit();
  late C cubit;
  PreferredSizeWidget? _appBar;

  set setCubit(C c) => cubit = c;

  /// use safe area or not
  bool get useSafeArea => true;

  /// this state should use BlocProvider.value or BlocProvicer.create
  bool get useBlocProviderValue => false;

  /// this widget can use loading effect in the future
  bool get isUseLoading => false;

  EdgeInsets get padding => const EdgeInsets.symmetric(horizontal: 16);

  Color? get backgroundColor => AppColor.primaryBackgroundColor;

  PreferredSizeWidget? get appBar => _appBar;
  set setAppBar(PreferredSizeWidget ab) => _appBar = ab;

  void showLoading({bool dismissible = false}) {
    _commonCubit.showLoading(dismissible: dismissible);
  }

  void hideLoading() => _commonCubit.hideLoading();

  showToast(String message, {Widget? child}) {
    _commonCubit.showToast(message, child: child);
  }

  hideToast() {
    _commonCubit.hideToast();
  }

  @override
  void initState() {
    super.initState();
    if (!useBlocProviderValue) cubit = getIt.get<C>();
    // log('base page state: ${cubit.runtimeType} ${cubit.hashCode}');
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _commonCubit,
        ),
        // BlocProvider.value(
        //   value: userCubit,
        // ),
      ],
      child: isUseLoading
          ? Stack(
              children: [
                _baseScaffoldPage(),
                BlocBuilder<CommonCubit, CommonState>(
                  buildWhen: (previous, current) =>
                      current is CommonShowLoadingState,
                  builder: (context, state) {
                    if (state is CommonShowLoadingState) {
                      return Stack(
                        children: [
                          Visibility(
                            visible: state.isLoading,
                            child: ModalBarrier(
                              color: Colors.black.withOpacity(0.5),
                              dismissible: state.isdismissible,
                              barrierSemanticsDismissible: state.isdismissible,
                              onDismiss: () {
                                _commonCubit.hideLoading();
                              },
                            ),
                          ),
                          if (state.isLoading)
                            const Center(
                              child: Loading(),
                            )
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                BlocBuilder<CommonCubit, CommonState>(
                  buildWhen: (previous, current) =>
                      current is CommonToastMessage,
                  builder: (context, state) {
                    if (state is CommonToastMessage && state.isShow) {
                      return Positioned(
                          top: 56,
                          left: 16,
                          right: 16,
                          child: PrimaryContainer(
                            padding: const EdgeInsets.all(16),
                            width: context.screenWidth,
                            child: state.child ??
                                Text(
                                  state.message ?? '',
                                  style: AppTextTheme.bodyRegular,
                                ),
                          ));
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            )
          : _baseScaffoldPage(),
    );
  }

  Widget buildPage(BuildContext context) => const SizedBox();

  Widget _baseScaffoldPage() => Scaffold(
        backgroundColor: backgroundColor,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: _appBar ?? appBar,
        body: SafeArea(
          top: useSafeArea,
          bottom: useSafeArea,
          child: Padding(
            padding: padding,
            child: useBlocProviderValue
                ? BlocProvider.value(
                    value: cubit,
                    child: buildPage(context),
                  )
                : BlocProvider(
                    create: (context) => cubit,
                    child: buildPage(context),
                  ),
          ),
        ),
      );
}
