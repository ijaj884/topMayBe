

import 'package:topmaybe/Screens/CartPage/SetCart/setcart_model.dart';

import '../../../api_base/api_base_helper.dart';


class SetCartRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<SetCartModel> setCart(body) async{
    // Map body={};
    final response= await _apiBaseHelper.post("CusApi/ItemSku/SetCart", body);
    return SetCartModel.fromJson(response);
  }
}