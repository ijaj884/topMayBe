

import '../../../api_base/api_base_helper.dart';
import 'FavoriteAddModel.dart';

class FavoriteAddRepository {

  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<FavoriteAddModel> favoriteadd(Map body) async {
    final response = await _helper.post('CusApi/ItemSku/SetWishList',body);
    return FavoriteAddModel.fromJson(response);
  }


}