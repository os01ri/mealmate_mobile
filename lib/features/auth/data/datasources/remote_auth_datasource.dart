import 'package:dartz/dartz.dart';
import 'package:mealmate/core/helper/type_defs.dart';
import 'package:mealmate/core/unified_api/api_variables.dart';
import 'package:mealmate/core/unified_api/methods/post_api.dart';
import 'package:mealmate/features/auth/data/models/login_response_model.dart';

class RemoteAuthDataSource {
  Future<LoginResponseModel> registerUser({required BodyMap body}) async {
    PostApi postApi = PostApi(
      uri: ApiVariables.register(),
      body: body,
      fromJson: loginResponseModelFromJson,
    );
    final result = await postApi.callRequest();
    return result;
  }

  Future<LoginResponseModel> loginUser({required BodyMap body}) async {
    PostApi postApi = PostApi(
      uri: ApiVariables.login(),
      body: body,
      fromJson: loginResponseModelFromJson,
    );
    final result = await postApi.callRequest();
    return result;
  }


  Future<Unit> resetPassword({required String email}) async {
    PostApi postApi = PostApi(
        uri: ApiVariables.resetPassord(),
        body: {"email": email},
        fromJson: (string) {});
    return await postApi.callRequest();
  }

  Future<Unit> verifyCode({required String code}) async {
    PostApi postApi = PostApi(
        uri: ApiVariables.resetPassord(),
        body: {"code": code},
        fromJson: (string) {});
    return await postApi.callRequest();
  }
}
