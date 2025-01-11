#import "godot_plugin.h"
#import "godot_plugin_delegate.h"

GodotPluginDelegate *pluginDelegate;

void godot_plugin_init() {
    NSLog(@"init plugin");
    pluginDelegate = [[GodotPluginDelegate alloc] init];
    // Additional setup if needed
}

void godot_plugin_deinit() {
    NSLog(@"deinit plugin");
    pluginDelegate = nil;
}
