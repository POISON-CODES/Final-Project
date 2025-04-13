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
    String? description,
    required String floatBy,
    required List<String> eligibleBatchesIds,
    required String formId,
    List<String> jdFiles = const [],
    DateTime? deadline,
    DateTime? floatTime,
    List<String>? updates,
    List<String>? students,
  }) async {
    try {
      emit(CompanyLoading());
      final CompanyModel? company = await companyRepository.createCompany(
          name: name,
          positions: positions,
          ctc: ctc,
          location: location,
          description: description,
          floatBy: floatBy,
          eligibleBatchesIds: eligibleBatchesIds,
          formId: formId,
          jdFiles: jdFiles,
          deadline: deadline,
          floatTime: DateTime.now(),
          updates: updates,
          students: students);
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
    String? description,
    required String floatBy,
    required List<String> eligibleBatchesIds,
    required String formId,
    List<String>? jdFiles,
    DateTime? deadline,
    DateTime? floatTime,
    List<String>? updates,
    List<String>? students,
  }) async {
    try {
      emit(CompanyLoading());
      final CompanyModel company = await companyRepository.updateCompany(
          id: id,
          name: name,
          positions: positions,
          ctc: ctc,
          location: location,
          description: description,
          floatBy: floatBy,
          eligibleBatchesIds: eligibleBatchesIds,
          formId: formId,
          jdFiles: jdFiles,
          deadline: deadline,
          floatTime: floatTime,
          updates: updates,
          students: students);
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

  void getActiveCompanies() async {
    try {
      emit(CompanyLoading());
      final List<CompanyModel> companies =
          await companyRepository.getActiveCompanies();
      emit(CompaniesLoaded(companies: companies));
    } catch (e) {
      emit(CompanyError(e.toString()));
    }
  }
}
