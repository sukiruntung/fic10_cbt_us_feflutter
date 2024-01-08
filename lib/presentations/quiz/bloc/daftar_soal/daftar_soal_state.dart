part of 'daftar_soal_bloc.dart';

@freezed
class DaftarSoalState with _$DaftarSoalState {
  const factory DaftarSoalState.initial() = _Initial;
  const factory DaftarSoalState.loading() = _Loading;
  const factory DaftarSoalState.success(
      List<Ujian> data, int index, bool isNext) = _Success;
  const factory DaftarSoalState.error() = _Error;
}
