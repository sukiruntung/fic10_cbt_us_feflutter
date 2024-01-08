part of 'answer_bloc.dart';

@freezed
class AnswerState with _$AnswerState {
  const factory AnswerState.initial() = _Initial;
  const factory AnswerState.loading() = _Loading;
  const factory AnswerState.Success() = _Success;
  const factory AnswerState.iError(String message) = _Error;
}
