import 'package:get/get.dart';
import 'package:leader_app/routes/routes.dart';
import 'package:leader_app/features/start_screen.dart';


class AppRoutes {
static final pages = [
GetPage(name: TRoutes.home, page: () => const StartScreen()),

// Add more GetPage entries as needed
];
}