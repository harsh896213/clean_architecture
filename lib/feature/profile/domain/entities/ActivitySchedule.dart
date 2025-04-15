class ActivitySchedule {
  final bool morning;
  final bool afternoon;
  final bool evening;
  final bool night;
  final String? morningTime;
  final String? afternoonTime;
  final String? eveningTime;
  final String? nightTime;

  ActivitySchedule({
    this.morning = false,
    this.afternoon = false,
    this.evening = false,
    this.night = false,
    this.morningTime,
    this.afternoonTime,
    this.eveningTime,
    this.nightTime,
  });
}
