
import '../../../../api_base/api_base_helper.dart';
import 'FavDeleteModel.dart';

class FavoriteDeleteRepository {

  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<FavDeleteModel> favoritedelete(String id,String token) async {
    final response = await _helper.deleteWithHeader('wishlist/$id',"Bearer $token");
    return FavDeleteModel.fromJson(response);
  }


}