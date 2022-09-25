// To parse this JSON data, do
//
//     final totalModelData = totalModelDataFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

TotalModelData totalModelDataFromJson(String str) =>
    TotalModelData.fromJson(json.decode(str));

String totalModelDataToJson(TotalModelData data) => json.encode(data.toJson());

class TotalModelData {
  TotalModelData({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
  });

  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<ClientDetails>? data;

  factory TotalModelData.fromJson(Map<String, dynamic> json) => TotalModelData(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: List<ClientDetails>.from(
            json["data"].map((x) => ClientDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ClientDetails extends Equatable {
  ClientDetails({
    this.id,
    this.name,
    this.img,
    this.until,
    this.amount,
    this.outOfAmount,
  });

  String? id;
  String? name;
  String? img;
  String? until;
  String? amount;
  String? outOfAmount;
  @override
  List<Object?> get props => [id, name, img, until, amount, outOfAmount];

  factory ClientDetails.fromJson(Map<String, dynamic> json) => ClientDetails(
        id: json["id"],
        name: json["Name"],
        img: json["Img"],
        until: json["Until"],
        amount: json["Amount"],
        outOfAmount: json["OutOfAmount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Name": name,
        "Img": img,
        "Until": until,
        "Amount": amount,
        "OutOfAmount": outOfAmount,
      };
}
