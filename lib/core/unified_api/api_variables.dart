import 'dart:developer';

import '../extensions/colorful_logging_extension.dart';
import '../helper/type_defs.dart';

class ApiVariables {
  /////////////
  ///General///
  /////////////
  static const _scheme = 'http';
  static const _host = 'food.programmer23.store';

  static Uri _mainUri({
    required String path,
    ParamsMap queryParameters,
  }) {
    final uri = Uri(
      scheme: _scheme,
      host: _host,
      path: path,
      queryParameters: queryParameters,
    );
    log(uri.toString().logMagenta);
    return uri;
  }

  static Uri _mobileUri({required String path, ParamsMap queryParameters}) =>
      _mainUri(
        path: 'user/$path',
        queryParameters: queryParameters,
      );

  ///Auth
  static Uri _auth({required String path}) {
    return _mobileUri(path: 'auth/$path');
  }

  static Uri register() {
    return _auth(path: 'register');
  }

  static Uri login() {
    return _auth(path: 'login');
  }

  static Uri verifyAccount() {
    return _auth(path: 'verifyaccount');
  }

  static Uri sendResetPasswordOTP() {
    return _mobileUri(path: 'password/sendemail');
  }

  static Uri checkPasswordCode() {
    return _mobileUri(path: 'password/checkCode');
  }

  static Uri changePassword() {
    return _mobileUri(path: 'password/changePassword');
  }

  static Uri placeOrder() {
    return _mobileUri(path: "order/store");
  }

  ///grocery
  static Uri groceryIndex() {
    return _mobileUri(path: 'grocery/index');
  }

  static Uri groceryStore() {
    return _mobileUri(path: 'grocery/store');
  }

  static Uri groceryUpdate(ParamsMap queryParameters) {
    return _mobileUri(path: 'grocery/update', queryParameters: queryParameters);
  }

  static Uri groceryDelete(int id) {
    return _mobileUri(path: 'grocery/$id/destroy');
  }

  ///Media
  static Uri uploadMedia() => _mainUri(path: 'addimage');
  // Uri uploadVideo() => _mainUri(path: "videoUpload");
  // Uri uploadGif() => _mainUri(path: "GIFUpload");

  static Uri indexRecipes({ParamsMap queryParameters}) =>
      _mobileUri(path: 'recipe/index', queryParameters: queryParameters);
static Uri showRecipe(int id) => _mobileUri(
        path: 'recipe/$id/show',
      );

  /////ingredient////
  static Uri indexIngredientsCategories({ParamsMap queryParameters}) =>
      _mainUri(
          path: 'dashboard/categoryingredient/index',
          queryParameters: queryParameters);

  static Uri indexIngredients({ParamsMap queryParameters}) =>
      _mobileUri(path: 'ingredient/index', queryParameters: queryParameters);

  static Uri showIngredients({required int id, ParamsMap queryParameters}) =>
      _mobileUri(path: 'ingredient/$id/show');

  static Uri indexWishlist({ParamsMap queryParameters}) => _mobileUri(
        path: 'wishlist/index',
      );

  static Uri addToWishlist({ParamsMap queryParameters}) => _mobileUri(
        path: 'wishlist/store',
      );
  static Uri removeFromWishlist({required int id, ParamsMap queryParameters}) =>
      _mobileUri(
        path: 'wishlist/$id/destroy',
      );
}
