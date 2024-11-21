import 'package:flutter/material.dart';
import 'package:clock_in_demo/route_generator.dart' as router;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:clock_in_demo/network/http_service.dart';

void main() {
  HttpService service = HttpService.instance;
  service.initDio();

  runApp(
      const ProviderScope(child: MyApp())
  );
}

final class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: router.RoutePaths.punch,
      onGenerateRoute: router.Router.generateRoute,
      locale: Locale('zh_TW'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('zh', 'TW'),
        Locale('en'),
      ],
    );
  }
}