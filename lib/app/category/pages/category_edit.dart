import 'package:finwallet_app/app/category/cubit/form/category_form_cubit.dart';
import 'package:finwallet_app/app/category/domain/category_entity.dart';
import 'package:finwallet_app/common/dependencies.dart';
import 'package:finwallet_app/common/utils/snackbar.dart';
import 'package:finwallet_app/common/widgets/app_bar/main_app_bar.dart';
import 'package:finwallet_app/common/widgets/input/main_input_decoration.dart';
import 'package:finwallet_app/common/widgets/loading_button_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryEdit extends StatelessWidget {
  final CategoryEntity? entity;

  bool get isEdit => this.entity != null;

  CategoryEdit({this.entity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: this.isEdit ? "Edit Category" : "Create New Category",
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) {
            CategoryFormCubit cubit = di<CategoryFormCubit>();

            if (this.isEdit) {
              cubit.setType(this.entity!.type);
              cubit.setName(this.entity!.name);
            }

            return cubit;
          },
          child: BlocListener<CategoryFormCubit, CategoryFormState>(
            listener: (context, state) {
              if (state.saved) {
                if (this.isEdit) {
                  showFloatSnackBar(context, "Category Saved");
                } else {
                  showFloatSnackBar(context, "New Category Saved");
                }
                Navigator.of(context).pop();
              }
            },
            child: Container(
              padding: EdgeInsets.all(20),
              child: Form(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    BlocBuilder<CategoryFormCubit, CategoryFormState>(
                        builder: (formContext, formState) {
                      return TextFormField(
                        keyboardType: TextInputType.text,
                        initialValue: formState.name,
                        enableSuggestions: false,
                        autocorrect: false,
                        onChanged: (value) {
                          formContext.read<CategoryFormCubit>().setName(value);
                        },
                        decoration: MainInputDecoration(
                          labelText: "Name",
                        ),
                      );
                    }),
                    SizedBox(
                      height: 18,
                    ),
                    BlocBuilder<CategoryFormCubit, CategoryFormState>(
                      builder: (context, formState) {
                        return FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: MainInputDecoration(
                                labelText: "Type",
                              ),
                              child: DropdownButtonHideUnderline(

                                child: DropdownButton<CategoryType>(

                                  value: formState.type,
                                  isDense: true,
                                  onChanged: (CategoryType? newValue) {
                                    if (!this.isEdit) {
                                      context
                                          .read<CategoryFormCubit>()
                                          .setType(newValue!);
                                    }
                                  },
                                  items: CategoryType.values
                                      .map((CategoryType value) {
                                    return DropdownMenuItem<CategoryType>(
                                      value: value,
                                      child: Text(value == CategoryType.CRE
                                          ? "Expense"
                                          : "Income"),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    Expanded(child: Container()),
                    BlocBuilder<CategoryFormCubit, CategoryFormState>(
                      builder: (formContext, formState) {
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (this.isEdit) {
                                formContext
                                    .read<CategoryFormCubit>()
                                    .update(this.entity!);
                              } else {
                                formContext.read<CategoryFormCubit>().create();
                              }
                            },
                            child: getButtonChild(formState),
                          ),
                        );
                      },
                    ),
                  ])),
            ),
          ),
        ),
      ),
    );
  }

  Widget getButtonChild(CategoryFormState state) {
    if (state.loading) {
      return LoadingButtonContent();
    }
    return Text("SAVE");
  }
}
