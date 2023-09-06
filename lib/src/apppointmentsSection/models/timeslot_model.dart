class TimeSlot {
  final DateTime startTime;
  final DateTime endTime;
  bool isSelected;

  TimeSlot(
      {required this.startTime,
      required this.endTime,
      this.isSelected = false});
}
