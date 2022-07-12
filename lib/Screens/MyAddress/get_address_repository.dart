import '../../../api_base/api_base_helper.dart';
import 'get_address_model.dart';



class GetAddressRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<GetAddressModel> getAddress(body,String userId) async{
    // Map body={};
    final response= await _apiBaseHelper.post("CusApi/Customer/GetCustomerAddress/$userId", body);
    return GetAddressModel.fromJson(response);
  }
}