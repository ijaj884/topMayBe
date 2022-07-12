
import '../../../api_base/api_base_helper.dart';
import 'get_wish_list_model.dart.dart';


class WishListRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<GetWishListModel> getWishList(String userId) async{
    Map body={};
    final response= await _apiBaseHelper.post("CusApi/ItemSku/GetWishList/$userId", body);
    return GetWishListModel.fromJson(response);
  }
}