
///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class GetListForCustomerSupportTicketModelData {
/*
{
  "stkth_id": 1,
  "stkth_cus_id": 0,
  "stkth_seller_id": 0,
  "stkth_spriority_id": 0,
  "stkth_sttyp_id": 0,
  "stkth_ssts_id": 0,
  "stkth_subject": "support subject",
  "stkth_message": "<p class=\"card-text\">support message quick example text to build on the card title and make up the bulk of the card's content.</p>\r\n                    <p>\r\n                        Lorem ipsum dolor sit amet, quis Neque porro quisquam est, nostrud exercitation ullamco laboris commodo consequat. There’s an old maxim that states, “No fun for the writer, no fun for the reader.”No matter what industry\r\n                        you’re working in, as a blogger, you should live and die by this statement.\r\n                    </p>\r\n                    <p>\r\n                        I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the\r\n                        truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure.\r\n                    </p>",
  "stkth_attachment": "http://rohan4-001-site1.ftempurl.com/Documents/attachmenturl",
  "stkth_created_date": "2022-06-25T10:29:36.483",
  "stkth_status_changed_by": 0,
  "stkth_status_changed_date": null,
  "spriority_name": "Urgent",
  "sttyp_Name": "Billing Issue",
  "ssts_name": "Open",
  "ticket_by": null,
  "ticket_from": null,
  "creator_mobile": null,
  "creator_email": null,
  "supportTicketDetails": null
}
*/

  int? stkthId;
  int? stkthCusId;
  int? stkthSellerId;
  int? stkthSpriorityId;
  int? stkthSttypId;
  int? stkthSstsId;
  String? stkthSubject;
  String? stkthMessage;
  String? stkthAttachment;
  String? stkthCreatedDate;
  int? stkthStatusChangedBy;
  String? stkthStatusChangedDate;
  String? spriorityName;
  String? sttypName;
  String? sstsName;
  String? ticketBy;
  String? ticketFrom;
  String? creatorMobile;
  String? creatorEmail;
  String? supportTicketDetails;

  GetListForCustomerSupportTicketModelData({
    this.stkthId,
    this.stkthCusId,
    this.stkthSellerId,
    this.stkthSpriorityId,
    this.stkthSttypId,
    this.stkthSstsId,
    this.stkthSubject,
    this.stkthMessage,
    this.stkthAttachment,
    this.stkthCreatedDate,
    this.stkthStatusChangedBy,
    this.stkthStatusChangedDate,
    this.spriorityName,
    this.sttypName,
    this.sstsName,
    this.ticketBy,
    this.ticketFrom,
    this.creatorMobile,
    this.creatorEmail,
    this.supportTicketDetails,
  });
  GetListForCustomerSupportTicketModelData.fromJson(Map<String, dynamic> json) {
    stkthId = json['stkth_id']?.toInt();
    stkthCusId = json['stkth_cus_id']?.toInt();
    stkthSellerId = json['stkth_seller_id']?.toInt();
    stkthSpriorityId = json['stkth_spriority_id']?.toInt();
    stkthSttypId = json['stkth_sttyp_id']?.toInt();
    stkthSstsId = json['stkth_ssts_id']?.toInt();
    stkthSubject = json['stkth_subject']?.toString();
    stkthMessage = json['stkth_message']?.toString();
    stkthAttachment = json['stkth_attachment']?.toString();
    stkthCreatedDate = json['stkth_created_date']?.toString();
    stkthStatusChangedBy = json['stkth_status_changed_by']?.toInt();
    stkthStatusChangedDate = json['stkth_status_changed_date']?.toString();
    spriorityName = json['spriority_name']?.toString();
    sttypName = json['sttyp_Name']?.toString();
    sstsName = json['ssts_name']?.toString();
    ticketBy = json['ticket_by']?.toString();
    ticketFrom = json['ticket_from']?.toString();
    creatorMobile = json['creator_mobile']?.toString();
    creatorEmail = json['creator_email']?.toString();
    supportTicketDetails = json['supportTicketDetails']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['stkth_id'] = stkthId;
    data['stkth_cus_id'] = stkthCusId;
    data['stkth_seller_id'] = stkthSellerId;
    data['stkth_spriority_id'] = stkthSpriorityId;
    data['stkth_sttyp_id'] = stkthSttypId;
    data['stkth_ssts_id'] = stkthSstsId;
    data['stkth_subject'] = stkthSubject;
    data['stkth_message'] = stkthMessage;
    data['stkth_attachment'] = stkthAttachment;
    data['stkth_created_date'] = stkthCreatedDate;
    data['stkth_status_changed_by'] = stkthStatusChangedBy;
    data['stkth_status_changed_date'] = stkthStatusChangedDate;
    data['spriority_name'] = spriorityName;
    data['sttyp_Name'] = sttypName;
    data['ssts_name'] = sstsName;
    data['ticket_by'] = ticketBy;
    data['ticket_from'] = ticketFrom;
    data['creator_mobile'] = creatorMobile;
    data['creator_email'] = creatorEmail;
    data['supportTicketDetails'] = supportTicketDetails;
    return data;
  }
}

class GetListForCustomerSupportTicketModel {
/*
{
  "Code": 1,
  "Message": null,
  "Data": [
    {
      "stkth_id": 1,
      "stkth_cus_id": 0,
      "stkth_seller_id": 0,
      "stkth_spriority_id": 0,
      "stkth_sttyp_id": 0,
      "stkth_ssts_id": 0,
      "stkth_subject": "support subject",
      "stkth_message": "<p class=\"card-text\">support message quick example text to build on the card title and make up the bulk of the card's content.</p>\r\n                    <p>\r\n                        Lorem ipsum dolor sit amet, quis Neque porro quisquam est, nostrud exercitation ullamco laboris commodo consequat. There’s an old maxim that states, “No fun for the writer, no fun for the reader.”No matter what industry\r\n                        you’re working in, as a blogger, you should live and die by this statement.\r\n                    </p>\r\n                    <p>\r\n                        I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the\r\n                        truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure.\r\n                    </p>",
      "stkth_attachment": "http://rohan4-001-site1.ftempurl.com/Documents/attachmenturl",
      "stkth_created_date": "2022-06-25T10:29:36.483",
      "stkth_status_changed_by": 0,
      "stkth_status_changed_date": null,
      "spriority_name": "Urgent",
      "sttyp_Name": "Billing Issue",
      "ssts_name": "Open",
      "ticket_by": null,
      "ticket_from": null,
      "creator_mobile": null,
      "creator_email": null,
      "supportTicketDetails": null
    }
  ]
}
*/

  int? Code;
  String? Message;
  List<GetListForCustomerSupportTicketModelData?>? Data;

  GetListForCustomerSupportTicketModel({
    this.Code,
    this.Message,
    this.Data,
  });
  GetListForCustomerSupportTicketModel.fromJson(Map<String, dynamic> json) {
    Code = json['Code']?.toInt();
    Message = json['Message']?.toString();
    if (json['Data'] != null) {
      final v = json['Data'];
      final arr0 = <GetListForCustomerSupportTicketModelData>[];
      v.forEach((v) {
        arr0.add(GetListForCustomerSupportTicketModelData.fromJson(v));
      });
      Data = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Code'] = Code;
    data['Message'] = Message;
    if (Data != null) {
      final v = Data;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['Data'] = arr0;
    }
    return data;
  }
}
