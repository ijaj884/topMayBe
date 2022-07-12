
import '../../../api_base/api_base_helper.dart';
import 'get_under_price_model.dart';

class GetUnderPriceRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<GetUnderPriceModel> getUnderPrice(body) async{
    // Map body={};
    final response= await _apiBaseHelper.post("CusApi/ItemSku/GetHomePageConfiguration", body);
    return GetUnderPriceModel.fromJson(response);
  }

}