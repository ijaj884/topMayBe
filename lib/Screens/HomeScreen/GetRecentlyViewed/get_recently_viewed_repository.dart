import '../../../api_base/api_base_helper.dart';
import 'get_recently_viewed.dart';

class GetRecentlyViewedRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<GetRecentlyViewedModel> getRecentlyViewed(String userId) async{
    Map body={};
    final response= await _apiBaseHelper.post("CusApi/ItemSku/GetRecentlyViewed/$userId", body);
    return GetRecentlyViewedModel.fromJson(response);
  }
}