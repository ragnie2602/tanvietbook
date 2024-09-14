import '../../../model/api/base_response.dart';
import '../../constants.dart';

abstract class StorageRepository {
  Future<ResponseWrapper<String>> uploadImage(
      {required String imagePath, ImageType imageType = ImageType.none});

  Future<ResponseWrapper<List<String>>> uploadMultipleImage(
      {required List<String> imagePathList});
}
