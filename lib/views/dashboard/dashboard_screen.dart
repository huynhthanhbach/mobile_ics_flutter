import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/dashboard_controller.dart';

class DashboardScreen extends GetWidget<DashboardController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  color: const Color(0xFFFCFCFC),
                  height: 370,
                  width: size.width,
                  child: Stack(
                    children: [
                      Container(
                        height: 150,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1393f4),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 66,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 35,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.menu,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 18,
                                        ),
                                        Text(
                                          "Dashboard",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 34,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.menu,
                                    size: 70,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: const Alignment(0, .7),
                        child: Container(
                          height: 219,
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(4, 4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.redAccent,
                  height: 500,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
