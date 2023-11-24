import 'package:get_storage/get_storage.dart';

class StorageKeys {
  static final GetStorage _storage = GetStorage();

  static String get storagedToken => _storage.read('token') ?? '';
 static String get storagedTokenTEST => "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NTVmNGUyODQ2ODNmMDAyMzYzMzNhNjYiLCJ1c2VyX3R5cGUiOiJhZG1pbiIsImNsaWVudF9udW1iZXIiOjEwMiwiaWF0IjoxNzAwODI3MTgyfQ.9-lKsxybw4lQyHHql2zA50ccWksjL_1pj5A3KTvfeIw";
}
