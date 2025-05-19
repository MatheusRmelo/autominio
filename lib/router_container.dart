import 'package:go_router/go_router.dart';
import 'features/cameras/routes/cameras_router_container.dart' as cameras;

class RouterContainer {
  static final GoRouter getRoutes = GoRouter(
    routes: [
      ...cameras.getRouterContainer,
    ],
  );
}
