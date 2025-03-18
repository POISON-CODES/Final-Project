import 'package:flutter_bloc/flutter_bloc.dart';

part 'form_state.dart';

class FormCubit extends Cubit<FormState> {
  FormCubit() : super(FormInitial());

  final formRemoteRepository = FormRemoteRepository();

  void createForm({
    required String title,
    required Map<String, dynamic> fields,
  }) async {
    try {
      emit(FormLoading());
      await formRemoteRepository.createForm(
        
      );

      emit(FormCreate());
    } catch (e) {
      emit(FormError(e.toString()));
    }
  }
}
