import 'package:bloc/bloc.dart';
import 'package:e_triad/core/common/app/bloc_providers/user_provider.dart';
import 'package:e_triad/core/common/user_related_entities/user.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/users/domain/use_cases/get_user.dart';
import 'package:e_triad/src/users/domain/use_cases/update_user.dart';
import 'package:equatable/equatable.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({
    required GetUser getUser,
  
    required UpdateUser updateUser,
    required UserProvider userProvider,
  }) : _getUser = getUser,
     
       _updateUser = updateUser,
       _userProvider = userProvider,
       super(const InitialUserState());

  final GetUser _getUser;
  final UpdateUser _updateUser;
  final UserProvider _userProvider;

  Future<void> getUserById(String userId) async {
    emit(const StateGettingUserData());
    final result = await _getUser(userId);
    result.fold((failure) => emit(StateUserError(failure.errorMessage)), (
      user,
    ) {
      _userProvider.setUser(user);
      emit(StateFetchedUser(user));
    });
  }

  Future<void> updateUserData({
    required String userId,
    required DataMap updateData,
  }) async {
    emit(const StateUpdatingUserData());
    final result = await _updateUser(
      UpdateUserParams(userId: userId, updateData: updateData),
    );
    result.fold((failure) => emit(StateUserError(failure.errorMessage)), (
      user,
    ) {
      _userProvider.updateUser(user);
      emit(StateFetchedUser(user));
    });
  }

  
}
