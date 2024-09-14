import '../../../model/business/product/product_detail_response.dart';
import '../../../model/business/product/product_get_all_response.dart';
import '../../../model/business/sub_tab/business_sub_tab_response.dart';
import '../../../model/member/base_info_response.dart';

import '../../../model/api/base_response.dart';
import '../../../model/business/business_get_all_response/business_get_all_response.dart';
import '../../../model/business/detail/business_detail_response.dart';
import '../../../model/business/overall/business_overall_response.dart';
import '../../../model/member/additional_path_response.dart';
import '../../../model/member/contact_default_type_response.dart';
import '../../../model/member/contact_member_info.dart';
import '../../../model/member/member_detail_info.dart';
import '../../../model/member/organization_info_response.dart';

abstract class AppRepository {
  // base
  Future<ResponseWrapper<bool>> updateMemberBaseInfo(
      {required BaseInfoResponse baseInfo});

  Future<ResponseWrapper<bool>> swapDisplayPosition(List<String> data);

  // personal Info
  Future<ResponseWrapper<MemberInfo>> getMemberOwnInfo();

  Future<ResponseWrapper<MemberInfo>> getMemberInfoByUsername(
      {required String username});

  Future<ResponseWrapper<MemberInfo>> getMemberBaseInfoViewOwn();

  Future<ResponseWrapper<bool>> getQrCode({required String username});

  Future<ResponseWrapper<bool>> updateMemberInfo({MemberInfo? memberInfo});

  // contact
  Future<ResponseWrapper<List<ContactDefaultTypeResponse>>>
      getMemberContactDefaultList({required bool isType, String? type});

  Future<ResponseWrapper<List<ContactInfoResponse>>>
      getMemberContactInfoViewOwn({required String contactBaseId});

  Future<ResponseWrapper<List<ContactInfoResponse>>> getMemberContactInfo(
      {required String contactBaseId});

  Future<ResponseWrapper<bool>> addMemberContactInfo(
      {required ContactInfoResponse contactInfoResponse});

  Future<ResponseWrapper<bool>> deleteMemberContactInfo(
      {required String contactId, required String contactBaseId});

  Future<ResponseWrapper<bool>> swapContactPosition(List<String> data);

  // organization
  Future<ResponseWrapper<OrganizationInfoResponse>> getMemberOrganizationInfo(
      {required String organizationBaseId});

  Future<ResponseWrapper<OrganizationInfoResponse>>
      getMemberOrganizationInfoViewOwn({required String organizationBaseId});

  Future<ResponseWrapper<bool>> updateMemberOrganization(
      {required OrganizationInfoResponse organizationInfo});

  // additional Path
  Future<ResponseWrapper<List<AdditionalPathInfoResponse>>>
      getMemberAdditionalPathInfo({required String additionalPathBaseId});

  Future<ResponseWrapper<List<AdditionalPathInfoResponse>>>
      getMemberAdditionalPathInfoViewOwn(
          {required String additionalPathBaseId});

  Future<ResponseWrapper<bool>> addMemberAdditionalPathInfoViewOwn(
      {required AdditionalPathInfoResponse additionalPathInfoResponse});

  Future<ResponseWrapper<bool>> deleteMemberAdditionalPathInfoViewOwn(
      {required String pathId, required String basePathId});

  Future<ResponseWrapper<bool>> swapAdditionalPathPosition(List<String> data);

  // web mini
  Future<ResponseWrapper<BusinessOverallResponse>> getBusinessOverall(
      {required String bid});

  Future<ResponseWrapper<List<BusinessGetAllResponse>>> getAllBusiness(
      {String? username});

  Future<ResponseWrapper<List<BusinessSubTabResponse>>> getBusinessSubTab(
      {required String bid, String? username});

  Future<ResponseWrapper<BusinessDetailResponse>> getBusinessDetail(
      {required String bid});

  Future<ResponseWrapper<BusinessDetailResponse>> updateBusinessDetail(
      {required BusinessDetailUpdateRequest businessDetailUpdateRequest});

  Future<ResponseWrapper<ProductGetAllResponse>> getAllBusinessProduct(
      {String? subTabId,
      String? categoryId,
      String? keyword,
      required int pageNum,
      required int pageSize,
      String? username});

  Future<ResponseWrapper<ProductDetailResponse>> getBusinessProductDetail(
      {String? postId, String? username});

  Future<ResponseWrapper<ProductDetailResponse>> updateBusinessProduct(
      {required ProductDetailResponse productDetailResponse});

  Future<ResponseWrapper<ProductDetailResponse>> createBusinessProduct(
      {required ProductDetailResponse productDetailResponse});

  Future<ResponseWrapper<bool>> deleteBusinessProduct({required String pid});

  Future<ResponseWrapper<bool>> changeBusinessProductPosition(
      {required List<String> pidList, String? categoryId});

  // anocard
  Future<ResponseWrapper<bool>> activeAnoCard({
    required String cardId,
    required String key,
  });
}
