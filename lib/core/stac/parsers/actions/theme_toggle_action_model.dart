class ThemeToggleActionModel {
  const ThemeToggleActionModel();

  factory ThemeToggleActionModel.fromJson(Map<String, dynamic> json) {
    return const ThemeToggleActionModel();
  }

  Map<String, dynamic> toJson() {
    return {'actionType': 'toggleTheme'};
  }
}
