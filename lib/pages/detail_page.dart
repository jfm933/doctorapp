import 'package:doctorapp/controller/rating_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPage extends StatelessWidget {
  String name;
  String image;
  int index;
  String specialist;
  String hospitalName;
  DetailPage(
      {super.key,
      required this.name,
      this.index = 0,
      this.image = "",
      this.specialist = "",
      this.hospitalName = ""});

  final NameAndOpenController nameAndOpenController =
      Get.put(NameAndOpenController());

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    double widthRatio = MediaQuery.sizeOf(context).width / 375;
    double heightRatio = MediaQuery.sizeOf(context).height / 812;
    return Scaffold(
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  width: 375 * widthRatio,
                  height: 375 * heightRatio,
                  decoration: BoxDecoration(color: Color(0xFFE9E9E9)),
                  child: Image.asset("assets/images/$image",
                      fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 56,
                    left: 30,
                    right: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          nameAndOpenController.changeFavorite(index);
                        },
                        child: Obx(() => Icon(
                              nameAndOpenController.isFavorite[index]
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: Colors.black,
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            buildName(widthRatio),
            SizedBox(
              height: 8,
            ),
            buildSpecialist(widthRatio, heightRatio),
            SizedBox(
              height: 16,
            ),
            buildDescription(widthRatio),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                width: 281 * widthRatio,
                //
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildExpPatRat(widthRatio, "Experience", "3", "yr"),
                    Image.asset("assets/images/Vector 3.png"),
                    buildExpPatRat(widthRatio, "Patients", "1.000", "ps"),
                    Image.asset("assets/images/Vector 3.png"),
                    buildExpPatRat(widthRatio, "Rating", "4.9", ""),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildMakeAnAppointmentAndCommment(widthRatio, heightRatio),
          ],
        ),
      ),
    );
  }

  Padding buildName(double widthRatio) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
      ),
      child: Container(
        child: Text(
          "dr. ${name ?? "Belum membuat nama"}",
          style: TextStyle(
            color: Color(0xFF25282B),
            fontSize: 24 * widthRatio,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Padding buildSpecialist(double widthRatio, double heightRatio) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Container(
        width: 197 * widthRatio,
        height: 21 * heightRatio,
        child: Row(
          children: [
            Text(
              '$specialist |',
              style: TextStyle(
                color: Color(0xFFAAAAAA),
                fontSize: 14 * widthRatio,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              '$hospitalName',
              style: TextStyle(
                color: Color(0xFFAAAAAA),
                fontSize: 14 * widthRatio,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildDescription(double widthRatio) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: 327 * widthRatio,
        child: Text(
          'dr. $name is one of the best doctors in the Persahabatan Hospital. He has saved more than 1000 patients in the past 3 years. He has also received many awards from domestic and abroad as the best doctors. He is available on a private or schedule. ',
          style: TextStyle(
            color: Color(0xFFC4C4C4),
            fontSize: 16 * widthRatio,
            fontFamily: 'Source Sans Pro',
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.visible,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  Padding buildMakeAnAppointmentAndCommment(
      double widthRatio, double heightRatio) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
      ),
      child: Row(
        children: [
          Container(
            width: 56 * widthRatio,
            height: 56 * heightRatio,
            decoration: ShapeDecoration(
              color: Color(0xFF4485FD),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.comment,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Container(
            width: 255 * widthRatio,
            height: 56 * heightRatio,
            decoration: ShapeDecoration(
              color: Color(0xFF00CC6A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Center(
              child: Text(
                'Make an Appointment',
                style: TextStyle(
                  color: Color(0xFFF9F9FA),
                  fontSize: 14,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildExpPatRat(
      double widthRatio, String title, String number, String unit) {
    return Container(
      width: 90 * widthRatio,
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF25282B),
              fontSize: 16 * widthRatio,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                number,
                style: TextStyle(
                  color: Color(0xFF2B92E4),
                  fontSize: 24 * widthRatio,
                  fontFamily: 'Source Sans Pro',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                unit,
                style: TextStyle(
                  color: Color(0xFFAAAAAA),
                  fontSize: 14 * widthRatio,
                  fontFamily: 'Source Sans Pro',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
