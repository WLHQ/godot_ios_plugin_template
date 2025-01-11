//
//  godot_plugin_delegate.mm
//  godot_plugin
//
//  Created by Sergey Minakov on 14.08.2020.
//

#import "godot_plugin_delegate.h"
#import <UIKit/UIKit.h>
#import "core/config/engine.h"

@implementation GodotPluginDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"GodotPluginDelegate: Application did finish launching.");
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"GodotPluginDelegate: Application will terminate.");
    // Add cleanup code here if needed
}

@end
