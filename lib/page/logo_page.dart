import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'common/app_name_widget.dart';
import 'common/animated_text.dart';
import 'config/custom_colors.dart';
import 'common/routes.dart';

class LogoPage extends StatefulWidget {
  const LogoPage({Key? key}) : super(key: key);

  @override
  State<LogoPage> createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, AppRoutes.HOME);
     /* Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c) {
        return const Home();
      }));*/
    });
  }

  void _buttonHome(BuildContext context){
    Navigator.pushNamed(context, AppRoutes.HOME);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                CustomColors.customSwatchColor.shade300,
                CustomColors.customSwatchColor.shade900,
              ])),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // logo do evento
              AppNameWidget(),
              // letreiro
              Signboard(),
              //SizedBox(height: 10),
              /*CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),*/
              // botão de entrar
          /*    ElevatedButton(onPressed: () => _buttonHome(context),
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      width: 5,
                      color: Color(0xD5B47E),
                    ),
                    backgroundColor: Colors.deepOrange,
                  ),
                  child: Text("Entrar")),*/
            ],
          )),
    );
  }
}
