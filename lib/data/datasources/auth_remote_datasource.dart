import 'package:dartz/dartz.dart';
import 'package:fic10_cbt/core/const/variabels.dart';
import 'package:fic10_cbt/data/datasources/auth_local_datasource.dart';
import 'package:fic10_cbt/data/models/request/register_request_model.dart';
import 'package:fic10_cbt/data/models/responses/auth_response_model.dart';
import 'package:http/http.dart' as http;

import '../models/request/login_request_model.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> Register(
      RegisterRequestModel registerRequestModel) async {
    final response = await http.post(
        Uri.parse('${Variabels.baseUrl}/api/register'),
        headers: <String, String>{'content-type': "application/json"},
        body: registerRequestModel.toJson());

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('Register Gagal');
    }
  }

  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variabels.baseUrl}/api/register'),
      headers: <String, String>{
        'content-type': "application/json",
        'authorization': "Bearer ${authData.accessToken}",
      },
    );

    if (response.statusCode == 200) {
      return const Right('Logout Berhasil');
    } else {
      return const Left('Logout Gagal');
    }
  }

  Future<Either<String, AuthResponseModel>> login(
      LoginRequestModel loginRequestModel) async {
    final response = await http.post(
        Uri.parse('${Variabels.baseUrl}/api/login'),
        headers: <String, String>{'content-type': "application/json"},
        body: loginRequestModel.toJson());

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('Login Gagal');
    }
  }
}
