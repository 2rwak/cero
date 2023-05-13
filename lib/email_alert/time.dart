// Arwa
class time {
  String time_now = '';
  void getTime() async {
    DateTime now = DateTime.now();

    time_now =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}";
    print("time " + time_now);
  }
}
