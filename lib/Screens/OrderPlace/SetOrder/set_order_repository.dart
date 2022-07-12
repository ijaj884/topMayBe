import 'package:topmaybe/Screens/OrderPlace/SetOrder/set_order_model.dart';
import '../../../api_base/api_base_helper.dart';



class SetOderRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<SetOrderModel> setOrder(body) async{
    final response= await _apiBaseHelper.post("CusApi/Order/SetOrder", body);
    return SetOrderModel.fromJson(response);
  }
}
