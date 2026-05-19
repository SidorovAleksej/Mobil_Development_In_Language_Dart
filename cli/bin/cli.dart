import 'package:cli/cli.dart' as cli;

const version = '0.0.1'; // Add this line

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Hello, Dart!');
  } else if (arguments.first == 'version') {
    print('Dartpedia CLI version $version');
  }
}

