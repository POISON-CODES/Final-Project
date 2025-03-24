import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mainapp/features/configurations/repository/configuration_repository.dart';
import 'package:mainapp/models/models.dart';

part 'configuration_state.dart';

class ConfigurationCubit extends Cubit<ConfigurationState> {
  ConfigurationCubit() : super(ConfigurationInitial());

  final configurationRepository = ConfigurationRepository();

  void createConfiguration({
    required String department,
    required String course,
    required String specialization,
    required String courseCode,
    required String hoi,
    required String facultyCoordinator,
    required String graduateStatus,
  }) async {
    try {
      emit(ConfigurationLoading());
      final ConfigurationModel? configuration =
          await configurationRepository.createConfiguration(
              department: department,
              course: course,
              specialization: specialization,
              courseCode: courseCode,
              hoi: hoi,
              facultyCoordinator: facultyCoordinator,
              graduateStatus: graduateStatus);
      emit(ConfigurationCreated(model: configuration!));
    } catch (e) {
      emit(ConfigurationError(e.toString()));
    }
  }

  void getAllConfigurations() async {
    try {
      emit(ConfigurationLoading());
      final List<ConfigurationModel> configurations =
          await configurationRepository.getAllConfigurations();
      emit(ConfigurationsLoaded(configurations: configurations));
    } catch (e) {
      emit(ConfigurationError(e.toString()));
    }
  }

  void updateConfiguration({
    required String id,
    required String department,
    required String course,
    required String specialization,
    required String courseCode,
    required String hoi,
    required String facultyCoordinator,
    required String graduateStatus,
  }) async {
    try {
      emit(ConfigurationLoading());
      final ConfigurationModel configuration =
          await configurationRepository.updateConfiguration(
              id: id,
              department: department,
              course: course,
              specialization: specialization,
              courseCode: courseCode,
              hoi: hoi,
              facultyCoordinator: facultyCoordinator,
              graduateStatus: graduateStatus);
      emit(ConfigurationEdit(model: configuration));
    } catch (e) {
      emit(ConfigurationError(e.toString()));
    }
  }

  void deleteConfiguration(String id) async {
    try {
      emit(ConfigurationLoading());
      await configurationRepository.deleteConfiguration(id);

      // After successful deletion, refresh the configuration list
      getAllConfigurations();
    } catch (e) {
      emit(ConfigurationError(e.toString()));
    }
  }
}
