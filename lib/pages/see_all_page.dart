import 'package:doctorapp/controller/rating_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import 'detail_page.dart';

class SeeAllPage extends StatelessWidget {
  SeeAllPage({
    super.key,
  });

  final RatingController ratingController = Get.find();
  final NameAndOpenController nameAndOpenController = Get.find();
  @override
  Widget build(BuildContext context) {
    double widthRatio = MediaQuery.sizeOf(context).width / 375;
    double heightRatio = MediaQuery.sizeOf(context).height / 812;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/Bung 1.png"),
          ),
          SizedBox(
            width: 25,
          )
        ],
      ),
      body: ListView(
        children: List.generate(nameAndOpenController.names.length, (index) {
          return buildDoctorCard(index, widthRatio, heightRatio);
        }),
      ),
    );
  }

  GestureDetector buildDoctorCard(
      int index, double widthRatio, double heightRatio) {
    return GestureDetector(
      onTap: () => Get.to(
          () => DetailPage(name: nameAndOpenController.names[index]),
          transition: Transition.zoom),
      child: Padding(
        padding: EdgeInsets.only(left: 24, right: 24, bottom: 15),
        child: Container(
          width: 327 * widthRatio,
          height: 80 * heightRatio,
          child: Stack(
            children: [
              Container(
                width: 87 * widthRatio,
                height: 80 * heightRatio,
                child: Image.asset(
                    "assets/images/${nameAndOpenController.images[index]}",
                    fit: BoxFit.cover),
              ),
              Padding(
                padding: EdgeInsets.only(left: 104, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'dr. ${nameAndOpenController.names[index]}',
                          style: TextStyle(
                            color: Color(0xFF404345),
                            fontSize: 16,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w700,
                            height: 0.09,
                            letterSpacing: 0.02,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Heart | Persahabatan Hospital',
                          style: TextStyle(
                            color: Color(0xFFAAAAAA),
                            fontSize: 14,
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.w400,
                            height: 0.11,
                            letterSpacing: 0.04,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            RatingBar.builder(
                              itemSize: 20 * widthRatio,
                              wrapAlignment: WrapAlignment.start,
                              initialRating: ratingController.ratings[index],
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: ratingController.ratings.length,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (val) {
                                ratingController.ratings[index] = val;
                              },
                            ),
                            Text(
                              '(1221)',
                              style: TextStyle(
                                color: Color(0xFFC4C4C4),
                                fontSize: 12 * widthRatio,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: 56 * widthRatio,
                          height: 24 * heightRatio,
                          child: Stack(
                            children: [
                              Container(
                                width: 56 * widthRatio,
                                height: 24 * heightRatio,
                                decoration: ShapeDecoration(
                                  color: nameAndOpenController.isOpen[index]
                                      ? Color(0xFFCCF5E1)
                                      : Color(0xFFF7E4D9),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                              ),
                              Center(
                                child: Text(
                                  nameAndOpenController.isOpen[index]
                                      ? 'Open'
                                      : 'Closed',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: nameAndOpenController.isOpen[index]
                                        ? Color(0xFF00CC6A)
                                        : Color(0xFFCC4900),
                                    fontSize: 12 * widthRatio,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.05,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
