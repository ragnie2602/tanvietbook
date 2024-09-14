import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes.dart';
import '../../../data/resources/resources.dart';
import '../../../domain/entity/customer/customer.dart';
import '../../../domain/entity/user_address/user_address.dart';
import '../../../shared/widgets/button/primary_group_radio_button.dart';
import '../../../shared/widgets/container/primary_container.dart';
import '../../../shared/widgets/container_shimmer.dart';
import '../../../shared/widgets/image/primary_svg_picture.dart';
import '../../../shared/widgets/no_data.dart';
import '../../../shared/widgets/primary_shimmer.dart';
import '../../customer/cubit/customer_cubit.dart';
import '../cubit/agency_cubit.dart';
import 'user_address_item.dart';

class UserAddressBlock extends StatefulWidget {
  final Customer? customer;
  final Function(bool isOrderForCustomer) isOrderForCustomerChanged;
  const UserAddressBlock({super.key, this.customer, required this.isOrderForCustomerChanged});

  @override
  State<UserAddressBlock> createState() => _UserAddressBlockState();
}

class _UserAddressBlockState extends State<UserAddressBlock> {
  late bool isOrderForCustomer;
  final customerCubit = CustomerCubit();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isOrderForCustomer = widget.customer != null;

    customerCubit.checkRole();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => customerCubit,
      child: Container(
        color: Colors.white,
        child: BlocBuilder<CustomerCubit, CustomerState>(
          buildWhen: (previous, current) => current is CustomerCheckRoleSuccess || current is CustomerCheckRoleFailed,
          builder: (context, state) {
            final AgencyCubit cubit = context.read();

            if (!isOrderForCustomer) cubit.getAllAddressByUser();

            return state is CustomerCheckRoleSuccess && state.role > 0
                ? PrimaryGroupRadioButton(
                    key: const ValueKey("checksalesuccess"),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    items: [
                      PrimaryContainer(
                          padding: const EdgeInsets.only(top: 16),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            const Text('Đặt cho tôi', style: AppTextTheme.bodyRegular),
                            const SizedBox(height: 8),
                            if (!isOrderForCustomer)
                              BlocBuilder<AgencyCubit, AgencyState>(
                                  buildWhen: (previous, current) => current is ChangeUserAddressSuccess,
                                  builder: (context, state) {
                                    return state.maybeWhen(
                                        changeUserAddressSuccess: (selectedUserAddress) {
                                          if (selectedUserAddress == null) {
                                            return Row(children: [
                                              const Expanded(child: Center(child: NoData())),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(context, AppRoute.agencyUserAddressPage,
                                                        arguments:
                                                            AgencyUserAddressPageAgrs(agencyCubit: context.read()));
                                                  },
                                                  style: TextButton.styleFrom(
                                                      padding: EdgeInsets.zero,
                                                      minimumSize: const Size(30, 30),
                                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                      alignment: Alignment.centerLeft),
                                                  child: const Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text('Thiết lập '),
                                                        Icon(Icons.arrow_forward_ios, size: 12)
                                                      ]))
                                            ]);
                                          }

                                          return UserAddressItem(userAddress: selectedUserAddress);
                                        },
                                        orElse: () => const SizedBox(
                                            width: double.infinity,
                                            child: PrimaryShimmer(child: ContainerShimmer(width: 100))));
                                  })
                          ])),
                      PrimaryContainer(
                          padding: const EdgeInsets.only(top: 16),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            const Text('Đặt cho khách hàng', style: AppTextTheme.bodyRegular),
                            const SizedBox(height: 12),
                            if (isOrderForCustomer)
                              widget.customer == null
                                  ? _CustomerOrderWidget(onCustomerSelected: (customer) {
                                      context.read<AgencyCubit>().changeCurrentReceiverAddress(customer);
                                    })
                                  : Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('${widget.customer!.fullname}  |  ${widget.customer!.mobile}',
                                            style: AppTextTheme.bodyStrong),
                                        const SizedBox(height: 4),
                                        if (widget.customer!.email != null) Text('${widget.customer!.email}'),
                                        Text(
                                            '${widget.customer!.address}, ${widget.customer!.commune}, ${widget.customer!.district}, ${widget.customer!.province}')
                                      ],
                                    ),
                            const SizedBox(height: 8)
                          ]))
                    ],
                    initialValue: [!isOrderForCustomer, isOrderForCustomer],
                    onChanged: (result) {
                      widget.isOrderForCustomerChanged.call(result[1]);
                      if (result[0]) {
                        context.read<AgencyCubit>().getAllAddressByUser();
                      }
                      setState(() {
                        isOrderForCustomer = result[1];
                      });
                    },
                  )
                : PrimaryGroupRadioButton(
                    key: const ValueKey("checksalefailed"),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    items: [
                      PrimaryContainer(
                          padding: const EdgeInsets.only(top: 16),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            const Text('Đặt cho tôi', style: AppTextTheme.bodyRegular),
                            const SizedBox(height: 8),
                            if (!isOrderForCustomer)
                              BlocBuilder<AgencyCubit, AgencyState>(
                                  buildWhen: (previous, current) => current is ChangeUserAddressSuccess,
                                  builder: (context, state) {
                                    return state.maybeWhen(
                                        changeUserAddressSuccess: (selectedUserAddress) {
                                          if (selectedUserAddress == null) {
                                            return Row(children: [
                                              const Expanded(child: Center(child: NoData())),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                      context,
                                                      AppRoute.agencyUserAddressPage,
                                                      arguments: AgencyUserAddressPageAgrs(agencyCubit: context.read()),
                                                    );
                                                  },
                                                  style: TextButton.styleFrom(
                                                      padding: EdgeInsets.zero,
                                                      minimumSize: const Size(30, 30),
                                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                      alignment: Alignment.centerLeft),
                                                  child: const Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text('Thiết lập '),
                                                        Icon(Icons.arrow_forward_ios, size: 12)
                                                      ]))
                                            ]);
                                          }

                                          return UserAddressItem(userAddress: selectedUserAddress);
                                        },
                                        orElse: () => const SizedBox(
                                            width: double.infinity,
                                            child: PrimaryShimmer(child: ContainerShimmer(width: 100))));
                                  })
                          ]))
                    ],
                    initialValue: const [true],
                    onChanged: (result) {
                      if (result[0]) {
                        context.read<AgencyCubit>().getAllAddressByUser();
                      }
                    });
          },
        ),
      ),
    );
  }
}

class _CustomerOrderWidget extends StatefulWidget {
  final Function(Customer customer) onCustomerSelected;
  const _CustomerOrderWidget({required this.onCustomerSelected});

  @override
  State<_CustomerOrderWidget> createState() => _CustomerOrderWidgetState();
}

class _CustomerOrderWidgetState extends State<_CustomerOrderWidget> {
  Customer? customer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return customer == null
        ? TextButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.customerChoosePage,
                  arguments: CustomerPageArgs(
                      isGetCustomerByCurrentRoute: true,
                      onCustomerSelected: (customer) {
                        widget.onCustomerSelected.call(customer);
                        setState(() {
                          this.customer = customer;
                        });
                      }));
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const PrimarySvgPicture(
                Assets.iconAddCircle,
                color: AppColor.primaryColor,
              ),
              const SizedBox(width: 4),
              Text(
                'Thêm thông tin khách hàng',
                style: AppTextTheme.bodyRegular.copyWith(color: AppColor.primaryColor),
              )
            ]))
        : UserAddressItem(
            userAddress: UserAddress(
              name: customer?.fullname,
              address: customer?.address,
              commune: customer?.commune,
              district: customer?.district,
              province: customer?.province,
              phoneNumber: customer?.mobile,
              email: customer?.email,
            ),
            onSettingPressed: () {
              Navigator.pushNamed(context, AppRoute.customerChoosePage,
                  arguments: CustomerPageArgs(
                      isGetCustomerByCurrentRoute: true,
                      onCustomerSelected: (customer) {
                        widget.onCustomerSelected.call(customer);
                        setState(() {
                          this.customer = customer;
                        });
                      }));
            });
  }
}
