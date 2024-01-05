import 'package:bloc/bloc.dart';
import 'package:fic10_cbt/data/datasources/content_remote_datasource.dart';
import 'package:fic10_cbt/data/models/responses/content_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_event.dart';
part 'content_state.dart';
part 'content_bloc.freezed.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  final ContentRemoteDatasource remoteDatasources;
  ContentBloc(this.remoteDatasources) : super(const _Initial()) {
    on<_GetContentById>((event, emit) async {
      emit(const _Loading());
      final response = await remoteDatasources.getContentById(event.id);
      response.fold((l) => emit(_Error(l)), (r) => emit(_Loaded(r)));
    });
  }
}
