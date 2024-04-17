import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../routes/app_route.dart';

part 'app_route_provider.g.dart';

@Riverpod(keepAlive: true)
Raw<AppRouter> appRouter(AppRouterRef ref) {
  final router = AppRouter();
  // Riverpod won't dispose the ChangeNotifier for you in this case. Don't forget
  // to do it on your own!
  //ref.onDispose(router.dispose);
  return router;
}