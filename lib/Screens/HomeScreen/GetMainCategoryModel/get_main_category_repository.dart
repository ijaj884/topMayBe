

import '../../../api_base/api_base_helper.dart';
import 'get_main_category_model.dart';

class GetMainCategoryRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<GetMainCategoryModel> getMainCategory(body) async{
    // Map body={};
    final response= await _apiBaseHelper.post("api/Category/GetAllActiveMain", body);
    return GetMainCategoryModel.fromJson(response);
  }

}