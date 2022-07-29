

import '../../../api_base/api_base_helper.dart';
import 'get_banner2_model.dart';
import 'get_bannerfor_home_page_model.dart';

class GetBannerforHomePageRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<GetBannerforHomePageModel> getBanner(body) async{
    // Map body={};
    final response= await _apiBaseHelper.post("CusApi/Banner/GetBannerForHomePage/1", body);
    return GetBannerforHomePageModel.fromJson(response);
  }
  Future<GetBanner2Model> getBanner2(body) async{
    // Map body={};
    final response= await _apiBaseHelper.post("CusApi/Banner/GetBannerForHomePage/2", body);
    return GetBanner2Model.fromJson(response);
  }
  Future<GetBannerforHomePageModel> getBanner3(body) async{
    // Map body={};
    final response= await _apiBaseHelper.post("CusApi/Banner/GetBannerForHomePage/3", body);
    return GetBannerforHomePageModel.fromJson(response);
  }
  Future<GetBannerforHomePageModel> getBanner4(body) async{
    // Map body={};
    final response= await _apiBaseHelper.post("CusApi/Banner/GetBannerForHomePage/4", body);
    return GetBannerforHomePageModel.fromJson(response);
  }

}