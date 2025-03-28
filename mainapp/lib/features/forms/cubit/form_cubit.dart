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

  Future<Map<String, dynamic>> getForm(String formId) async {
    try {
      emit(FormLoading());
      final formData = await formRemoteRepository.getForm(formId);
      return formData;
    } catch (e) {
      emit(FormError(e.toString()));
      rethrow;
    }
  }

  Future<String> uploadFormFile(
    List<int> fileBytes,
    String fileName,
    String contentType,
  ) async {
    try {
      emit(FormLoading());
      final fileId = await formRemoteRepository.uploadFormFile(
        fileBytes,
        fileName,
        contentType,
      );
      return fileId;
    } catch (e) {
      emit(FormError(e.toString()));
      rethrow;
    }
  }

  Future<void> submitFormResponse(FormResponseModel response) async {
    try {
      emit(FormLoading());
      await formRemoteRepository.submitFormResponse(response);
    } catch (e) {
      emit(FormError(e.toString()));
      rethrow;
    }
  }
}
