import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mainapp/models/application_model.dart';
import 'package:mainapp/models/models.dart';
import 'package:mainapp/repositories/application_repository.dart';

part 'application_state.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  final ApplicationRepository _repository = ApplicationRepository();

  ApplicationCubit() : super(ApplicationInitial());

  Future<void> getApplications() async {
    try {
      emit(ApplicationLoading());
      final applications = await _repository.getApplications();
      emit(ApplicationLoaded(applications));
    } catch (e) {
      emit(ApplicationError(e.toString()));
    }
  }

  Future<void> getApplicationsByUserId(String userId) async {
    try {
      emit(ApplicationLoading());
      final applications = await _repository.getApplicationsByUserId(userId);
      emit(ApplicationLoaded(applications));
    } catch (e) {
      emit(ApplicationError(e.toString()));
    }
  }

  Future<void> getApplicationsByCompanyId(String companyId) async {
    try {
      emit(ApplicationLoading());
      final applications =
          await _repository.getApplicationsByCompanyId(companyId);
      emit(ApplicationLoaded(applications));
    } catch (e) {
      emit(ApplicationError(e.toString()));
    }
  }

  Future<void> createApplication(String userId, String companyId,
      String position, MasterDataModel masterData) async {
    try {
      emit(ApplicationLoading());
      await _repository.submitApplication(
          userId: userId,
          companyId: companyId,
          position: position,
          masterData: masterData.toMap());
      await getApplications();
    } catch (e) {
      emit(ApplicationError(e.toString()));
    }
  }

  Future<void> deleteApplication(String id) async {
    try {
      emit(ApplicationLoading());
      await _repository.deleteApplication(id);
      await getApplications();
    } catch (e) {
      emit(ApplicationError(e.toString()));
    }
  }

  Future<bool> hasUserApplied(String userId, String companyId) async {
    try {
      return await _repository.hasUserApplied(userId, companyId);
    } catch (e) {
      emit(ApplicationError(e.toString()));
      return false;
    }
  }
}
