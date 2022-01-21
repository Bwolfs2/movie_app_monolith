import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'coffsy_design_system/common/common.dart';
import 'core/analytics/coffsy_analytics.dart';
import 'core/error/failure.dart';
import 'modules/setting/pages/setting_store.dart';

// Firebase Analytics
CoffsyAnalytics analytics = CoffsyAnalytics();

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();
    Modular.to.addListener(() async {
      try {
        var page = Modular.to.path.split('/').lastWhere((element) => element != '');
        await analytics.setCurrentScreen(screenName: page);
        // ignore: avoid_catches_without_on_clauses
      } catch (e) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<SettingStore, Failure, bool>.transition(
      store: SettingStore(),
      onLoading: (context) => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      onState: (context, state) {
        return MaterialApp(
          title: 'Coffsy Movie App',
          theme: state ? Themes.darkTheme : Themes.lightTheme,
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
          ],
        ).modular();
      },
    );
  }
}
