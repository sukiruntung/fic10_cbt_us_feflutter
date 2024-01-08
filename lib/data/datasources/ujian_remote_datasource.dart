import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fic10_cbt/core/const/variabels.dart';
import 'package:http/http.dart' as http;

import '../models/responses/ujian_response_model.dart';
import 'auth_local_datasource.dart';

class UjianRemoteDatasource {
  Future<Either<String, UjianResponseModel>> getUjianByKategori(
      String kategori) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse(
        '${Variabels.baseUrl}/api/get-soal-ujian?kategori=$kategori',
      ),
      headers: <String, String>{
        'content-type': "application/json",
        'authorization': "Bearer ${authData.accessToken}",
      },
    );
    if (response.statusCode == 200) {
      return Right(UjianResponseModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }

  Future<Either<String, String>> createUjian() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse(
        '${Variabels.baseUrl}/api/create-ujian',
      ),
      headers: <String, String>{
        'content-type': "application/json",
        'authorization': "Bearer ${authData.accessToken}",
      },
    );
    if (response.statusCode == 200) {
      return const Right('Create ujian berhasil');
    } else {
      return const Left('Create ujian gagal');
    }
  }

  Future<Either<String, String>> answerUjian(int soalId, String jawaban) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final body = {
      'soal_id': soalId,
      'jawaban': jawaban,
    };
    print('soal_id: ${soalId}');
    print('jawaban: ' + jawaban);
    final response = await http.post(
      Uri.parse(
        '${Variabels.baseUrl}/api/answers',
      ),
      headers: <String, String>{
        'content-type': "application/json",
        'authorization': "Bearer ${authData.accessToken}",
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return const Right('Answer ujian berhasil');
    } else {
      return const Left('Answer ujian gagal');
    }
  }

  Future<Either<String, String>> hitungNilai(String kategori) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse(
        '${Variabels.baseUrl}/api/get-nilai?kategori=$kategori',
      ),
      headers: <String, String>{
        'content-type': "application/json",
        'authorization': "Bearer ${authData.accessToken}",
      },
    );
    if (response.statusCode == 200) {
      return const Right('Hitung nilai berhasil');
    } else {
      return const Left('Hitung nilai gagal');
    }
  }
}
