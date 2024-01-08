import 'package:bloc/bloc.dart';
import 'package:fic10_cbt/data/datasources/ujian_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer_event.dart';
part 'answer_state.dart';
part 'answer_bloc.freezed.dart';

class AnswerBloc extends Bloc<AnswerEvent, AnswerState> {
  AnswerBloc() : super(const _Initial()) {
    on<_SetAnswer>((event, emit) async {
      emit(const _Loading());
      final response = await UjianRemoteDatasource()
          .answerUjian(event.soalId, event.jawaban);
      response.fold((l) => emit(_Error(l)), (r) => emit(_Success()));
    });
  }
}
