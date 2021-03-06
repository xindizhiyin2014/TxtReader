//
//  RJAppDelegate.m
//  RJTxtReader
//
//  Created by joey on 12-8-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RJAppDelegate.h"

#import "RJBookListViewController.h"
#import "RJBookData.h"
#import "ReaderConstants.h"

@implementation RJAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self registerAppDefaults]; // Register various application settings defaults

    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    //yu mark 增加隐藏状态栏
    //[application setStatusBarHidden:YES]; // ahming-marks-page -> developing 状态栏的判断下次完善更新
    
    [[RJBookData sharedRJBookData] loadXml:@"book.xml"];

    RJBookListViewController *bookListViewController = [[[RJBookListViewController alloc] initWithNibName:@"RJBookListViewController" bundle:nil] autorelease];
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:bookListViewController] autorelease];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [[NSUserDefaults standardUserDefaults] synchronize]; // Save user defaults
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [[NSUserDefaults standardUserDefaults] synchronize]; // Save user defaults
}

- (void)registerAppDefaults
{
	NSNumber *hideStatusBar = [NSNumber numberWithBool:YES];
    
	NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
	NSString *version = [infoDictionary objectForKey:(NSString *)kCFBundleVersionKey];
    
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults]; // User defaults
    
	NSDictionary *defaults = [NSDictionary dictionaryWithObject:hideStatusBar forKey:kReaderSettingsHideStatusBar];
    
	[userDefaults registerDefaults:defaults]; [userDefaults synchronize]; // Save user defaults
    
	[userDefaults setObject:version forKey:kReaderSettingsAppVersion]; // App version    
    //NSLog(@"Version is: %@", version);
    
    //[userDefaults setInteger:0 forKey:kReaderSettingTextColorIndex]; // should not set here, default value will be set when first calling integerForKey
    
}


@end
