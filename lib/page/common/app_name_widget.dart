import 'package:flutter/material.dart';

class AppNameWidget extends StatelessWidget {


  const AppNameWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(50, 80, 50, 80),
          child: Container(
            child: Image.asset(
              'images/logo.png',
            ),
          ),
    );
  }
}