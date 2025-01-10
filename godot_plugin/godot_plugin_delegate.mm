#import "godot_plugin_delegate.h"
#import <AVFoundation/AVFoundation.h>
#import "core/os/os.h"
#import "main/main.h"

#define OS_INSTANCE (OS::get_singleton())

@implementation GodotPluginDelegate

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"Application will terminate. Cleaning up audio.");

    // Deactivate AVAudioSession
    [[AVAudioSession sharedInstance] setActive:NO error:nil];

    // Notify Godot
    OS *os_instance = OS_INSTANCE;
    if (os_instance && os_instance->get_main_loop()) {
        os_instance->get_main_loop()->notification(MainLoop::NOTIFICATION_WM_ABOUT);
    }
}

@end
