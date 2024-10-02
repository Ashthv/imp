abstract class PluginLifecycle {
  Future<void> init();
  Future<void> release();
}

typedef Plugin = PluginLifecycle;

