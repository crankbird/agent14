import 'package:flutter_test/flutter_test.dart';
import 'package:agent_wrapper/core/agent_plugin.dart';

/// A dummy plugin that echoes back the input string.
class DummyPlugin implements AgentPlugin {
  @override
  String get id => 'dummy';

  @override
  Set<AgentVerb> get supportedVerbs => {AgentVerb.converse};

  @override
  Future<String> perform(
    AgentVerb verb,
    String input, {
    Map<String, dynamic>? context,
  }) async {
    // Simply echo back the input for testing.
    return 'echo: $input';
  }
}

void main() {
  group('AgentPlugin interface', () {
    test('DummyPlugin id and supportedVerbs', () {
      final plugin = DummyPlugin();
      expect(plugin.id, equals('dummy'));
      expect(plugin.supportedVerbs, contains(AgentVerb.converse));
    });

    test('DummyPlugin echoes input', () async {
      final plugin = DummyPlugin();
      final response = await plugin.perform(AgentVerb.converse, 'hello');
      expect(response, equals('echo: hello'));
    });
  });
}