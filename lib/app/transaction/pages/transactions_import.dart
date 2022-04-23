import 'dart:io';
import 'package:finwallet_app/app/transaction/cubit/transaction/transaction_cubit.dart';
import 'package:finwallet_app/common/dependencies.dart';
import 'package:finwallet_app/common/utils/snackbar.dart';
import 'package:finwallet_app/common/widgets/loading_button_content.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finwallet_app/app/account/cubit/list/accounts_list_cubit.dart';
import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/account/pages/account_select.dart';
import 'package:finwallet_app/app/transaction/domain/transaction_entity.dart';
import 'package:finwallet_app/common/widgets/app_bar/main_app_bar.dart';
import 'package:finwallet_app/common/widgets/input/main_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsImport extends StatefulWidget {
  @override
  State<TransactionsImport> createState() => _TransactionsImportState();
}

class _TransactionsImportState extends State<TransactionsImport> {
  TransactionType? type = TransactionType.CRE;
  AccountEntity? account;
  File? file;

  TextEditingController fileInputController = TextEditingController();
  TextEditingController accountInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: "Import Transactions",
      ),
      body: BlocProvider(
        create: (context) => di<TransactionCubit>(),
        child: BlocListener<TransactionCubit, TransactionState>(
          listener: (context, state) {
            if (state is TransactionError) {
              showFloatSnackBar(context, state.error);
            } else if (state is TransactionLoaded) {
              showFloatSnackBar(context, "Transactions successfully uploaded!");
              Navigator.pop(context);
            }
          },
          child: SafeArea(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: accountInputController,
                        readOnly: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        onTap: () {
                          _navigateAndSelectAccount(context);
                        },
                        decoration: MainInputDecoration(
                          labelText: "Account",
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: fileInputController,
                        readOnly: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        onTap: () {
                          pickFile();
                        },
                        decoration: MainInputDecoration(
                          labelText: "File",
                        ),
                      ),
                      SizedBox(height: 10),
                      FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: MainInputDecoration(
                              labelText: "Type",
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<TransactionType>(
                                value: type,
                                isDense: true,
                                onChanged: (TransactionType? newValue) {
                                  setState(() {
                                    type = newValue;
                                  });
                                },
                                items:
                                TransactionType.values.map((
                                    TransactionType value) {
                                  return DropdownMenuItem<TransactionType>(
                                    value: value,
                                    child: Text(value == TransactionType.CRE
                                        ? "Expense"
                                        : "Income"),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                      Expanded(child: Container()),
                      BlocBuilder<TransactionCubit, TransactionState>(
                        builder: (formContext, formState) {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                submitForm(formContext);
                              },
                              child: getButtonChild(formState),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

  void _navigateAndSelectAccount(BuildContext context) async {
    final String? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (childContext) {
        return BlocProvider.value(
            value: BlocProvider.of<AccountsListCubit>(context),
            child: AccountSelect());
      }),
    );

    if (result != null) {
      AccountEntity selectedAccount =
      BlocProvider
          .of<AccountsListCubit>(context)
          .state
          .entities
          .firstWhere((element) => element.id == result);

      setState(() {
        account = selectedAccount;
      });

      accountInputController.text = selectedAccount.name;
    }
  }


  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      File newFile = File(result.files.single.path!);

      setState(() {
        file = newFile;
      });

      fileInputController.text = basename(newFile.path);
    }
  }


  Widget getButtonChild(TransactionState state) {
    if (state is TransactionLoading) {
      return LoadingButtonContent();
    }
    return Text("SAVE");
  }

  void submitForm(context) {
    if (this.type != null && this.account != null && this.file != null) {
      BlocProvider.of<TransactionCubit>(context).import(
          this.type!,
          this.account!,
          this.file!
      );
    }
  }

}
