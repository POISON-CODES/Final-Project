import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mainapp/features/companies/repository/company_remote_repository.dart';
import 'package:mainapp/models/models.dart';

part 'company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit() : super(CompanyInitial());

  final companyRepository = CompanyRepository();

  void createCompany({
    required String name,
    required List<String> positions,
    required List<String> ctc,
    String? location,
    required String provider,
    required List<String> eligibleBatchesIds,
    required String formId,
    List<String> jdFiles = const [],
  }) async {
    try {
      emit(CompanyLoading());
      final CompanyModel? company = await companyRepository.createCompany(
          name: name,
          positions: positions,
          ctc: ctc,
          location: location,
          provider: provider,
          eligibleBatchesIds: eligibleBatchesIds,
          formId: formId,
          jdFiles: jdFiles);
      emit(CompanyCreated(model: company!));
    } catch (e) {
      emit(CompanyError(e.toString()));
    }
  }

  void getAllCompanies() async {
    try {
      emit(CompanyLoading());
      final List<CompanyModel> companies =
          await companyRepository.getAllCompanies();
      emit(CompaniesLoaded(companies: companies));
    } catch (e) {
      emit(CompanyError(e.toString()));
    }
  }

  void updateCompany({
    required String id,
    required String name,
    required List<String> positions,
    required List<String> ctc,
    String? location,
    required String provider,
    required List<String> eligibleBatchesIds,
    required String formId,
    List<String>? jdFiles,
  }) async {
    try {
      emit(CompanyLoading());
      final CompanyModel company = await companyRepository.updateCompany(
          id: id,
          name: name,
          positions: positions,
          ctc: ctc,
          location: location,
          provider: provider,
          eligibleBatchesIds: eligibleBatchesIds,
          formId: formId,
          jdFiles: jdFiles);
      emit(CompanyEdit(model: company));
    } catch (e) {
      emit(CompanyError(e.toString()));
    }
  }

  void deleteCompany(String id) async {
    try {
      emit(CompanyLoading());
      await companyRepository.deleteCompany(id);

      // After successful deletion, refresh the company list
      getAllCompanies();
    } catch (e) {
      emit(CompanyError(e.toString()));
    }
  }

  // Method to upload a JD file and add it to a company's JD files list
  Future<String> uploadJDFile(
    Uint8List fileBytes,
    String fileName,
    String contentType,
  ) async {
    try {
      emit(CompanyLoading());

      final String fileId = await companyRepository.uploadJDFile(
          fileBytes, fileName, contentType);

      return fileId;
    } catch (e) {
      emit(CompanyError(e.toString()));
      throw e.toString();
    }
  }
}
