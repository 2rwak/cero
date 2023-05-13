import 'package:cloud_firestore/cloud_firestore.dart';

class notification {
  static notifyGuestShared(
      String Currentusername, String fileName, String GuestUserName) async {
    DateTime now = DateTime.now();
    var Time =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}";

    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(GuestUserName)
        .collection('alerts')
        .doc('${Currentusername}_${Time}')
        .set({
      'title': 'New activity',
      'msg': "${Currentusername} shared a file with you",
      'flag': Currentusername
    });
  }

  static notifyOwnerAccept(
      String Currentusername, String fileName, String OwnerUserName) async {
    DateTime now = DateTime.now();
    var Time =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}";

    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(OwnerUserName)
        .collection('alerts')
        .doc('${Currentusername}_${Time}')
        .set({
      'title': 'New activity',
      'msg': "${Currentusername} Accepeted your invitation",
      'flag': Currentusername
    });
  }

  static notifyOwnertReject(
      String Currentusername, String fileName, String OwnerUserName) async {
    DateTime now = DateTime.now();
    var Time =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}";

    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(OwnerUserName)
        .collection('alerts')
        .doc('${Currentusername}_${Time}')
        .set({
      'title': 'New activity',
      'msg': "${Currentusername} Rejected your invitation",
      'flag': Currentusername
    });
  }
}
