import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/responses/ujian_response_model.dart';

part 'daftar_soal_event.dart';
part 'daftar_soal_state.dart';
part 'daftar_soal_bloc.freezed.dart';

class DaftarSoalBloc extends Bloc<DaftarSoalEvent, DaftarSoalState> {
  DaftarSoalBloc() : super(const _Initial()) {
    on<_GetDaftarSoal>((event, emit) async {
      emit(const _Loading()); // emit(DaftarSoalState.loading());

      emit(_Success(event.data, 0, event.data.length > 1));
    });
    on<_NextSoal>((event, emit) async {
      final curentState = state as _Success;
      // emit(const _Loading()); // emit(DaftarSoalState.loading());

      emit(_Success(curentState.data, curentState.index + 1,
          curentState.data.length > curentState.index + 2));
    });
  }
}
