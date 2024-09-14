import '../../domain/entity/cart/agency_cart_item_entity/agency_cart_item_entity.dart';
import '../../domain/entity/cart/agency_cart_item_entity/agency_cart_product_entity.dart';
import '../../model/agency/cart/agency_cart_item_response.dart';
import 'base_data_mapper.dart';

class AgencyCartDatalMapper
    extends BaseDataMapper<AgencyCartItemResponse, AgencyCartItemEntity> {
  @override
  AgencyCartItemEntity mapToEntity(AgencyCartItemResponse? data) {
    return AgencyCartItemEntity(
      id: data?.id,
      userId: data?.userId,
      amount: data?.amount,
      createdDate: data?.createdDate,
      product: AgencyCartProductEntity(
        id: data?.product?.id,
        name: data?.product?.name,
        productPropertyImage: data?.product?.productPropertyImage,
        productPropertyName: data?.product?.productPropertyName,
        price: (data?.product?.price ?? 0).toInt(),
        salePrice: (data?.product?.salePrice ?? 0).toInt(),
        images: data?.product?.images,
        propertyId: data?.product?.propertyId,
        hidden: data?.product?.hidden,
        height: data?.product?.height,
        length: data?.product?.length,
        width: data?.product?.width,
        weight: data?.product?.weight,
      ),
      totalHeight: (data?.product?.height ?? 0) * (data?.amount ?? 0),
      totalWidth: data?.product?.width ?? 0,
      totalLength: data?.product?.length ?? 0,
      totalWeight: (data?.product?.weight ?? 0) * (data?.amount ?? 0),
    );
  }
}
