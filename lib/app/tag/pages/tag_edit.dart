import 'package:finwallet_app/app/category/cubit/form/category_form_cubit.dart';
import 'package:finwallet_app/app/category/domain/category_entity.dart';
import 'package:finwallet_app/app/tag/cubit/form/tag_form_cubit.dart';
import 'package:finwallet_app/app/tag/domain/tag_entity.dart';
import 'package:finwallet_app/common/dependencies.dart';
import 'package:finwallet_app/common/utils/snackbar.dart';
import 'package:finwallet_app/common/widgets/app_bar/main_app_bar.dart';
import 'package:finwallet_app/common/widgets/input/main_input_decoration.dart';
import 'package:finwallet_app/common/widgets/loading_button_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagEdit extends StatelessWidget {
  final TagEntity? entity;

  bool get isEdit => this.entity != null;

  TagEdit({this.entity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: this.isEdit ? "Edit Tag" : "Create New Tag",
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) {
            TagFormCubit cubit = di<TagFormCubit>();

            if (this.isEdit) {
              cubit.setName(this.entity!.name);
            }

            return cubit;
          },
          child: BlocListener<TagFormCubit, TagFormState>(
            listener: (context, state) {
              if (state.saved) {
                if (this.isEdit) {
                  showFloatSnackBar(context, "Tag Saved");
                } else {
                  showFloatSnackBar(context, "New Tag Saved");
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
                        BlocBuilder<TagFormCubit, TagFormState>(
                            builder: (formContext, formState) {
                              return TextFormField(
                                keyboardType: TextInputType.text,
                                initialValue: formState.name,
                                enableSuggestions: false,
                                autocorrect: false,
                                onChanged: (value) {
                                  formContext.read<TagFormCubit>().setName(value);
                                },
                                decoration: MainInputDecoration(
                                  labelText: "Name",
                                ),
                              );
                            }),

                        Expanded(child: Container()),
                        BlocBuilder<TagFormCubit, TagFormState>(
                          builder: (formContext, formState) {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (this.isEdit) {
                                    formContext
                                        .read<TagFormCubit>()
                                        .update(this.entity!);
                                  } else {
                                    formContext.read<TagFormCubit>().create();
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

  Widget getButtonChild(TagFormState state) {
    if (state.loading) {
      return LoadingButtonContent();
    }
    return Text("SAVE");
  }
}
