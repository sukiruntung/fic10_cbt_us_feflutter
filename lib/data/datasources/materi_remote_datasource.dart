import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../core/const/variabels.dart';
import '../models/responses/materi_response_model.dart';
import 'auth_local_datasource.dart';

class MateriRemoteDatasource {
  // get c getContent getContentontent by id
  Future<Either<String, MateriResponseModel>> getAllMateri() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse('${Variabels.baseUrl}/api/materis'),
      headers: <String, String>{
        'content-type': "application/json",
        'authorization': "Bearer ${authData.accessToken}",
      },
    );

    if (response.statusCode == 200) {
      return Right(MateriResponseModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }
}
