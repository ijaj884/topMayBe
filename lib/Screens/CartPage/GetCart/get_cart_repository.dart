import '../../../api_base/api_base_helper.dart';
import 'get_cart_model.dart';



class GetCartRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<GetCartModel> getCart(body,String userId) async{
    // Map body={};
    final response= await _apiBaseHelper.post("CusApi/ItemSku/GetCart/$userId", body);
    return GetCartModel.fromJson(response);
  }
}