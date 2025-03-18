part of 'form_cubit.dart';


sealed class FormState {}
final class FormInitial extends FormState {}

final class FormLoading extends FormState {}

final class FormCreate extends FormState {
  final FormModel form;
  FormCreate(this.form);
}

final class FormError extends FormState {
  final String error;
  FormError(this.error);
}