//
//  godot_plugin.m
//  godot_plugin
//
//  Created by Sergey Minakov on 14.08.2020.
//  Copyright © 2020 Godot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "godot_plugin.h"

// Define a termination handler
static void register_lifecycle_hooks();

void godot_plugin_init() {
    NSLog(@"Init plugin");

    plugin = memnew(PluginExample);
    Engine::get_singleton()->add_singleton(Engine::Singleton("PluginExample", plugin));

    // Register lifecycle hooks
    register_lifecycle_hooks();
}

void godot_plugin_deinit() {
    NSLog(@"Deinit plugin");

    if (plugin) {
        memdelete(plugin);
    }
}

static void handle_termination(NSNotification *notification) {
    NSLog(@"App is terminating...");
    if (plugin) {
        plugin->handle_termination(); // Call your plugin's termination handler.
    }

    // Notify Godot's MainLoop about termination (optional)
    if (OS::get_singleton()->get_main_loop()) {
        OS::get_singleton()->get_main_loop()->notification(MainLoop::NOTIFICATION_WM_CLOSE_REQUEST);
    }
}

static void register_lifecycle_hooks() {
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillTerminateNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *notification) {
        handle_termination(notification);
    }];
}
