/// Login Action Model
///
/// A custom STAC action that handles login authentication.
/// This action validates credentials and navigates to home on success.
class StacLoginAction {
  const StacLoginAction();

  factory StacLoginAction.fromJson(Map<String, dynamic> json) {
    return const StacLoginAction();
  }

  Map<String, dynamic> toJson() {
    return {
      'actionType': 'loginAction',
    };
  }
}

