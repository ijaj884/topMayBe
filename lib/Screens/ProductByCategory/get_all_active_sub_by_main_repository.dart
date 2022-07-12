

import '../../../api_base/api_base_helper.dart';
import 'get_all_active_sub_by_main_model.dart';


class GetAllActiveSubByMainRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<GetAllActiveSubByMainModel> getSubCategory(body,String catId) async{
    // Map body={};
    final response= await _apiBaseHelper.post("api/Category/GetAllActiveSubByMain/$catId", body);
    return GetAllActiveSubByMainModel.fromJson(response);
  }
}