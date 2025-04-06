import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mainapp/features/master_data/repositories/master_data_repository.dart';
import 'package:mainapp/models/models.dart';

part 'master_data_state.dart';

class MasterDataCubit extends Cubit<MasterDataState> {
  final MasterDataRepository _repository = MasterDataRepository();

  MasterDataCubit() : super(MasterDataInitial());

  Future<void> submitMasterData(MasterDataModel masterData) async {
    emit(MasterDataLoading());
    try {
      await _repository.submitMasterData(masterData);
      emit(MasterDataSuccess());
    } catch (e) {
      emit(MasterDataError(e.toString()));
    }
  }
}
