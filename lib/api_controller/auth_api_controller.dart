import 'dart:convert';
import 'dart:io';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:smartsstors/model/category.dart';
import 'package:smartsstors/model/categoryhome.dart';
import 'package:smartsstors/model/famous_products_home.dart';
import 'package:smartsstors/model/favoraite.dart';
import 'package:smartsstors/model/offer.dart';
import 'package:smartsstors/model/api_base_response.dart';
import 'package:smartsstors/model/cities.dart';
import 'package:smartsstors/pref/shared_pref_controller.dart';
import '../basic_screen/helpers.dart';
import '../basic_screen/sheet_code_activation.dart';
import '../model/api_respons_category.dart';
import '../model/api_respons_main_home.dart';
import '../model/data_home.dart';
import '../model/fvoraite_product.dart';
import '../model/latest_prouduct_home.dart';
import '../model/list_sub_category.dart';
import '../model/login_information.dart';
import '../model/passwored_Change.dart';
import '../model/product_offer.dart';
import '../model/product_one_search.dart';
import '../model/product_search.dart';
import '../model/product_sup_category.dart';
import '../model/products_model.dart';
import '../model/slider_image.dart';
import '../model/sup_category_product.dart';
import '../model/user_store.dart';
import 'api_settings.dart';

class AuthApiController with sheetCodeActivation, Helpers {

  Future<bool> register(BuildContext context,
      {required UserStore userStore}) async {
    var url = Uri.parse(ApiSettings.register);
    var response = await http.post(
      url,
      body: {
        'name': userStore.name,
        'mobile': userStore.mobile,
        'password': userStore.password,
        'gender': userStore.gender,
        'city_id': userStore.cityId.toString(),
        'STORE_API_KEY': userStore.STORE_API_KEY,
      },
    );
    if (response.statusCode == 201) {
      modalBottomSheetMenuCode(
        context: context,
        messageReplay: jsonDecode(response.body)['message'].toString(),
        code: jsonDecode(response.body)['code'].toString(),
      );
      // showSnackBar(
      //     context: context,
      //     message: jsonDecode(response.body)['code'].toString(),
      //     error: false);
      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(
        context: context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    } else {
      showSnackBar(
        context: context,
        message: 'Somthine went wrong, try again!',
        error: true,
      );
    }

    return false;
  }
  Future<bool> fcmToken(BuildContext context) async {
    var url = Uri.parse(ApiSettings.updatescreen);
    var response = await http.post(
      url,
      body: {
        'fcm_token': SharedPrefController().fcmtoken,
      },headers: {
        'Authorization':SharedPrefController().token,
      // 'Authorization':'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiYjhjMGFlOTc2NDMzMmZhZDk3YmViN2JkMzgwZWQ3N2YwNDE4MTUwNWE5YTFmYzE3N2M5N2E4OGRmZGRhYjliOTBjYjlkOGUwMjJlMDMzYTYiLCJpYXQiOjE2NDg5Mzc5NzYuNzUwNzMyLCJuYmYiOjE2NDg5Mzc5NzYuNzUwNzM1LCJleHAiOjE2NTMyNTc5NzYuNzQyODY2LCJzdWIiOiIxMDAxIiwic2NvcGVzIjpbIioiXX0.S3MsP4bizykp4P8MqEEYMUdY1sx_PnsAPvW1tKfz_Ru3t9bjnjKajFX3XMfocwy8reqYOJaWjvLG7CZ3AhVW58eErnjAu6BkMioD3Wuhsmb-W8RyfJAv3uX1y1dWeDAMDRntT_vWPWzPsoQRhXhkU3zyoorMSuq5G3qP0bHPbm20g9A5UUS2Z5D-3h1L9zXXLNLsxQCpyrgjOgCkDl73MAIxehAAFVn7HdVKs_CvfeBTFnAiO4RPPyjBxpqh9orrgkztsswlY_tilL-ZbiDBU3cV2f2IMiMD91H0Pq1VXAXQDF45oJlgpaycxG_dLrm9ZJ1uhv6LM6EhSQGjiiySqZ6NIT8rDtauKoQM6Xfh-QMdr7WxF76ic7aVM5WG-hDwY6MtrsfZayk4ePZyJxSNbP9x7DTENafFeoEVrE0g24XPRbsw6brX2pJ7p3QkTQqfIwr3qwgCZnohGenq4AwuviDwJNQfr_6Sc1K7HsL4_1jsyOQB_i5xzCTaJuy_5BfGgNbPzSKp8MpY-kx7xcocL_6Crsv1v634Jf-4WVcja5zNaa00Edxv8ie3TwsShrNK-z3hXE_kd52HmL0uVXBertOTwDn2TqS402tgSmEExbcq-sK3RIm-ijPKAc4qWD2rYpEXJ1wtWmXfVxacsaizg0oSMeGAVFeUvOFicCj5EMw',

    });
     if (response.statusCode == 200) {
      showSnackBar(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: false);
      return true;
    } else if (response.statusCode == 201) {
      showSnackBar(
        context: context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    } else {
      showSnackBar(
        context: context,
        message: response.body.toString(),
        error: true,
      );
    }

    return false;
  }

  Future<bool> updateInformation(BuildContext context,
      {required UserStore userStore}) async {
    var url = Uri.parse(ApiSettings.updateinformation);
    var response = await http.post(
      url,
      body: {
        'city_id': userStore.cityId.toString(),
        'name': userStore.name,
        'gender': userStore.gender,
      },headers: {
      'Authorization':SharedPrefController().token.toString(),

    }
    );
    if (response.statusCode == 200) {
      showSnackBar(
          context: context,
          message: jsonDecode(response.body)['message'].toString(),
          error: false);
      return true;
      // ModalBottomSheetMenucode(
      //   context: context,
      //   messagereplay: jsonDecode(response.body)['message'].toString(),
      //   code: jsonDecode(response.body)['code'].toString(),
      // );
    } else if (response.statusCode == 400) {
      showSnackBar(
        context: context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    } else {
      showSnackBar(
        context: context,
        message: response.body,
        error: true,
      );
    }

    return false;
  }
  Future<bool> passwordChange(BuildContext context,
      {required PasswordChange passwordChange}) async {
    var url = Uri.parse(ApiSettings.passwordchange);
    var response = await http.post(
      url,
      body: {
        'current_password': passwordChange.password,
        'new_password': passwordChange.NewPAssword,
        'new_password_confirmation': passwordChange.ConfirmPAssword,

      },headers:{'Authorization':SharedPrefController().token});
    if (response.statusCode == 200){
     // SharedPrefController().save(userstore: userstore, password: passwordChange.NewPAssword);

      // ModalBottomSheetMenucode(
      //   context: context,
      //   messagereplay: jsonDecode(response.body)['message'].toString(),
      //   code: jsonDecode(response.body)['code'].toString(),
      // );
      showSnackBar(
          context: context,
          message: jsonDecode(response.body)['message'].toString(),
          error: false);
      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(
        context: context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    } else {
      showSnackBar(
        context: context,
        message: response.body,
        error: true,
      );
    }

    return false;
  }
  Future<List<City>> getCities(BuildContext context) async {
    var url = Uri.parse(ApiSettings.cities);
    var response = await http
        .get(url, headers: {HttpHeaders.acceptHeader: 'application/json'});
    if (response.statusCode == 200) {
      showSnackBar(context: context, message: response.headers.toString());
      var josnRespone = jsonDecode(response.body);
      var apiBaseRespone = ApiBaseResponse.fromJson(josnRespone);
      return apiBaseRespone.list;
    }

    return [];
  }

  Future<bool> activation(BuildContext context, UserStore userStore) async {
    var url = Uri.parse(ApiSettings.activation);
    var response = await http.post(
      url,
      body: {
        'mobile': userStore.mobile,
        'code': userStore.actives,
      },
    );
    if (response.statusCode == 200) {
      showSnackBar(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: false);
      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(
        context: context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    } else {
      showSnackBar(
        context: context,
        message: 'Somthine went wrong, try again!',
        error: true,
      );
    }

    return false;
  }

  Future<bool> login(BuildContext context,
      {required String mobile, required String passwor}) async {
    var url = Uri.parse(ApiSettings.login);
    var response = await http.post(
      url,
      body: {
        'mobile': mobile,
        'password': passwor,
        'fcm_token':randomString(20),

      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      UserStore userStore = UserStore.fromJson(jsonResponse['data']);
      await SharedPrefController()
          .saveUserStore(userstore: userStore, password: passwor);
      showSnackBar(
        context: context,
        message: jsonResponse['message'],
      );
      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(
        context: context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    } else {
      showSnackBar(
        context: context,
        message: 'Something went wrong, try again!',
        error: true,
      );
    }

    return false;
  }

  Future<bool> favoraite(BuildContext context,
      {required int? product_id}) async {
    var url = Uri.parse(ApiSettings.favarite);
    var response = await http.post(
      url,
      body: {
        'product_id': product_id.toString(),
      },headers: {
      'Authorization':SharedPrefController().token
    }
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      showSnackBar(
        context: context,
        message: jsonResponse['message'],
      );
      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(
        context: context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    } else {
      showSnackBar(
        context: context,
        message: 'Something went wrong, try again!',
        error: true,
      );
    }

    return false;
  }

  Future<UserStore?> loginRead(
      {required String mobile, required String password}) async {
    var url = Uri.parse(ApiSettings.login);
    var response = await http.post(url, body: {
      'mobile': mobile,
      'password': password,
    }, headers: {
      'Authorization':SharedPrefController().token
    });
    if (response.statusCode == 200) {
      String responseBody = response.body;
      print(responseBody);
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      var apiBaseResponse = Logininformation.fromJson(jsonResponse);
      return apiBaseResponse.data!;
    } else {
      return null;
    }
  }

  Future<bool> forgetPassword(BuildContext context,
      {required String mobile}) async {
    var url = Uri.parse(ApiSettings.forgetPassword);
    var response = await http.post(url, body: {'mobile': mobile});
    if (response.statusCode == 200) {
      print('Code: ${jsonDecode(response.body)['code']}');
      modalBottomSheetMenuCode(
        context: context,
        messageReplay: jsonDecode(response.body)['message'].toString(),
        code: jsonDecode(response.body)['code'].toString(),
      );
      // showSnackBar(
      //   context: context,
      //   message: jsonDecode(response.body)['message'],
      // );
      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(
        context: context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    } else {
      showSnackBar(
        context: context,
        message: 'Something went wrong, try again!',
        error: true,
      );
    }
    return false;
  }

  Future<bool> resetPassword(BuildContext context,
      {required String email,
      required String code,
      required String password}) async {
    var url = Uri.parse(ApiSettings.resetPassword);
    var response = await http.post(url, body: {
      'mobile': email,
      'code': code,
      'password': password,
      'password_confirmation': password,
    });

    if (response.statusCode == 200) {
      showSnackBar(
        context: context,
        message: jsonDecode(response.body)['message'],
      );
      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(
        context: context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    } else {
      showSnackBar(
        context: context,
        message: 'Something went wrong, try again!',
        error: true,
      );
    }
    return false;
  }

  Future<DataHome?> getMainHome(BuildContext context) async {
    var url = Uri.parse(ApiSettings.home);
    var response = await http.get(url, headers: {
      'Authorization':SharedPrefController().token
    });
    if (response.statusCode == 200) {
      print(response.request);
      var jsonResponse = jsonDecode(response.body);
      var apiBaseResponse = MainHome.fromJson(jsonResponse);
      return apiBaseResponse.data;}
    else{showSnackBar(
      context: context,
      message: response.body,
      error: true,
    );}

    return null;
  }  Future<List<FvoraiteProduct?>> getFavoraite(BuildContext context) async {
    var url = Uri.parse(ApiSettings.favoraitescreen);
    var response = await http.get(url, headers: {
      'Authorization':SharedPrefController().token
    });
    if (response.statusCode == 200) {
      print(response.request);
      var jsonResponse = jsonDecode(response.body);
      var apiBaseResponse = Favorite.fromJson(jsonResponse);
      return apiBaseResponse.favoraiteproduct!;

  }
    return[];
  }
  Future<List<Productsmodel>> getProductDetails(
      {required int id}) async {
    var url = Uri.parse(
        ApiSettings.product.replaceFirst('{id}',id.toString()));
    print(url.toString());
    var response = await http.get(url, headers: {
      'Authorization': SharedPrefController().token
    });
    if (response.statusCode == 200) {
      var dataJsonArray = jsonDecode(response.body);
      print(dataJsonArray.toString());
      var apiResponse = Productsubcategory.fromJson(dataJsonArray);
      return apiResponse.list;
    }
    return [];
  }
  Future<List<SliderHome>> getSlider(BuildContext context) async {
    var url = Uri.parse(ApiSettings.home);
    var response = await http.get(url, headers: {
      'Authorization':'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMzA1NTI4NjI1OTE0YmNhNzllMzlkMmQ0MmNkN2RhN2I2MTVlOWIwNzEwZTg2YjcxYTE1ZGUwNmI0Zjk3YWQ0NWY0YmM0OWVlYmI3ZGE3MTIiLCJpYXQiOjE2NTI5MjU3NDkuNjk1MDkxLCJuYmYiOjE2NTI5MjU3NDkuNjk1MDk2LCJleHAiOjE2NTcyNDU3NDkuNjg5NTI2LCJzdWIiOiIxMDk1Iiwic2NvcGVzIjpbIioiXX0.mP-J2cpzRJb7yIOEUqDwUPXtrfHKgvZd9M0ccGaeOcbGC3oVBwrYveGVUworJurAbzEaYYJqS3ArZb-M-sQSg6TyEDRAdQ-5y5owZWnOynKKrfPWYBqqJ7feea75sIK3H2jbOsfk8HzeVCjUNfvitD9b1KXMExOOxnjgwQKj2GQ8_RY-pqv5Z2Om2LLTaOqHCuVCC1zExNWQOBgyEjgdqeoBaVCPeFwbCZGRR_d8EVjETDbmf3dvQjsL-A4QrHFsRAJiJS7nWoT3t5Yy6UnOomS2LC5LZDIj-Qt1UEwOr4IT7OSV4zsFsIegU86KIzaMzSMrQBeQxZuKZM86LhaXk0_KTYQEVeHFC5rM5KrAkubF6Cmxbyr5oUZdW8DHiSMT2DJYEiO32-QS4UM__Wg_gxS8HDGgZomFT6ebSa54YLlRzwf6CbhKn6ENn907pQk0wOPZ_4yl4sYNWeqIJ5b1oQGnmg4r8dIzQTUberQozyethcAS7gP2CgUqrwpVjY0DSwKOKqyXzYExp2ua8WNUANJcQZ04lXVWRMVvapyQ6sr_Bp8L0BUjX-OaDNwrJ8ZDqDmF5e7rh11-BCROyg5djhT2yPwGnqtJ1qcPJvY9tBk1RqC1MlYlME2xQeZDxfgJODdAYc-nUSWdFfarjQG4Icmn0l4pjGiXwnjUmKuAOzA',
    });
    if (response.statusCode == 200) {
      print(response.request);
      var josnRespone = jsonDecode(response.body);
      var apiBaseRespone = MainHome.fromJson(josnRespone);
      return apiBaseRespone.data.slider;
    }

    return [];
  }

  Future<List<CategoryHome>?> getCategory() async {
    var url = Uri.parse(ApiSettings.home);
    var response = await http.get(url, headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiYjhjMGFlOTc2NDMzMmZhZDk3YmViN2JkMzgwZWQ3N2YwNDE4MTUwNWE5YTFmYzE3N2M5N2E4OGRmZGRhYjliOTBjYjlkOGUwMjJlMDMzYTYiLCJpYXQiOjE2NDg5Mzc5NzYuNzUwNzMyLCJuYmYiOjE2NDg5Mzc5NzYuNzUwNzM1LCJleHAiOjE2NTMyNTc5NzYuNzQyODY2LCJzdWIiOiIxMDAxIiwic2NvcGVzIjpbIioiXX0.S3MsP4bizykp4P8MqEEYMUdY1sx_PnsAPvW1tKfz_Ru3t9bjnjKajFX3XMfocwy8reqYOJaWjvLG7CZ3AhVW58eErnjAu6BkMioD3Wuhsmb-W8RyfJAv3uX1y1dWeDAMDRntT_vWPWzPsoQRhXhkU3zyoorMSuq5G3qP0bHPbm20g9A5UUS2Z5D-3h1L9zXXLNLsxQCpyrgjOgCkDl73MAIxehAAFVn7HdVKs_CvfeBTFnAiO4RPPyjBxpqh9orrgkztsswlY_tilL-ZbiDBU3cV2f2IMiMD91H0Pq1VXAXQDF45oJlgpaycxG_dLrm9ZJ1uhv6LM6EhSQGjiiySqZ6NIT8rDtauKoQM6Xfh-QMdr7WxF76ic7aVM5WG-hDwY6MtrsfZayk4ePZyJxSNbP9x7DTENafFeoEVrE0g24XPRbsw6brX2pJ7p3QkTQqfIwr3qwgCZnohGenq4AwuviDwJNQfr_6Sc1K7HsL4_1jsyOQB_i5xzCTaJuy_5BfGgNbPzSKp8MpY-kx7xcocL_6Crsv1v634Jf-4WVcja5zNaa00Edxv8ie3TwsShrNK-z3hXE_kd52HmL0uVXBertOTwDn2TqS402tgSmEExbcq-sK3RIm-ijPKAc4qWD2rYpEXJ1wtWmXfVxacsaizg0oSMeGAVFeUvOFicCj5EMw'
    });
    if (response.statusCode == 200) {
      print(response.body);
      var josnRespone = jsonDecode(response.body);
      var apiBaseRespone = MainHome.fromJson(josnRespone);
      return apiBaseRespone.data.Categorie;
    }

    return [];
  }

  Future<List<LatestProducts>> getLatestProduct() async {
    var url = Uri.parse(ApiSettings.home);
    var response = await http.get(url, headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiYjhjMGFlOTc2NDMzMmZhZDk3YmViN2JkMzgwZWQ3N2YwNDE4MTUwNWE5YTFmYzE3N2M5N2E4OGRmZGRhYjliOTBjYjlkOGUwMjJlMDMzYTYiLCJpYXQiOjE2NDg5Mzc5NzYuNzUwNzMyLCJuYmYiOjE2NDg5Mzc5NzYuNzUwNzM1LCJleHAiOjE2NTMyNTc5NzYuNzQyODY2LCJzdWIiOiIxMDAxIiwic2NvcGVzIjpbIioiXX0.S3MsP4bizykp4P8MqEEYMUdY1sx_PnsAPvW1tKfz_Ru3t9bjnjKajFX3XMfocwy8reqYOJaWjvLG7CZ3AhVW58eErnjAu6BkMioD3Wuhsmb-W8RyfJAv3uX1y1dWeDAMDRntT_vWPWzPsoQRhXhkU3zyoorMSuq5G3qP0bHPbm20g9A5UUS2Z5D-3h1L9zXXLNLsxQCpyrgjOgCkDl73MAIxehAAFVn7HdVKs_CvfeBTFnAiO4RPPyjBxpqh9orrgkztsswlY_tilL-ZbiDBU3cV2f2IMiMD91H0Pq1VXAXQDF45oJlgpaycxG_dLrm9ZJ1uhv6LM6EhSQGjiiySqZ6NIT8rDtauKoQM6Xfh-QMdr7WxF76ic7aVM5WG-hDwY6MtrsfZayk4ePZyJxSNbP9x7DTENafFeoEVrE0g24XPRbsw6brX2pJ7p3QkTQqfIwr3qwgCZnohGenq4AwuviDwJNQfr_6Sc1K7HsL4_1jsyOQB_i5xzCTaJuy_5BfGgNbPzSKp8MpY-kx7xcocL_6Crsv1v634Jf-4WVcja5zNaa00Edxv8ie3TwsShrNK-z3hXE_kd52HmL0uVXBertOTwDn2TqS402tgSmEExbcq-sK3RIm-ijPKAc4qWD2rYpEXJ1wtWmXfVxacsaizg0oSMeGAVFeUvOFicCj5EMw'
    });
    if (response.statusCode == 200) {
      print(response.body);
      var jsonResponse = jsonDecode(response.body);
      var apiBaseResponse = MainHome.fromJson(jsonResponse);
      return apiBaseResponse.data.latestprouduct;
    }

    return [];
  }

  Future<List<famous_products>> getFamousProduct() async {
    var url = Uri.parse(ApiSettings.home);
    var response = await http.get(url, headers: {
      'Authorization':SharedPrefController().token
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var apiBaseResponse = MainHome.fromJson(jsonResponse);
      return apiBaseResponse.data.famousproduct;
    }

    return [];
  }

  Future<List<Category>> getCategories() async {
    var url = Uri.parse(ApiSettings.categories);
    var response = await http.get(url, headers: {
      'Authorization':SharedPrefController().token
    });
    if (response.statusCode == 200) {
      print(response.body);
      var dataJsonArray = jsonDecode(response.body);
      var apirespons = ApiResponseCategory.fromJson(dataJsonArray);
      return apirespons.list;
    }
    return [];
  }

  Future<List<ListSubcategory>> getSupCategory(
      {required int id}) async {
    var url = Uri.parse(
        ApiSettings.subcategories.replaceFirst('{id}', id.toString()));
    print(url.toString());
    var response = await http.get(url, headers: {
      'Authorization':SharedPrefController().token});
    if (response.statusCode == 200) {
      print(response.body);
      var dataJsonArray = jsonDecode(response.body);
      var apiResponse = Supcategoryproduct.fromJson(dataJsonArray);
      return apiResponse.listproduct;
    }
    return [];
  }


  Future<Objectproductone?> getProductOne(
      {required int id}) async {
    var url = Uri.parse(ApiSettings.productdeatials.replaceFirst('{id}', id.toString()));
    print(url.toString());
    var response = await http.get(url, headers: {
      'Authorization':SharedPrefController().token});
    if (response.statusCode == 200) {
      print(response.body);
      var dataJsonArray = jsonDecode(response.body);
      var apiResponse = Productdescription.fromJson(dataJsonArray);
      return apiResponse.object;
    }else{
      return null;
    }
  }

  Future<List<Offers>> getOffers() async {
    var url = Uri.parse(ApiSettings.offers);
    var response = await http.get(url, headers: {
      'Authorization':SharedPrefController().token});
    if (response.statusCode == 200) {
      print(response.body);
      var dataJsonArray = jsonDecode(response.body);
      var apiRespons = ProductOffer.fromJson(dataJsonArray);
      return apiRespons.offers!;
    }
    return [];
  }
}
