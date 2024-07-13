import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:login/components/custom_textfield.dart';
import 'package:login/cubit/add_todo_cubit.dart';
import 'package:login/cubit/common_state.dart';
import 'package:login/cubit/delete_todo_cubit.dart';
import 'package:login/cubit/todo_event.dart';
import 'package:login/cubit/update_todo_cubit.dart';
import 'package:login/to_do/todo.dart';

class CreateTodoScreen extends StatefulWidget {
  final Todo? todo;
  const CreateTodoScreen({super.key, this.todo});

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.shade50,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        title: Text(
          "Notes",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
            )),
      ),
      body: SingleChildScrollView(
        child: MultiBlocListener(
          listeners: [
            BlocListener<DeleteTodoCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonLoadingState) {
                  context.loaderOverlay.show();
                } else {
                  context.loaderOverlay.hide();
                }
                if (state is CommonSuccessState) {
                  Fluttertoast.showToast(msg: "Note deleted successfully");
                } else if (state is CommonErrorState) {
                  Fluttertoast.showToast(msg: state.message);
                } else {}
              },
            ),
            BlocListener<UpdateTodoCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonLoadingState) {
                  context.loaderOverlay.show();
                } else {
                  context.loaderOverlay.hide();
                }
                if (state is CommonSuccessState) {
                  Fluttertoast.showToast(msg: "Note Updated successfully");
                  Navigator.pop(context);
                } else if (state is CommonErrorState) {
                  Fluttertoast.showToast(msg: state.message);
                } else {}
              },
            ),
            BlocListener<AddTodoCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonLoadingState) {
                  context.loaderOverlay.show();
                } else {
                  context.loaderOverlay.hide();
                }
                if (state is CommonSuccessState) {
                  Fluttertoast.showToast(msg: "Note added successfully");
                  Navigator.pop(context);
                } else if (state is CommonErrorState) {
                  Fluttertoast.showToast(msg: state.message);
                } else {}
              },
            )
          ],
          child: FormBuilder(
            key: _formKey,
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              CustomTextfieldExample(
                name: "title",
                label: "Title",
                initialValue: widget.todo?.title,
                hintText: "Enter Title",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Title can not be empty";
                  } else {
                    return null;
                  }
                },
              ),
              CustomTextfieldExample(
                name: "desc",
                initialValue: widget.todo?.description,
                label: "Description",
                hintText: "Enter description",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Description can not be empty";
                  } else if (value.length < 6) {
                    return "The length of decsription must be greater than or equal to 6";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.saveAndValidate()) {
                    if (widget.todo != null) {
                      context.read<UpdateTodoCubit>().add(UpdateTodoEvent(
                          title: _formKey.currentState!.value["title"],
                          description: _formKey.currentState!.value["desc"],
                          id: widget.todo!.id));
                    } else {
                      context.read<AddTodoCubit>().add(AddTodoEvent(
                          title: _formKey.currentState!.value["title"],
                          description: _formKey.currentState!.value["desc"]));
                    }
                  }
                },
                child: Text(widget.todo != null ? "Update" : "Save"),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepOrange),
                    foregroundColor: MaterialStateProperty.all(Colors.white)),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
