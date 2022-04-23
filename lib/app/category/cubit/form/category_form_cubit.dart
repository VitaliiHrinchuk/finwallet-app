import 'package:bloc/bloc.dart';
import 'package:finwallet_app/app/category/domain/category_entity.dart';
import 'package:finwallet_app/app/category/usecases/create_category.dart';
import 'package:finwallet_app/app/category/usecases/update_category.dart';
import 'package:finwallet_app/common/http_client/exceptions.dart';
import 'package:meta/meta.dart';

part 'category_form_state.dart';

class CategoryFormCubit extends Cubit<CategoryFormState> {
  final CreateCategory _createCategory;
  final UpdateCategory _updateCategory;

  CategoryFormCubit(this._createCategory, this._updateCategory) : super(CategoryFormInitial());

  void setName(String name) {
    emit(state.copyWith(name: name));
  }

  void setType(CategoryType type) {
    emit(state.copyWith(type: type));
  }

  void update(CategoryEntity entity) async {
    try {
      emit(state.copyWith(loading: true));

      CategoryEntity newEntity = entity.copyWith(name: this.state.name!, type: this.state.type!);

      await this._updateCategory(UpdateCategoryParams(entity: newEntity));

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

      await this._createCategory(CreateCategoryParams(
        name: this.state.name!,
        type: this.state.type!
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
