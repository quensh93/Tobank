import 'package:universal_io/io.dart';

class PersianText {
  final String file;
  final int line;
  final String text;

  PersianText(this.file, this.line, this.text);
}

bool isPersian(String text) {
  final persianPattern = RegExp(r'[\u0600-\u06FF]+');
  return persianPattern.hasMatch(text);
}

bool isIgnoredFile(String filePath) {
  return filePath.endsWith('app_localizations.dart') ||
      filePath.endsWith('app_localizations_fa.dart') ;
}

List<PersianText> findPersianTexts(String projectPath) {
  final persianTexts = <PersianText>[];
  final directory = Directory(projectPath);

  if (!directory.existsSync()) {
    print('مسیر پروژه معتبر نیست: $projectPath');
    return persianTexts;
  }

  final dartFiles = directory
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) =>
  f.path.endsWith('.dart') &&
      !isIgnoredFile(f.path.replaceAll('\\', '/'))); // Cross-platform

  for (final file in dartFiles) {
    try {
      final lines = file.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        final line = lines[i];
        final stringPattern = RegExp(r'''(["'])(.*?)(\1)'''); // کوتیشن دار
        final matches = stringPattern.allMatches(line);

        for (final match in matches) {
          final extracted = match.group(2);
          if (extracted != null && isPersian(extracted)) {
            persianTexts.add(PersianText(file.path, i + 1, extracted));
          }
        }
      }
    } catch (e) {
      print('خطا در خواندن فایل ${file.path}: $e');
    }
  }

  return persianTexts;
}

void main() {
  stdout.write('مسیر پروژه را وارد کنید: ');
  final inputPath = stdin.readLineSync();

  if (inputPath == null || inputPath.trim().isEmpty) {
    print('مسیر نامعتبر است.');
    return;
  }

  final persianTexts = findPersianTexts(inputPath.trim());

  if (persianTexts.isEmpty) {
    print('هیچ متن فارسی‌ای پیدا نشد.');
  } else {
    print('\nمتن‌های فارسی پیدا شده:');
    for (final pt in persianTexts) {
      print('فایل: ${pt.file}');
      print('خط: ${pt.line}');
      print('متن: ${pt.text}');
      print('-' * 40);
    }
  }
}
