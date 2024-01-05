import 'package:bloc/bloc.dart';
import 'package:fic10_cbt/data/datasources/ujian_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_ujian_event.dart';
part 'create_ujian_state.dart';
part 'create_ujian_bloc.freezed.dart';

class CreateUjianBloc extends Bloc<CreateUjianEvent, CreateUjianState> {
  final UjianRemoteDatasource ujianRemoteDatasource;
  CreateUjianBloc(this.ujianRemoteDatasource) : super(const _Initial()) {
    on<_CreatedUjian>((event, emit) async {
      emit(const _Loading());
      final response = await ujianRemoteDatasource.createUjian();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
