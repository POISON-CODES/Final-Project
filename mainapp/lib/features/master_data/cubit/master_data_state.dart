part of 'master_data_cubit.dart';

abstract class MasterDataState {}

class MasterDataInitial extends MasterDataState {}

class MasterDataLoading extends MasterDataState {}

class MasterDataSuccess extends MasterDataState {}

class MasterDataError extends MasterDataState {
  final String message;

  MasterDataError(this.message);
}
