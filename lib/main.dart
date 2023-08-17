import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wticifesapp/initialization.dart';
import 'package:wticifesapp/page/common/routes.dart';
import 'package:wticifesapp/page/base.dart';
import 'package:wticifesapp/services/notificationservice.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NotificationService()),],
      child: MaterialApp(
        title: 'WTICIFES 2023',
        theme: ThemeData(
          primaryColor: const Color(0xD5B47E),
          scaffoldBackgroundColor: const Color(0x4C0B1C),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xD5B47E),
            secondary: Colors.blueAccent[700],
          ),
        ),
        routes: {
          AppRoutes.HOME: (ctx) => BaseScreen(),
        },
        debugShowCheckedModeBanner: false,
        home: const Initialization(),
      ),
    );
  }
}
