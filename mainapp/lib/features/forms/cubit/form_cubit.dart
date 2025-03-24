import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mainapp/features/forms/repository/form_remote_repository.dart';
import 'package:mainapp/models/models.dart';

part 'form_state.dart';

class FormCubit extends Cubit<FormState> {
  FormCubit() : super(FormInitial());

  final formRemoteRepository = FormRemoteRepository();

  void createForm({
    required String title,
    required String fields,
  }) async {
    try {
      emit(FormLoading());
      FormModel form = await formRemoteRepository.createForm(
        title: title,
        fields: fields,
      );

      emit(FormCreate(form));
    } catch (e) {
      emit(FormError(e.toString()));
    }
  }

  void getAllForms() async {
    try {
      emit(FormLoading());
      List<FormModel> forms = await formRemoteRepository.getAllForms();
      emit(FormsList(forms));
    } catch (e) {
      emit(FormError(e.toString()));
    }
  }
}
