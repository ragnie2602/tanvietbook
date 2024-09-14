part of 'cart_cubit.dart';

@Freezed(equal: false)
class CartState with _$CartState {
  const factory CartState.initial() = _Initial;

  factory CartState.getAllCartItemsSuccess(List<AgencyCartItemEntity> items) =
      AllCartItemsSuccess;

  factory CartState.addToCartSuccess(
      AgencyCartItemEntity agencyCartItemEntity) = AddToCartSuccess;

  factory CartState.changeCartItemListSize(int size) = ChangeCartItemListSize;

  factory CartState.addToCartFailed() = AddToCartFailed;

  factory CartState.deleteCartItemSuccess(String cartItemId) =
      DeleteCartItemSuccess;
  factory CartState.deleteCartItemFailed() = DeleteCartItemFailed;

  factory CartState.changeTotalPriceSuccess(int total) =
      ChangeTotalPriceSuccess;
}
