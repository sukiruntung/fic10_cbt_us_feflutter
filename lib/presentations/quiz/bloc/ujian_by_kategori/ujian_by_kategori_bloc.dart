import 'package:bloc/bloc.dart';
import 'package:fic10_cbt/data/datasources/ujian_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/responses/ujian_response_model.dart';

part 'ujian_by_kategori_event.dart';
part 'ujian_by_kategori_state.dart';
part 'ujian_by_kategori_bloc.freezed.dart';

class UjianByKategoriBloc
    extends Bloc<UjianByKategoriEvent, UjianByKategoriState> {
  UjianByKategoriBloc() : super(const _Initial()) {
    on<_GetUjianKategori>((event, emit) async {
      emit(const _Loading());
      final response =
          await UjianRemoteDatasource().getUjianByKategori(event.kategori);
      response.fold((l) => emit(_Error(l)), (r) {
        if (r.data.isEmpty) {
          emit(const _Notfound());
        } else {
          emit(_Loaded(r));
        }
      });
    });
  }
}
