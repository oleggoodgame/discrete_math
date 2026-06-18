import 'package:discrete_math/injections/auth/auth_injection.dart';
import 'package:discrete_math/injections/favorite/favorite_injection.dart';
import 'package:discrete_math/injections/graph/graph_injection.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    AuthInjection(getIt).init();
    GraphInjection(getIt).init();
    FavoriteInjection(getIt).init();
  }
}
