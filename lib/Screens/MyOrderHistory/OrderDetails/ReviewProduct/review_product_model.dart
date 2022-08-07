///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class ReviewProductModel {
/*
{
  "Code": 1,
  "Message": "Success!!!",
  "Data": null
}
*/

  int? Code;
  String? Message;
  String? Data;

  ReviewProductModel({
    this.Code,
    this.Message,
    this.Data,
  });
  ReviewProductModel.fromJson(Map<String, dynamic> json) {
    Code = json['Code']?.toInt();
    Message = json['Message']?.toString();
    Data = json['Data']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Code'] = Code;
    data['Message'] = Message;
    data['Data'] = Data;
    return data;
  }
}