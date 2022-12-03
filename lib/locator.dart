import 'package:bazar_y_pico/Services/Auth_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setup(){
  locator.registerLazySingleton<AuthService>(() => AuthService());
}