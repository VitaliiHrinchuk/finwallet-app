import 'package:bloc/bloc.dart';
import 'package:finwallet_app/app/transaction/dto/create_transaction_dto.dart';
import 'package:finwallet_app/app/transaction/usecases/create_transaction.dart';
import 'package:finwallet_app/common/http_client/exceptions.dart';
import 'package:meta/meta.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final CreateTransaction _createTransaction;

  TransactionCubit(this._createTransaction) : super(TransactionInitial());

  void create(CreateTransactionDto dto) async {
    try {
      emit(TransactionLoading());

      await this._createTransaction(CreateTransactionParams(dto: dto));

      emit(TransactionLoaded());
    } on HttpException catch (error) {
      print(error);
      emit(TransactionError(error.toString()));
    } catch (error) {
      print(error);
      emit(TransactionError(error.toString()));
    }
  }
}
