
import 'package:pva/feature/home/data/model/activity_model.dart';
import 'package:pva/feature/home/domain/entity/activity_entity.dart';
import 'package:pva/feature/home/domain/entity/home_page_entity.dart';

enum ActivityType { task, physical, medication, survey, appointment }

enum AppointmentType { virtual, inPerson }

// class HomeDataModel extends HomePageEntity {
//   HomeDataModel({
//     required List<Activity> allActivities,
//     required String tipsOfDay,
//   }) : super(allActivities: allActivities, tipsOfDay: tipsOfDay);
//
//   factory HomeDataModel.fromJson(Map<String, dynamic> json) {
//     List<ActivityModel> allActivities = [];
//
//     void addActivities(List<dynamic> items) {
//       allActivities.addAll(
//         items.map((item) => ActivityModel.fromJson(item)).toList(),
//       );
//     }
//
//     addActivities(json['tasks'] ?? []);
//     addActivities(json['physical'] ?? []);
//     addActivities(json['medication'] ?? []);
//     addActivities(json['surveys'] ?? []);
//     addActivities(json['appointments'] ?? []);
//
//     return HomeDataModel(
//       allActivities: allActivities,
//       tipsOfDay: "Stay positive every day counts toward better positive",
//     );
//   }
// }

class HomeDataModel{

}