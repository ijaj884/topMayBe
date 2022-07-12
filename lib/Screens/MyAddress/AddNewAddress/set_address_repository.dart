
import 'package:topmaybe/Screens/MyAddress/AddNewAddress/set_address_model.dart';
import '../../../api_base/api_base_helper.dart';

class SetAddressRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<SetAddressModel> setAddress(body) async{
    // Map body={};
    final response= await _apiBaseHelper.post("CusApi/Customer/SetCustomerAddress", body);
    return SetAddressModel.fromJson(response);
  }
}