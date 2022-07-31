import '../../../api_base/api_base_helper.dart';
import 'get_suggested_for_you_model.dart';


class GetSuggestedForYouRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<GetSuggestedForYouModel> getSuggestedForYou(String userId) async{
    Map body={};
    final response= await _apiBaseHelper.post("CusApi/ItemSku/GetSuggestedForYou/$userId", body);
    return GetSuggestedForYouModel.fromJson(response);
  }
}