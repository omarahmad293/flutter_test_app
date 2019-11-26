import 'package:geolocator/geolocator.dart';
import 'package:device_info/device_info.dart';

Map<String, dynamic> fibonacci(int n) {
  BigInt f1 = BigInt.from(0);
  BigInt f2 = BigInt.from(1);

  DateTime t1 = DateTime.now();

  for (int i = 1; i < n; i++) {
    f2 = f1 + f2;
    f1 = f2 - f1;
  }

  DateTime t2 = DateTime.now();

  return {"f": f2, "t": t2.difference(t1)};
}

Future<Position> getPosition() async {
  return await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}

Future<AndroidDeviceInfo> getDeviceInfo() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  return await deviceInfo.androidInfo;
}
