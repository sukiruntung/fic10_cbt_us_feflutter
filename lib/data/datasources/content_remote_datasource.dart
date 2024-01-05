import 'package:dartz/dartz.dart';
import 'package:fic10_cbt/data/models/responses/content_response_model.dart';
import 'package:http/http.dart' as http;

import '../../core/const/variabels.dart';
import 'auth_local_datasource.dart';

class ContentRemoteDatasource {
  // get c getContent getContentontent by id
  Future<Either<String, ContentResponseModel>> getContentById(String id) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse('${Variabels.baseUrl}/api/contents?id=${id}'),
      headers: <String, String>{
        'content-type': "application/json",
        'authorization': "Bearer ${authData.accessToken}",
      },
    );

    if (response.statusCode == 200) {
      return Right(ContentResponseModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }
}
