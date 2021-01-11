#import "JJLicenseWindow.h"

@implementation JJLicenseWindow

+(nullable NSWindow*)window {
	NSURL* url = [[NSBundle mainBundle] URLForResource:@"LICENSE" withExtension:@"txt"];
	if (url == nil) {
		NSLog(@"LICENSE.txt not found");
		return nil;
	}
	NSError* error = nil;
	NSString* license = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
	if (license == nil) {
		NSLog(@"LICENSE.txt error: %@", error);
		return nil;
	}
	
	NSTextField* label = [NSTextField wrappingLabelWithString:license];
	[label setTranslatesAutoresizingMaskIntoConstraints:NO];
	
	NSWindowStyleMask style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable;
	NSWindow* window = [[NSWindow alloc] initWithContentRect:NSMakeRect(0.0, 0.0, 630.0, 100.0) styleMask:style backing:NSBackingStoreBuffered defer:YES];
	[window setExcludedFromWindowsMenu:YES];
	[window setReleasedWhenClosed:NO]; // Necessary under ARC to avoid a crash.
	[window setTabbingMode:NSWindowTabbingModeDisallowed];
	[window setTitle:NSLocalizedString(@"License", nil)];
	
	NSView* contentView = [window contentView];
	[contentView addSubview:label];
	[NSLayoutConstraint activateConstraints:@[
											  [[label topAnchor] constraintEqualToAnchor:[contentView topAnchor] constant:15.0],
											  [[label bottomAnchor] constraintEqualToAnchor:[contentView bottomAnchor] constant:-15.0],
											  [[label leadingAnchor] constraintEqualToAnchor:[contentView leadingAnchor] constant:15.0],
											  [[label trailingAnchor] constraintEqualToAnchor:[contentView trailingAnchor] constant:-15.0],
											  [[label widthAnchor] constraintEqualToConstant:600.0]
											  ]];
	
	[window makeKeyAndOrderFront:nil];
	[window center]; // Wait until after makeKeyAndOrderFront so the window sizes properly first
	
	return window;
}

@end
