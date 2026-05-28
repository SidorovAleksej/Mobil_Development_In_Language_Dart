import 'dart:async';

import 'arguments.dart';

// Печатает использование программы и аргументов.
//
// Если передан аргумент — команда, то печатает использование только этой команды,
// включая её опции и другие детали.
// Если установлен флаг 'verbose', то печатает опции и детали для всех команд.
//
// Эта команда не добавляется автоматически в экземпляры CommandRunner.
// Пользователи пакетов должны добавить её сами с помощью [CommandRunner.addCommand]
// или создать свою собственную команду для печати справки.

class HelpCommand extends Command {
  HelpCommand() {
    addFlag(
      'verbose',
      abbr: 'v',
      help: 'When true, this command will print each command and its options.',
    );
    addOption(
      'command',
      abbr: 'c',
      help:
          "When a command is passed as an argument, prints only that command's verbose usage.",
    );
  }
  @override
  String get name => 'help';

  @override
  String get description => 'Prints usage information to the command line.';

  @override
  String? get help => 'Prints this usage information';

  @override
  FutureOr<Object?> run(ArgResults args) async {
    var usage = runner.usage;
    for (var command in runner.commands) {
      usage += '\n ${command.usage}';
    }

    return usage;
  }
}
