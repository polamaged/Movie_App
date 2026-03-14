part of 'editprofile_cubit.dart';

abstract class EditprofileState extends Equatable {
  const EditprofileState();

  @override
  List<Object> get props => [];
}

class EditprofileInitial extends EditprofileState {}

class EditprofileLoading extends EditprofileState {}
class ProfileUpdated extends EditprofileState {
  final UserModels user;

  ProfileUpdated(this.user);

  @override
  List<Object> get props => [user];
}

class EditprofileFailure extends EditprofileState {
  final String errMessage;  
  EditprofileFailure({required this.errMessage});
}
