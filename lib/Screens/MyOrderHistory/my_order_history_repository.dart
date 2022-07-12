import '../../../api_base/api_base_helper.dart';
import 'my_order_history_model.dart';



class MyOrderHistoryRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<MyOrderHistoryModel> getOrderHistory(String userId) async{
     Map body={};
    //final response= await _apiBaseHelper.post("api/Order/GetListForCustomer/$userId", body);
     final response= await _apiBaseHelper.post("api/Order/GetListForCustomer/1", body);
    return MyOrderHistoryModel.fromJson(response);
  }
}