class AppState {}

class AppLoading extends AppState {}

class AppLoaded extends AppState {}

class AppError extends AppState {
  final String message;

  AppError({
    required this.message,
  });
}
