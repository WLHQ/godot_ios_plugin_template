#import "godot_plugin_delegate.h"
#import "os_ios.h"

@implementation GodotPluginDelegate

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"Application will terminate. Cleaning up audio.");
    // Deactivate the AVAudioSession to stop playback
    [[AVAudioSession sharedInstance] setActive:NO error:nil];

    // Notify the Godot engine if it is still running
    if (OS_IOS::get_singleton() && OS_IOS::get_singleton()->get_main_loop()) {
        OS_IOS::get_singleton()->get_main_loop()->notification(MainLoop::NOTIFICATION_WM_QUIT_REQUEST);
    }
}

@end
