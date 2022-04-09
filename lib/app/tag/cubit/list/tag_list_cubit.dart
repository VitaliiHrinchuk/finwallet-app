import 'package:bloc/bloc.dart';
import 'package:finwallet_app/app/tag/domain/tag_entity.dart';
import 'package:finwallet_app/app/tag/usecases/query_tags.dart';
import 'package:finwallet_app/common/http_client/pagination.dart';
import 'package:finwallet_app/common/http_client/query_params.dart';

import '../../../../common/http_client/exceptions.dart';

part 'tag_list_state.dart';

class TagListCubit extends Cubit<TagListState> {
  final QueryTags _queryTags;

  TagListCubit(this._queryTags) : super(TagListInitial());

  void load() async {
    try {
      emit(state.copyWith(loading: true));
      QueryParams queryParams = QueryParams({});

      Pagination<TagEntity> result = await this._queryTags(
          QueryTagsParams(query: queryParams)
      );

      emit(state.copyWith(loading: false, entities: result.data, loaded: true));
    } on HttpException catch (error) {

      print(error);
      emit(state.copyWith(loading: false, error: error));
    } catch (error) {

      print(error);
      emit(state.copyWith(loading: false, error: error.toString()));
    }
  }
}
