part of 'master_data_cubit.dart';

abstract class MasterDataState {}

class MasterDataInitial extends MasterDataState {}

class MasterDataLoading extends MasterDataState {}

class MasterDataSuccess extends MasterDataState {}

class MasterDataLoaded extends MasterDataState {
  final MasterDataModel masterData;

  MasterDataLoaded(this.masterData);
}

class MasterDataListLoaded extends MasterDataState {
  final List<MasterDataModel> masterDataList;

  MasterDataListLoaded(this.masterDataList);
}

class MasterDataError extends MasterDataState {
  final String message;

  MasterDataError(this.message);
}
