import 'package:get/get.dart';

class RatingController extends GetxController {
  var ratings = [3.0, 4.0, 5.0, 2.0, 4.0, 5.0].obs;
}

class NameAndOpenController extends GetxController {
  var names = [
    "Gilang Segara Joko",
    "Ani widodo",
    "Susi Santoso",
    "Siti Nurhaliza",
    "Rizky Febian",
    "Rizky Aulia",
  ].obs;
  var isOpen = [
    true,
    false,
    true,
    false,
    false,
    false,
  ].obs;

  var images = [
    "doctor-1.png",
    "doctor-2.png",
    "doctor-2.png",
    "doctor-2.png",
    "doctor-1.png",
    "doctor-2.png",
  ].obs;

  var specialities = [
    "Consultation",
    "Dental",
    "Surgeon",
    "Medicines",
    "Physician",
    "Hearth",
    "Hospital",
    "Skin",
  ].obs;

  var hospitalName = [
    "Puri Indah Hospital",
    "Pondok Indah Hospital",
    "Brawijaya Hospital",
    "Mitra Keluarga Hospital",
    "Pondok Indah Hospital",
    "Brawijaya Hospital",
  ].obs;

  var userCount = ["(1221)", "(964)", "(762)", "(723)", "(521)", "(964)"].obs;
  var isFavorite = [false, false, false, false, false].obs;

  void changeFavorite(int index) {
    isFavorite[index] = !isFavorite[index];
  }
}
