import 'package:flutter/material.dart';
import 'package:mobile_ics_flutter/core/helpers/constants.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Center(
                child: Text("DASHBOARD SCREEN"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
