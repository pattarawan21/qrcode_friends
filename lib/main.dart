import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrcode_fr/src/common/theme/theme.dart';
import 'package:qrcode_fr/src/modules/friends/showfriend/showfriend_view.dart';
import 'package:qrcode_fr/src/utills/cache/hive_manager.dart';




void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveManager.init();

  runApp(
    const ProviderScope (child: MyApp()) ,
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qr Code Friend',
      theme: theme,
      home: const ShowFriendViewScreen(),
    );
  }
}