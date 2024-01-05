part of 'materi_bloc.dart';

@freezed
class MateriState with _$MateriState {
  const factory MateriState.initial() = _Initial;
  const factory MateriState.loading() = _Loading;
  const factory MateriState.loaded(MateriResponseModel data) = _Loaded;
  const factory MateriState.Error(String message) = _Error;
}
