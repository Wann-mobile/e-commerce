part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

final class InitialUserState extends UserState {
  const InitialUserState();
}

final class StateGettingUserData extends UserState {
  const StateGettingUserData();
}

final class StateUpdatingUserData extends UserState {
  const StateUpdatingUserData();
}

// Represents the state when user data is being successfully fetched
final class StateFetchedUser extends UserState {
  const StateFetchedUser(this.user);

  final User user;

  @override
  List<Object?> get props => [user];
}

// Represents the state when user data has an error
final class StateUserError extends UserState {
  const StateUserError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
