import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/analytics/coffsy_analytics.dart';
import 'core/cache/shared_pref_helper.dart';
import 'core/network/network.dart';
import 'modules/about/about_module.dart';
import 'modules/dashboard/dashboard_module.dart';
import 'modules/discover/discover_module.dart';
import 'modules/movie/movie_module.dart';
import 'modules/setting/setting_module.dart';
import 'modules/splash/splash_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [DiscoverModule(), MovieModule()];

  @override
  final List<Bind> binds = [
    Bind.lazySingleton<DioClient>((i) => DioClient(apiBaseUrl: ApiConstant.baseUrlDebug)),
    Bind.lazySingleton<Dio>((i) => i<DioClient>().dio),
    //
    Bind.lazySingleton<ApiConfigurations>((i) => ApiConfigurations()),
    //
    Bind.lazySingleton<CoffsyAnalytics>((i) => CoffsyAnalytics()),
    //
    Bind.lazySingleton<SharedPrefHelper>((i) => SharedPrefHelper(preferences: i())),
    AsyncBind<SharedPreferences>((i) => SharedPreferences.getInstance()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: SplashModule()),
    ModuleRoute('/dashboard', module: DashboardModule()),
    ModuleRoute('/discover_movie', module: DiscoverModule()),
    ModuleRoute('/about', module: AboutModule()),
    ModuleRoute('/theme', module: SettingModule()),
  ];
}
