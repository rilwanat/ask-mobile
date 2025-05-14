import 'dart:convert';

PlansData plansDataFromJson(String str) => PlansData.fromJson(json.decode(str));
String plansDataToJson(PlansData data) => json.encode(data.toJson());
class PlansData {
  PlansData({
      num? id, 
      String? name, 
      String? planCode, 
      String? description, 
      num? amount, 
      String? interval, 
      bool? sendInvoices, 
      bool? sendSms, 
      String? currency, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _planCode = planCode;
    _description = description;
    _amount = amount;
    _interval = interval;
    _sendInvoices = sendInvoices;
    _sendSms = sendSms;
    _currency = currency;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  PlansData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _planCode = json['plan_code'];
    _description = json['description'];
    _amount = json['amount'];
    _interval = json['interval'];
    _sendInvoices = json['send_invoices'];
    _sendSms = json['send_sms'];
    _currency = json['currency'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  num? _id;
  String? _name;
  String? _planCode;
  String? _description;
  num? _amount;
  String? _interval;
  bool? _sendInvoices;
  bool? _sendSms;
  String? _currency;
  String? _createdAt;
  String? _updatedAt;
PlansData copyWith({  num? id,
  String? name,
  String? planCode,
  String? description,
  num? amount,
  String? interval,
  bool? sendInvoices,
  bool? sendSms,
  String? currency,
  String? createdAt,
  String? updatedAt,
}) => PlansData(  id: id ?? _id,
  name: name ?? _name,
  planCode: planCode ?? _planCode,
  description: description ?? _description,
  amount: amount ?? _amount,
  interval: interval ?? _interval,
  sendInvoices: sendInvoices ?? _sendInvoices,
  sendSms: sendSms ?? _sendSms,
  currency: currency ?? _currency,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get name => _name;
  String? get planCode => _planCode;
  String? get description => _description;
  num? get amount => _amount;
  String? get interval => _interval;
  bool? get sendInvoices => _sendInvoices;
  bool? get sendSms => _sendSms;
  String? get currency => _currency;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['plan_code'] = _planCode;
    map['description'] = _description;
    map['amount'] = _amount;
    map['interval'] = _interval;
    map['send_invoices'] = _sendInvoices;
    map['send_sms'] = _sendSms;
    map['currency'] = _currency;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}