
import '../../../api_base/api_base_helper.dart';
import 'delete_address_model.dart';

class DeleteAddressRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<DeleteAddressModel> deleteAddress(String caddId) async{
     Map body={};
    final response= await _apiBaseHelper.post("CusApi/Customer/DeleteAddress/$caddId", body);
    return DeleteAddressModel.fromJson(response);
  }
}