import 'package:smartsstors/model/cities.dart';

class ApiSettings {
  static const _baseUrl = 'https://smart-store.mr-dev.tech/';
  static const _apiUrl = _baseUrl + 'api_controller/';
  static const _imagesUrl = _baseUrl + 'images/';

  static const users = _apiUrl + 'users';
  static const favarite = _apiUrl + 'favorite-products';
  static const home = _apiUrl + 'home';
  static const offers = _apiUrl + 'offers';
  static const categories = _apiUrl + 'categories';
  static const cities = _apiUrl + 'cities';
  static const activation = _apiUrl + 'auth/activate';
  static const login = _apiUrl + 'auth/login';

  static const logins = _apiUrl + 'students/auth/login';
  static const register = _apiUrl + 'auth/register';
  static const updateinformation = _apiUrl + 'auth/update-profile';
  static const updatescreen = _apiUrl + 'auth/refresh-fcm-token';
  static const favoraitescreen = _apiUrl + 'favorite-products';
  static const passwordchange = _apiUrl + 'auth/change-password';
  static const logout = _apiUrl + 'students/auth/logout';
  static const forgetPassword = _apiUrl + 'auth/forget-password';
  static const resetPassword = _apiUrl + 'auth/reset-password';
  static const images = _apiUrl + 'student/images/{id}';
  static const subcategories = _apiUrl + 'categories/{id}';
  static const product = _apiUrl + 'sub-categories/{id}';
  static const productdeatials = _apiUrl + 'products/{id}';

  static String getImageUrl({required String imageName}) {
    return _imagesUrl + imageName;
  }

}
