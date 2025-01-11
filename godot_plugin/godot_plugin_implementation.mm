//
//  godot_plugin_implementation.m
//  godot_plugin
//
//  Created by Sergey Minakov on 14.08.2020.
//  Copyright © 2020 Godot. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "core/config/project_settings.h"
#include "core/object/class_db.h"

#import "godot_plugin_implementation.h"

void PluginExample::_bind_methods() {
    ClassDB::bind_method(D_METHOD("signal_audio_cleanup_done"), &PluginExample::signal_audio_cleanup_done);
    ClassDB::bind_method(D_METHOD("is_cleanup_complete"), &PluginExample::is_cleanup_complete);
}

void PluginExample::signal_audio_cleanup_done() {
    is_audio_cleanup_done = true;
    NSLog(@"Audio cleanup completed.");
}

bool PluginExample::is_cleanup_complete() const {
    return is_audio_cleanup_done;
}

void PluginExample::handle_termination() {
    NSLog(@"PluginExample: Handling app termination...");
    if (!is_cleanup_complete()) {
        NSLog(@"Waiting for audio cleanup...");
        const int max_wait_time = 5; // Maximum wait time in seconds.
        int waited = 0;
        while (!is_cleanup_complete() && waited < max_wait_time) {
            sleep(1); // Sleep for 1 second.
            waited++;
        }
        if (!is_cleanup_complete()) {
            NSLog(@"Audio cleanup not completed within the timeout!");
        } else {
            NSLog(@"Audio cleanup completed successfully.");
        }
    }
}
