import '../../../api_base/api_base_helper.dart';
import 'get_filtered_item_list_model.dart';



class GetFilteredItemListRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<GetFilteredItemListModel> getFilteredItem(body) async{
    // Map body={};
    final response= await _apiBaseHelper.post("CusApi/ItemSku/GetFilteredItemList", body);
    return GetFilteredItemListModel.fromJson(response);
  }
}