import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/repository/remote/agency_repository.dart';
import '../../../di/di.dart';
import '../../../domain/entity/cart/agency_cart_item_entity/agency_cart_item_entity.dart';
import '../../../model/api/base_response.dart';

part 'cart_cubit.freezed.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState.initial());
  final AgencyRepository _agencyRepository = getIt.get();

  late final List<AgencyCartItemEntity> selectedItems = [];
  late final List<AgencyCartItemEntity> cartItems = [];

  getAllCartItems({bool force = false}) async {
    if (!force && cartItems.isNotEmpty) {
      emit(CartState.getAllCartItemsSuccess(cartItems));
      Future.delayed(const Duration(milliseconds: 200)).then(
          (value) => emit(CartState.changeCartItemListSize(cartItems.length)));

      return;
    }
    final response = await _agencyRepository.getAllCartItems();
    if (response.status == ResponseStatus.success) {
      cartItems.clear();
      selectedItems.clear();
      cartItems.addAll(response.data!);
      emit(CartState.getAllCartItemsSuccess(cartItems));
      emit(CartState.changeCartItemListSize(cartItems.length));
    } else {}
  }

  changeTotalPrice() {
    int total = 0;
    for (var element in selectedItems) {
      total += (element.product?.salePrice ?? 0) * (element.amount ?? 1);
    }
    emit(CartState.changeTotalPriceSuccess(total));
  }

  /// add and update
  addToCart(
      {String? cartItemId,
      String? productPropertyId,
      String? productPropertyName,
      required String productId,
      required int amount}) async {
    final response = await _agencyRepository.addToCart(
      cartItemId: cartItemId,
      productId: productId,
      amount: amount,
    );
    if (response.status == ResponseStatus.success) {
      bool hasExisted = false;
      for (var element in cartItems) {
        if (response.data!.id == element.id) {
          // if modify in cart_page
          if (cartItemId != null) {
            element.amount = amount;
            element.product?.propertyId = productPropertyId;
            element.product?.productPropertyName = productPropertyName;
          } else {
            element.amount = (element.amount ?? 0) + amount;
          }
          hasExisted = true;
        }
      }
      if (!hasExisted) {
        cartItems.add(response.data!);
      }
      emit(CartState.addToCartSuccess(response.data!));
      emit(CartState.changeCartItemListSize(cartItems.length));
    } else {
      emit(CartState.addToCartFailed());
    }
  }

  /// deleteFromLocal = true: delete when user order this id -> automatic delete this in cart
  deleteCartItem(
    String id, {
    bool deleteFromLocal = false,
    List<String>? productIds,
  }) async {
    if (deleteFromLocal) {
      cartItems.removeWhere((cartItem) {
        bool removeThisItem = false;
        productIds?.forEach((productId) {
          if (cartItem.product?.id == productId) {
            removeThisItem = true;
          }
          selectedItems.removeWhere(
              (selectedItem) => selectedItem.product?.id == productId);
        });
        return removeThisItem;
      });
      Future.delayed(const Duration(milliseconds: 200)).then((value) {
        emit(CartState.getAllCartItemsSuccess(cartItems));
        emit(CartState.changeCartItemListSize(cartItems.length));
      });
      return;
    }

    final response = await _agencyRepository.deleteCartItem(id);
    if (response.status == ResponseStatus.success) {
      emit(CartState.deleteCartItemSuccess(id));
      selectedItems.removeWhere((selectedItem) => selectedItem.id == id);
      Future.delayed(const Duration(milliseconds: 200)).then((value) {
        emit(CartState.getAllCartItemsSuccess(
            cartItems..removeWhere((element) => element.id == id)));
        emit(CartState.changeCartItemListSize(cartItems.length));
      });
    } else {
      emit(CartState.addToCartFailed());
    }
  }
}
