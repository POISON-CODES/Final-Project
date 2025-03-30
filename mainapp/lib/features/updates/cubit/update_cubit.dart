import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mainapp/constants/constants.dart' show Priority;
import 'package:mainapp/features/updates/repository/update_repository.dart';
import 'package:mainapp/models/models.dart';

part 'update_state.dart';

class UpdateCubit extends Cubit<UpdateState> {
  UpdateCubit() : super(UpdateInitial());

  final updateRepository = UpdateRepository();

  void createUpdate({
    required String companyId,
    required String update,
    required Priority priority,
  }) async {
    try {
      emit(UpdateLoading());
      final UpdateModel? updateModel = await updateRepository.createUpdate(
        companyId: companyId,
        update: update,
        priority: priority,
      );
      emit(UpdateCreated(model: updateModel!));
    } catch (e) {
      emit(UpdateError(e.toString()));
    }
  }

  void getAllUpdates() async {
    try {
      emit(UpdateLoading());
      final List<UpdateModel> updates = await updateRepository.getAllUpdates();
      emit(UpdatesLoaded(updates: updates));
    } catch (e) {
      emit(UpdateError(e.toString()));
    }
  }

  void getUpdatesByCompany(String companyId) async {
    try {
      emit(UpdateLoading());
      final List<UpdateModel> updates =
          await updateRepository.getUpdatesByCompany(companyId);
      emit(UpdatesLoaded(updates: updates));
    } catch (e) {
      emit(UpdateError(e.toString()));
    }
  }

  void deleteUpdate(String id) async {
    try {
      emit(UpdateLoading());
      await updateRepository.deleteUpdate(id);
      getAllUpdates(); // Refresh the list after deletion
    } catch (e) {
      emit(UpdateError(e.toString()));
    }
  }
}
