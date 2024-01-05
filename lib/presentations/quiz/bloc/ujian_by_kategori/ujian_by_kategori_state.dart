part of 'ujian_by_kategori_bloc.dart';

@freezed
class UjianByKategoriState with _$UjianByKategoriState {
  const factory UjianByKategoriState.initial() = _Initial;
  const factory UjianByKategoriState.loading() = _Loading;
  const factory UjianByKategoriState.loaded(UjianResponseModel response) =
      _Loaded;
  const factory UjianByKategoriState.error(String message) = _Error;
  const factory UjianByKategoriState.notfound() = _Notfound;
}
