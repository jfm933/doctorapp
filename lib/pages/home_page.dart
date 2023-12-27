import 'dart:ffi';
import 'dart:math';

import 'package:doctorapp/pages/detail_page.dart';
import 'package:doctorapp/pages/see_all_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../controller/rating_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RatingController ratingController = Get.put(RatingController());
  final NameAndOpenController nameAndOpenController =
      Get.put(NameAndOpenController());
  @override
  Widget build(BuildContext context) {
    double widthRatio = MediaQuery.sizeOf(context).width / 375;
    double heightRatio = MediaQuery.sizeOf(context).height / 812;
    int totalData = min(nameAndOpenController.names.length,
        nameAndOpenController.isOpen.length);
    print(totalData);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white60,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
              onTap: () {
                // Update the state of the app
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                // Update the state of the app
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
              print("Drawer Opened");
            },
            child: Image.asset("assets/images/Icons-Menu-Burger.png"),
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/Bung 1.png"),
          ),
          SizedBox(
            width: 25,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 103,
              ),
              child: Container(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Find ',
                        style: TextStyle(
                          color: Color(0xFF25282B),
                          fontSize: 34 * widthRatio,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.09,
                        ),
                      ),
                      TextSpan(
                        text: 'your doctor',
                        style: TextStyle(
                          color: Color(0xFFA0A4A8),
                          fontSize: 34 * widthRatio,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.09,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            buildSearchBar(widthRatio, heightRatio),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Container(
                width: 327 * widthRatio,
                height: 170 * heightRatio,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 10,
                  ),
                  children: List.generate(
                    8,
                    (index) {
                      List<String> description = [
                        "Consultation",
                        "Dental",
                        "Surgeon",
                        "Medicines",
                        "Physician",
                        "Hearth",
                        "Hospital",
                        "Skin",
                      ];

                      List<String> images = [
                        "007-stethoscope (1)",
                        "004-teeth",
                        "005-syringe",
                        "012-medicine",
                        "013-care-2",
                        "017-heart",
                        "024-clinic",
                        "028-bandage",
                      ];
                      List<Color> backgroundColor = [
                        Color(0xFF4485FD),
                        Color(0xFFA584FF),
                        Color(0xFFFF7854),
                        Color(0xFFFFB547),
                        Color(0xFF00CC6A),
                        Color(0xFF00C9E4),
                        Color(0xFFFD44B3),
                        Color(0xFFFD4444),
                      ];

                      List<Color> secondaryColor = [
                        Color(0xFF6299FF),
                        Color(0xFFB79CFF),
                        Color(0xFFFFA188),
                        Color(0xFFFFB547),
                        Color(0xFF1AD37A),
                        Color(0xFF05D1ED),
                        Color(0xFFFF71C6),
                        Color(0xFFFF7070),
                      ];
                      return buildConsultation(
                        widthRatio,
                        heightRatio,
                        images[index],
                        backgroundColor[index],
                        secondaryColor[index],
                        description[index],
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Doctors',
                    style: TextStyle(
                      color: Color(0xFF25282B),
                      fontSize: 18 * widthRatio,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.04,
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Get.to(() => SeeAllPage(), transition: Transition.zoom),
                    child: Text(
                      'View all',
                      style: TextStyle(
                        color: Color(0xFF4485FD),
                        fontSize: 11 * widthRatio,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.03,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Column(
              children: List.generate(totalData, (index) {
                print(index);
                return buildDoctorCard(widthRatio, heightRatio, index);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDoctorCard(double widthRatio, double heightRatio, int index) {
    return GestureDetector(
      onTap: () {
        Get.to(
            DetailPage(
              name: nameAndOpenController.names[index],
              image: nameAndOpenController.images[index],
              index: index,
              hospitalName: nameAndOpenController.hospitalName[index],
              specialist: nameAndOpenController.specialities[index],
            ),
            transition: Transition.zoom);
        print("Detail Page Opened at ${index + 1}");
      },
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
                        Obx(() => Text(
                              'dr. ${nameAndOpenController.names[index]}',
                              style: TextStyle(
                                color: Color(0xFF404345),
                                fontSize: 16,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w700,
                                height: 0.09,
                                letterSpacing: 0.02,
                              ),
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${nameAndOpenController.specialities[index]} | ${nameAndOpenController.hospitalName[index]}',
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
                              "${nameAndOpenController.userCount[index]}",
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

  Padding buildSearchBar(double widthRatio, double heightRatio) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: 327 * widthRatio,
        height: 56 * heightRatio,
        decoration: ShapeDecoration(
          color: Color(0xFFF6F6F6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            border: InputBorder.none,
            suffixIcon: Icon(
              Icons.search,
              color: Color(0xFFA0A4A8),
            ),
            hintText: "Search doctor, medicines etc",
            hintStyle: TextStyle(
              color: Color(0xFFCACCCF),
              fontSize: 14 * widthRatio,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  Column buildConsultation(double widthRatio, double heightRatio, String image,
      Color backgroundColor, Color secondaryColor, String description) {
    return Column(
      children: [
        Container(
          width: 56 * widthRatio,
          height: 56 * heightRatio,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 56 * widthRatio,
                  height: 56 * heightRatio,
                  decoration: ShapeDecoration(
                    color: backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -19,
                top: -19,
                child: Container(
                  width: 38 * widthRatio,
                  height: 38 * heightRatio,
                  decoration: ShapeDecoration(
                    color: secondaryColor,
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 16,
                child: Container(
                  width: 24 * widthRatio,
                  height: 24 * heightRatio,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Image.asset("assets/images/$image.png"),
                ),
              ),
            ],
          ),
        ),
        FittedBox(
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF25282B),
              fontSize: 12 * widthRatio,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
