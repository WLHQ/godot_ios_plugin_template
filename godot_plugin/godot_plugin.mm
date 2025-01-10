//
//  godot_plugin.m
//  godot_plugin
//
//  Created by Sergey Minakov on 14.08.2020.
//  Copyright © 2020 Godot. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "godot_plugin.h"
#import "godot_plugin_implementation.h"
#import "godot_plugin_delegate.h"  // Import your custom iOS delegate

#import "core/config/engine.h"

PluginExample *plugin;
GodotPluginDelegate *pluginDelegate;

void godot_plugin_init() {
    NSLog(@"init plugin");

    // Create and register the PluginExample instance
    plugin = memnew(PluginExample);
    Engine::get_singleton()->add_singleton(Engine::Singleton("PluginExample", plugin));

    // Initialize the iOS delegate
    pluginDelegate = [[GodotPluginDelegate alloc] init];
    [[UIApplication sharedApplication] setDelegate:pluginDelegate];
}

void godot_plugin_deinit() {
    NSLog(@"deinit plugin");

    // Free the PluginExample instance
    if (plugin) {
        memdelete(plugin);
    }

    // Clean up the delegate
    pluginDelegate = nil;
}