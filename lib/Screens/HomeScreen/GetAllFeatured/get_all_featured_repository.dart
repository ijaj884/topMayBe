import '../../../api_base/api_base_helper.dart';
import 'get_all_featured_model.dart';

class GetAllFeaturedRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<GetAllFeaturedModel> getAllFeatured(String userId) async{
    Map body={};
    final response= await _apiBaseHelper.post("api/ItemSku/GetAllFeatured", body);
    return GetAllFeaturedModel.fromJson(response);
  }
}