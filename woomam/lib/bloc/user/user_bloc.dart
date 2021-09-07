import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woomam/model/user.dart';
import 'package:woomam/respository/repository.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  /// constructor
  UserBloc({required this.userRepository}) : super(UserEmpty());

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
      /// check current state
      if (state is UserEmpty) {
        /// create object
        final newUser = User(
            userName: 'newbie',
            phoneNumber: event.phoneNumber,
            userUID: event.uuid,
            point: 0);

        /// returns `boolean` when the request was successful
        final signInResponse = await userRepository.signInUser(
            userUID: event.uuid, phoneNumber: event.phoneNumber);

        /// if it fails ask server for sign-up
        if (signInResponse.runtimeType != bool) {
          final signUpResponse =
              await userRepository.signUpuser(applicant: newUser);

          /// check if it succeed
          if (signUpResponse.runtimeType == User) {
            /// resend data for sign-up
            final reSignInResponse = await userRepository.signInUser(
                userUID: event.uuid, phoneNumber: event.phoneNumber);
            if (reSignInResponse.substring(0, 5) != 'ERROR') {
              yield UserLoaded(user: newUser);
            } else {
              yield UserError(msg: 're-sign-in response was dead');
            }
          }

          /// sign-up failed
          else {
            yield UserError(msg: 'sign-up failed');
          }
        } else {
          yield UserLoaded(user: newUser);
        }
      }
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
      // TODO: make logic - currently there's no API
      User temp = User(
        userName: 'sample',
        phoneNumber: 'sample',
        userUID: 'sample',
        point: 0,
      );
      yield UserLoaded(user: temp);
    } catch (e) {
      yield UserError(msg: e.toString());
    }
  }
}
