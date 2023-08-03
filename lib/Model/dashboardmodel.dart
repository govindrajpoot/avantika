// To parse this JSON data, do
//
//     final dashboard = dashboardFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Dashboard dashboardFromJson(String str) => Dashboard.fromJson(json.decode(str));

String dashboardToJson(Dashboard data) => json.encode(data.toJson());

class Dashboard {
  final bool status;
  final String message;
  final Data data;

  Dashboard({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  final List<dynamic> gallery;
  final String notification;
  final int projects;
  final int manpower;
  final int rotarian;
  final int others;
  final int totalCost;
  final int totalBeneficiaries;
  final int totalMembers;
  final int yearsOfService;
  final int clubsCount;
  final int donation;
  final int hoursInService;

  Data({
    required this.gallery,
    required this.notification,
    required this.projects,
    required this.manpower,
    required this.rotarian,
    required this.others,
    required this.totalCost,
    required this.totalBeneficiaries,
    required this.totalMembers,
    required this.yearsOfService,
    required this.clubsCount,
    required this.donation,
    required this.hoursInService,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    gallery: List<dynamic>.from(json["gallery"].map((x) => x)),
    notification: json["notification"],
    projects: json["projects"],
    manpower: json["manpower"],
    rotarian: json["rotarian"],
    others: json["others"],
    totalCost: json["total_cost"],
    totalBeneficiaries: json["total_beneficiaries"],
    totalMembers: json["total_members"],
    yearsOfService: json["years_of_service"],
    clubsCount: json["clubs_count"],
    donation: json["donation"],
    hoursInService: json["hours_in_service"],
  );

  Map<String, dynamic> toJson() => {
    "gallery": List<dynamic>.from(gallery.map((x) => x)),
    "notification": notification,
    "projects": projects,
    "manpower": manpower,
    "rotarian": rotarian,
    "others": others,
    "total_cost": totalCost,
    "total_beneficiaries": totalBeneficiaries,
    "total_members": totalMembers,
    "years_of_service": yearsOfService,
    "clubs_count": clubsCount,
    "donation": donation,
    "hours_in_service": hoursInService,
  };
}
