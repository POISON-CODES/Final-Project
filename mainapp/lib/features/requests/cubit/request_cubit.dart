import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mainapp/features/requests/repositories/request_repository.dart';
import 'package:mainapp/models/models.dart';

abstract class RequestState {}

class RequestInitial extends RequestState {}

class RequestLoading extends RequestState {}

class RequestLoaded extends RequestState {
  final List<RequestModel> requests;

  RequestLoaded(this.requests);
}

class RequestError extends RequestState {
  final String message;

  RequestError(this.message);
}

class RequestCreated extends RequestState {
  final RequestModel request;

  RequestCreated(this.request);
}

class RequestUpdated extends RequestState {
  final RequestModel request;

  RequestUpdated(this.request);
}

class RequestDeleted extends RequestState {}

class RequestApproved extends RequestState {
  final RequestModel request;

  RequestApproved(this.request);
}

class RequestRejected extends RequestState {
  final RequestModel request;

  RequestRejected(this.request);
}

class RequestCubit extends Cubit<RequestState> {
  final RequestRepository _repository = RequestRepository();

  RequestCubit() : super(RequestInitial());

  Future<void> getRequests() async {
    try {
      emit(RequestLoading());
      final requests = await _repository.getRequests();
      emit(RequestLoaded(requests));
    } catch (e) {
      emit(RequestError(e.toString()));
    }
  }

  Future<void> getRequestById(String id) async {
    try {
      emit(RequestLoading());
      final request = await _repository.getRequestById(id);
      emit(RequestLoaded([request]));
    } catch (e) {
      emit(RequestError(e.toString()));
    }
  }

  Future<void> getRequestsByUserId(String userId) async {
    try {
      emit(RequestLoading());
      final requests = await _repository.getRequestsByUserId(userId);
      emit(RequestLoaded(requests));
    } catch (e) {
      emit(RequestError(e.toString()));
    }
  }

  Future<void> getRequestsByType(String type) async {
    try {
      emit(RequestLoading());
      final requests = await _repository.getRequestsByType(type);
      emit(RequestLoaded(requests));
    } catch (e) {
      emit(RequestError(e.toString()));
    }
  }

  Future<void> createRequest(RequestModel request, String id) async {
    try {
      emit(RequestLoading());
      final createdRequest = await _repository.createRequest(request, id);
      emit(RequestCreated(createdRequest));
    } catch (e) {
      emit(RequestError(e.toString()));
    }
  }

  Future<void> updateRequest(RequestModel request, String id) async {
    try {
      emit(RequestLoading());
      final updatedRequest =
          await _repository.updateRequest(id, request.toJson());
      emit(RequestUpdated(updatedRequest));
    } catch (e) {
      emit(RequestError(e.toString()));
    }
  }

  Future<void> deleteRequest(String id) async {
    try {
      emit(RequestLoading());
      await _repository.deleteRequest(id);
      emit(RequestDeleted());
    } catch (e) {
      emit(RequestError(e.toString()));
    }
  }

  Future<void> approveRequest(String id, String approvedBy) async {
    try {
      emit(RequestLoading());
      final approvedRequest = await _repository.approveRequest(id, approvedBy);
      emit(RequestApproved(approvedRequest));
    } catch (e) {
      emit(RequestError(e.toString()));
    }
  }

  Future<void> rejectRequest(
      String id, String rejectedBy, String reason) async {
    try {
      emit(RequestLoading());
      final rejectedRequest =
          await _repository.rejectRequest(id, rejectedBy, reason);
      emit(RequestRejected(rejectedRequest));
    } catch (e) {
      emit(RequestError(e.toString()));
    }
  }
}
