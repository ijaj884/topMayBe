import '../../../api_base/api_base_helper.dart';
import 'get_support_ticket_priority_model.dart';



class GetSupportTicketPriorityRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<GetSupportTicketPriorityModel> getSupportTicketPriority() async{
    Map body={};
    final response= await _apiBaseHelper.post("SupportTicketPriority/Get", body);
    return GetSupportTicketPriorityModel.fromJson(response);
  }
}