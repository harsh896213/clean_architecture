import 'package:flutter/material.dart';
import 'package:pva/feature/home/domain/entity/activity_entity.dart';

// class ActivityModel extends Activity {
//   ActivityModel({
//     required super.id,
//     required super.title,
//     required super.description,
//     required super.isCompleted,
//     required super.time,
//     required super.type,
//     required super.icon,
//     required super.color,
//   });
//
//   factory ActivityModel.fromJson(Map<String, dynamic> json) {
//     return ActivityModel(
//       id: UniqueKey().toString(),
//       title: json['title'] ?? '',
//       description: json['subtitle'] ?? '',
//       isCompleted: false,
//       time: '${DateTime.now().hour}:${DateTime.now().minute}',
//       type: json['type'] ?? '',
//       icon: json['icon'] ?? '',
//       color: json['color'] ?? '',
//     );
//   }
// }