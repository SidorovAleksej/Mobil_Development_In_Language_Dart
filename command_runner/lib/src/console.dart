import 'dart:io';

const String ansiEscapeLiteral = '\x1B';

/// Разбивает строки по символам `\n`, затем записывает каждую строку в консоль.
/// Параметр [duration] определяет количество миллисекунд между выводом каждой строки.
Future<void> write(String text, {int duration = 50}) async {
  final List<String> lines = text.split('\n');
  for (final String l in lines) {
    await _delayedPrint('$l \n', duration: duration);
  }
}

/// Печатает построчно
Future<void> _delayedPrint(String text, {int duration = 0}) async {
  return Future<void>.delayed(
    Duration(milliseconds: duration),
    () => stdout.write(text),
  );
}

/// Цвета в формате RGB, используемые для стилизации ввода
///
/// Все цвета из фирменного руководства по стилю Dart
///
/// В качестве демонстрации включает только те цвета, которые нужны этой программе.
/// Если вы хотите использовать больше цветов, добавьте их сюда.
enum ConsoleColor {
  /// Небесно-голубой - #b8eafe
  lightBlue(184, 234, 254),

  /// Акцентные цвета из фирменных рекомендаций Dart
  /// Тёплый красный - #F25D50
  red(242, 93, 80),

  /// Светло-жёлтый - #F9F8C4
  yellow(249, 248, 196),

  /// Светло-серый, хорошо подходит для текста, #F8F9FA
  grey(240, 240, 240),

  ///
  white(255, 255, 255);

  const ConsoleColor(this.r, this.g, this.b);

  final int r;
  final int g;
  final int b;
}
