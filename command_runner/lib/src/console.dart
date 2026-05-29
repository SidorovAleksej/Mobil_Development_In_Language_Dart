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

  /// Изменяет цвет текста для всего будущего вывода (до сброса)
  /// ```dart
  /// print('hello'); // печатается цветом терминала по умолчанию
  /// print(ConsoleColor.red.enableForeground);
  /// print('hello'); // печатается красным цветом
  /// ```
  String get enableForeground => '$ansiEscapeLiteral[38;2;$r;$g;${b}m';

  /// Изменяет цвет фона для всего будущего вывода (до сброса)
  /// ```dart
  /// print('hello'); // печатается цветом терминала по умолчанию
  /// print(ConsoleColor.red.enableBackground);
  /// print('hello'); // печатается с красным цветом фона
  /// ```
  String get enableBackground => '$ansiEscapeLiteral[48;2;$r;$g;${b}m';

  /// Сбросить цвет текста и фона до настроек терминала по умолчанию
  static String get reset => '$ansiEscapeLiteral[0m';

  /// Устанавливает цвет текста для ввода
  String applyForeground(String text) {
    return '$ansiEscapeLiteral[38;2;$r;$g;${b}m$text$reset';
  }

  /// Устанавливает цвет фона, а затем сбрасывает изменение цвета
  String applyBackground(String text) {
    return '$ansiEscapeLiteral[48;2;$r;$g;${b}m$text$ansiEscapeLiteral[0m';
  } 
}

///Расширение для работы со строками
extension TextRenderUtils on String {
  String get errorText => ConsoleColor.red.applyForeground(this);
  String get instructionText => ConsoleColor.yellow.applyForeground(this);
  String get titleText => ConsoleColor.lightBlue.applyForeground(this);

  List<String> splitLinesByLength(int length) {
    final List<String> words = split(' ');
    final List<String> output = <String>[];
    final StringBuffer strBuffer = StringBuffer();
    for (int i = 0; i < words.length; i++) {
      final String word = words[i];
      if (strBuffer.length + word.length <= length) {
        strBuffer.write(word.trim());
        if (strBuffer.length + 1 <= length) {
          strBuffer.write(' ');
        }
      }
      // Если следующее слово превышает длину, начать новую строку
      if (i + 1 < words.length &&
          words[i + 1].length + strBuffer.length + 1 > length) {
        output.add(strBuffer.toString().trim());
        strBuffer.clear();
      }
    }

    // Добавить остатки
    output.add(strBuffer.toString().trim());
    return output;
  }
}

