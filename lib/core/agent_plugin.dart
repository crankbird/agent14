/// Defines the common interface for agent plugins.
/// Plugins handle a set of verbal actions (verbs) with string inputs
/// and return string outputs.
enum AgentVerb {
  /// A general conversational action.
  converse,
}

/// Core interface that all agent plugins must implement.
abstract class AgentPlugin {
  /// A unique identifier for this plugin.
  String get id;

  /// The set of verbs (actions) this plugin supports.
  Set<AgentVerb> get supportedVerbs;

  /// Perform the given [verb] on the provided [input].
  ///
  /// Optional [context] can be supplied for additional metadata.
  Future<String> perform(
    AgentVerb verb,
    String input, {
    Map<String, dynamic>? context,
  });
}