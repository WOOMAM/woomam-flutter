import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woomam/model/user.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  /// constructor
  UserBloc() : super(UserEmpty());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is SignInEvent) {
      yield* _mapSignInEventToState(event);
    } else if (event is SignOutEvent) {
      yield* _mapSignOutEventToState(event);
    } else if (event is GetInformationEvent) {
      yield* _mapGetInformationEventToState(event);
    }
  }

  /// [SignInEvent]: handles current User's sign-in
  Stream<UserState> _mapSignInEventToState(SignInEvent event) async* {
    try {
      // TODO: make logic
      User temp = User(
          userName: 'sample',
          phoneNumber: 'sample',
          userUID: 'sample',
          writtenDate: DateTime.parse('2021-08-15'));
      yield UserLoaded(user: temp);
    } catch (e) {
      yield UserError(msg: e.toString());
    }
  }

  /// [SignOutEvent]: handles current User's sign-out
  Stream<UserState> _mapSignOutEventToState(SignOutEvent event) async* {
    try {
      yield UserEmpty();
    } catch (e) {
      yield UserError(msg: e.toString());
    }
  }

  /// [GetInformationEvent]: handles loading data with current User's cache
  /// which will be saved in Firebase cache
  Stream<UserState> _mapGetInformationEventToState(
      GetInformationEvent event) async* {
    try {
      // TODO: make logic
      User temp = User(
          userName: 'sample',
          phoneNumber: 'sample',
          userUID: 'sample',
          writtenDate: DateTime.parse('2021-08-15'));
      yield UserLoaded(user: temp);
    } catch (e) {
      yield UserError(msg: e.toString());
    }
  }
}
