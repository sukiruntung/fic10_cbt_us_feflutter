import 'package:bloc/bloc.dart';
import 'package:fic10_cbt/data/datasources/ujian_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hitung_nilai_event.dart';
part 'hitung_nilai_state.dart';
part 'hitung_nilai_bloc.freezed.dart';

class HitungNilaiBloc extends Bloc<HitungNilaiEvent, HitungNilaiState> {
  HitungNilaiBloc() : super(const _Initial()) {
    on<_GetHitungNilai>((event, emit) async {
      emit(const _Loading());
      final response =
          await UjianRemoteDatasource().hitungNilai(event.kategori);
      response.fold((l) => emit(_Error(l)), (r) => emit(const _Success(100)));
    });
  }
}
