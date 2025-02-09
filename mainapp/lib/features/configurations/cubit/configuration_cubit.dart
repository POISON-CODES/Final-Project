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
}
