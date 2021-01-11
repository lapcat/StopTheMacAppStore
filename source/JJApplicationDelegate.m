#import "JJApplicationDelegate.h"

#import "JJLicenseWindow.h"
#import "JJMainMenu.h"
#import "JJMainWindow.h"

NSString* JJApplicationName;

@implementation JJApplicationDelegate {
	BOOL _didOpenURLs;
	NSUInteger _urlCount;
	NSWindow* _licenseWindow;
	NSWindow* _mainWindow;
}

#pragma mark Private

-(void)terminateIfNecessary {
	NSArray<NSWindow*>* windows = [NSApp windows];
	for (NSWindow* window in windows) {
		if ([window isVisible])
			return; // Don't terminate if there are visible windows
	}
	[NSApp terminate:nil];
}

-(void)decrementURLCount {
	--_urlCount;
	if (_urlCount > 0)
		return;
	
	[self performSelector:@selector(terminateIfNecessary) withObject:nil afterDelay:2.0];
}

-(void)openMacAppStoreURL:(nonnull NSURL*)url {
	[[NSWorkspace sharedWorkspace] openURLs:@[url] withAppBundleIdentifier:@"com.apple.AppStore" options:NSWorkspaceLaunchAsync additionalEventParamDescriptor:nil launchIdentifiers:nil];
}

#pragma mark NSApplicationDelegate

-(void)applicationWillFinishLaunching:(nonnull NSNotification *)notification {
	JJApplicationName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
	if (JJApplicationName == nil) {
		NSLog(@"CFBundleName nil!");
		JJApplicationName = @"Stop The Mac App Store";
	}
	[JJMainMenu populateMainMenu];
}

-(void)applicationDidFinishLaunching:(nonnull NSNotification*)notification {
	if (_didOpenURLs)
		return;
	
	CFStringRef bundleID = CFSTR("com.lapcatsoftware.StopTheMacAppStore");
	NSArray<NSString*>* schemes = @[@"itms-apps", @"itms-appss", @"macappstore", @"macappstores"];
	OSStatus status;
	for (NSString* scheme in schemes) {
		status = LSSetDefaultHandlerForURLScheme((__bridge CFStringRef _Nonnull)scheme, bundleID);
		if (status != noErr)
			NSLog(@"LSSetDefaultHandlerForURLScheme %@ failed: %i", scheme, status);
	}
	
	[self openMainWindow:nil];
}

-(void)applicationDidResignActive:(nonnull NSNotification*)notification {
	if (_urlCount > 0)
		return;
	
	[self terminateIfNecessary];
}

-(void)application:(nonnull NSApplication*)application openURLs:(nonnull NSArray<NSURL*>*)urls {
	_didOpenURLs = YES;
	_urlCount += [urls count];
	for (NSURL* url in urls) {
		[self openMacAppStoreURL:url];
		[self decrementURLCount];
	}
}

#pragma mark JJApplicationDelegate

-(void)windowWillClose:(nonnull NSNotification*)notification {
	id object = [notification object];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:[notification name] object:object];
	if (object == _licenseWindow)
		_licenseWindow = nil;
	else if (object == _mainWindow)
		_mainWindow = nil;
}

-(void)openLicense:(nullable id)sender {
	if (_licenseWindow != nil) {
		[_licenseWindow makeKeyAndOrderFront:self];
	} else {
		_licenseWindow = [JJLicenseWindow window];
		if (_licenseWindow != nil)
			[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowWillClose:) name:NSWindowWillCloseNotification object:_licenseWindow];
	}
}

-(void)openMacAppStore:(id)sender {
	NSURL* url = [NSURL URLWithString:@"macappstore://itunes.apple.com/app/stopthemadness/id1376402589"];
	if (url != nil)
		[self openMacAppStoreURL:url];
	else
		NSLog(@"MAS URL nil!");
}

-(void)openMainWindow:(nullable id)sender {
	if (_mainWindow != nil) {
		[_mainWindow makeKeyAndOrderFront:self];
	} else {
		_mainWindow = [JJMainWindow window];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowWillClose:) name:NSWindowWillCloseNotification object:_mainWindow];
	}
}

-(void)openWebSite:(nullable id)sender {
	NSURL* url = [NSURL URLWithString:@"https://github.com/lapcat/StopTheMacAppStore"];
	if (url != nil)
		[[NSWorkspace sharedWorkspace] openURL:url];
	else
		NSLog(@"Support URL nil!");
}

@end
