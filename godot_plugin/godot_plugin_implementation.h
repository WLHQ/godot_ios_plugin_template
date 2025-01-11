//
//  godot_plugin_implementation.h
//  godot_plugin
//
//  Created by Sergey Minakov on 14.08.2020.
//  Copyright © 2020 Godot. All rights reserved.
//

#ifndef godot_plugin_implementation_h
#define godot_plugin_implementation_h

#include "core/version.h"

// #if VERSION_MAJOR == 4
#include "core/object/class_db.h"
#else
#include "core/object.h"
#endif

class PluginExample : public Object {
    GDCLASS(PluginExample, Object);

    static void _bind_methods();

private:
    bool is_audio_cleanup_done = false;

public:
    void signal_audio_cleanup_done(); // GDScript signals cleanup completion.
    bool is_cleanup_complete() const; // Check if cleanup is done.
    void handle_termination();        // Handle termination logic.

    PluginExample();
    ~PluginExample();
};

#endif /* godot_plugin_implementation_h */
