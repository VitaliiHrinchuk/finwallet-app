import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../common/constants/currencies.dart';

part 'user_setup_form_state.dart';

class UserSetupFormCubit extends Cubit<UserSetupFormState> {
  UserSetupFormCubit() : super(UserSetupFormInitial());

  void setBaseCurrency(Currency? baseCurrency) {
    emit(state.copyWith(baseCurrency: baseCurrency));
  }
}
