// class PaymentRequest {
//   String amount;
//   String intent;

//   PaymentRequest(this.amount, this.intent);

//   PaymentRequest.fromJson(Map<String, dynamic> json) {
//     amount = json['amount'];
//     intent = json['intent'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['amount'] = this.amount;
//     data['intent'] = this.intent;
//     return data;
//   }
// }

import 'dart:convert';

// Pyment pymentFromJson(String str) => Pyment.fromJson(json.decode(str));

// String pymentToJson(Pyment data) => json.encode(data.toJson());

class PaymentRequest {
    PaymentRequest({
         this.amount,
         this.intent,
    });

  String amount;
  String intent;

    factory PaymentRequest.fromJson(Map<String, dynamic> json) => PaymentRequest(
        amount: json["amount"],
        intent: json["intent"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "intent": intent,
    };
}



