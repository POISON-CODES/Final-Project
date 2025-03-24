part of 'company_cubit.dart';

sealed class CompanyState {}

class CompanyInitial extends CompanyState {}

class CompanyLoading extends CompanyState {}

class CompanyCreated extends CompanyState {
  final CompanyModel model;

  CompanyCreated({required this.model});
}

class CompanyEdit extends CompanyState {
  final CompanyModel model;

  CompanyEdit({required this.model});
}

class CompaniesLoaded extends CompanyState {
  final List<CompanyModel> companies;

  CompaniesLoaded({required this.companies});
}

class CompanyError extends CompanyState {
  final String error;

  CompanyError(this.error);
}
