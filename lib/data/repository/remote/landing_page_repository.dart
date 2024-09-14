import '../../../model/business/landing_page/landing_page_response.dart';
import '../../../model/api/base_response.dart';
import '../../../model/business/landing_page/landing_page_button_response.dart';
import '../../../model/business/landing_page/landing_page_call_action_response.dart';
import '../../../model/business/landing_page/landing_page_content_response.dart';
import '../../../model/business/landing_page/landing_page_image_response.dart';
import '../../../model/business/landing_page/landing_page_link_response.dart';

abstract class LandingPageRepository {
  Future<ResponseWrapper<LandingPageResponse>> createLandingPageItem(
      Map<String, dynamic> data);
  Future<ResponseWrapper<bool>> deleteLandingPage(
      {required String landingPageId});
  Future<ResponseWrapper<bool>> swapItem(
      {required List<String> idList, required String cateId});
  Future<ResponseWrapper<List<LandingPageResponse>>> getAll(String cateId);
  Future<ResponseWrapper<LandingPageContentResponse>> addContent(
      {required String landingId, required String value, String? contentId});
  Future<ResponseWrapper<LandingPageContentResponse>> getContent(
      {required String landingId});
  Future<ResponseWrapper<LandingPageLinkResponse>> addLink(
      {required String landingId,
      required String value,
      required String title,
      String? linkId});
  Future<ResponseWrapper<LandingPageLinkResponse>> getLink(
      {required String landingId});
  Future<ResponseWrapper<LandingPageCallActionResponse>> addCallAction(
      {required Map<String, dynamic> data});
  Future<ResponseWrapper<LandingPageCallActionResponse>> getCallAction(
      {required String landingId});
  Future<ResponseWrapper<List<LandingPageImageResponse>>> addImage(
      {required String landingId, required List<String> value});
  Future<ResponseWrapper<List<LandingPageImageResponse>>> getImage(
      {required String landingId});
  Future<ResponseWrapper<LandingPageButtonResponse>> addButton(
      {required Map<String, dynamic> data});
  Future<ResponseWrapper<LandingPageButtonResponse>> getButton(
      {required String landingId});
}
