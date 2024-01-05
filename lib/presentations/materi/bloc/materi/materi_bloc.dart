import 'package:bloc/bloc.dart';
import 'package:fic10_cbt/data/datasources/materi_remote_datasource.dart';
import 'package:fic10_cbt/data/models/responses/materi_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'materi_event.dart';
part 'materi_state.dart';
part 'materi_bloc.freezed.dart';

class MateriBloc extends Bloc<MateriEvent, MateriState> {
  MateriBloc() : super(const _Initial()) {
    on<_GetAllMateri>((event, emit) async {
      emit(const _Loading());
      final response = await MateriRemoteDatasource().getAllMateri();
      response.fold((l) => emit(_Error(l)), (r) => emit(_Loaded(r)));
    });
  }
}
