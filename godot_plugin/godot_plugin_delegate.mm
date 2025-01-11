#import "godot_plugin_delegate.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "core/os/os.h"
#import "main/main.h"

@implementation GodotPluginDelegate {
    id<UIApplicationDelegate> originalDelegate;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // Save the current app delegate for forwarding unhandled calls
        originalDelegate = [UIApplication sharedApplication].delegate;
    }
    return self;
}

// Implement the required `window` property if needed
- (UIWindow *)window {
    if ([originalDelegate respondsToSelector:@selector(window)]) {
        return [originalDelegate window];
    }
    return nil;
}

// Handle application termination
- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"Application will terminate. Cleaning up audio.");

    // Deactivate AVAudioSession
    [[AVAudioSession sharedInstance] setActive:NO error:nil];

    // Notify Godot's main loop if available
    OS *os_instance = OS::get_singleton();
    if (os_instance && os_instance->get_main_loop()) {
        os_instance->get_main_loop()->notification(MainLoop::NOTIFICATION_WM_ABOUT); // Replace with a suitable notification
    }

    // Call the original delegate's method if it exists
    if ([originalDelegate respondsToSelector:@selector(applicationWillTerminate:)]) {
        [originalDelegate applicationWillTerminate:application];
    }
}

// Forward unhandled delegate calls to the original delegate
- (BOOL)respondsToSelector:(SEL)aSelector {
    return [super respondsToSelector:aSelector] || [originalDelegate respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([originalDelegate respondsToSelector:aSelector]) {
        return originalDelegate;
    }
    return [super forwardingTargetForSelector:aSelector];
}

@end
