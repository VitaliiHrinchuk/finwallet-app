import 'package:bloc/bloc.dart';
import 'package:finwallet_app/app/tag/domain/tag_entity.dart';
import 'package:finwallet_app/app/tag/usecases/create_tag.dart';
import 'package:finwallet_app/app/tag/usecases/update_tag.dart';
import 'package:finwallet_app/common/http_client/exceptions.dart';
import 'package:meta/meta.dart';

part 'tag_form_state.dart';


class TagFormCubit extends Cubit<TagFormState> {
  final CreateTag _createTag;
  final UpdateTag _updateTag;

  TagFormCubit(this._createTag, this._updateTag) : super(TagFormInitial());

  void setName(String name) {
    emit(state.copyWith(name: name));
  }

  void update(TagEntity entity) async {
    try {
      emit(state.copyWith(loading: true));

      TagEntity newEntity = entity.copyWith(name: this.state.name!);

      await this._updateTag(UpdateTagParams(entity: newEntity));

      emit(state.copyWith(loading: false, saved: true));
    } on HttpException catch (error) {

      print(error);
      emit(state.copyWith(loading: false, error: error));
    } catch (error) {

      print(error);
      emit(state.copyWith(loading: false, error: error.toString()));
    }
  }

  void create() async {
    try {
      emit(state.copyWith(loading: true));

      await this._createTag(CreateTagParams(
          name: this.state.name!
      ));

      emit(state.copyWith(loading: false, saved: true));
    } on HttpException catch (error) {

      print(error);
      emit(state.copyWith(loading: false, error: error));
    } catch (error) {

      print(error);
      emit(state.copyWith(loading: false, error: error.toString()));
    }
  }

}
