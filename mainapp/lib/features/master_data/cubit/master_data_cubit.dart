import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mainapp/features/master_data/repositories/master_data_repository.dart';
import 'package:mainapp/models/models.dart';

part 'master_data_state.dart';

class MasterDataCubit extends Cubit<MasterDataState> {
  final MasterDataRepository _repository = MasterDataRepository();

  MasterDataCubit() : super(MasterDataInitial());

  Future<void> submitMasterData(MasterDataModel masterData, String id) async {
    emit(MasterDataLoading());
    try {
      await _repository.submitMasterData(masterData, id);
      emit(MasterDataSuccess());
    } catch (e) {
      emit(MasterDataError(e.toString()));
    }
  }

  Future<void> getAllMasterData() async {
    try {
      emit(MasterDataLoading());
      final masterDataList = await _repository.getAllMasterData();
      emit(MasterDataListLoaded(masterDataList));
    } catch (e) {
      emit(MasterDataError(e.toString()));
    }
  }

  Future<void> getMasterDataById(String id) async {
    try {
      emit(MasterDataLoading());
      final masterData = await _repository.getMasterDataById(id);
      emit(MasterDataLoaded(masterData));
    } catch (e) {
      emit(MasterDataError(e.toString()));
    }
  }

  Future<void> approveMasterData(String id) async {
    emit(MasterDataLoading());
    try {
      final masterData = await _repository.approveMasterData(id);
      emit(MasterDataLoaded(masterData));
    } catch (e) {
      emit(MasterDataError(e.toString()));
    }
  }

  Future<void> rejectMasterData(String id) async {
    emit(MasterDataLoading());
    try {
      final masterData = await _repository.rejectMasterData(id);
      emit(MasterDataLoaded(masterData));
    } catch (e) {
      emit(MasterDataError(e.toString()));
    }
  }
}
