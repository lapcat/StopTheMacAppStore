#import "JJMainWindow.h"

@implementation JJMainWindow

+(nonnull NSWindow*)window {
	NSWindowStyleMask style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable;
	NSWindow* window = [[NSWindow alloc] initWithContentRect:NSMakeRect(0.0, 0.0, 480.0, 300.0) styleMask:style backing:NSBackingStoreBuffered defer:YES];
	[window setExcludedFromWindowsMenu:YES];
	[window setReleasedWhenClosed:NO]; // Necessary under ARC to avoid a crash.
	[window setTabbingMode:NSWindowTabbingModeDisallowed];
	[window setTitle:JJApplicationName];
	NSView* contentView = [window contentView];
	
	NSString* intro = NSLocalizedString(@"Stop The Mac App Store registers itself as the default handler for Mac App Store URLs instead of the App Store app.\n\nIf you allow Safari to open a Mac App Store URL in Stop The Mac App Store, the app's page will then open in App Store. This lets you stop App Store from automatically opening.\n\nYou don't need to keep Stop The Mac App Store running. Safari will automatically launch Stop The Mac App Store, and Stop The Mac App Store will automatically terminate itself.\n\nStop The Mac App Store is free and open source. To support the developer, please consider buying the Safari extension StopTheMadness Pro in the Mac App Store. Thanks!", nil);
	NSTextField* label = [NSTextField wrappingLabelWithString:intro];
	[label setTranslatesAutoresizingMaskIntoConstraints:NO];
	[contentView addSubview:label];
	
	NSButton* buyButton = [[NSButton alloc] init];
	[buyButton setButtonType:NSButtonTypeMomentaryLight];
	[buyButton setBezelStyle:NSBezelStyleRounded];
	[buyButton setTitle:NSLocalizedString(@"Mac App Store", nil)];
	[buyButton setAction:@selector(openMacAppStore:)];
	[buyButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	[contentView addSubview:buyButton];
	[window setDefaultButtonCell:[buyButton cell]];
	[window setInitialFirstResponder:buyButton];
	
	[NSLayoutConstraint activateConstraints:@[
											  [[label topAnchor] constraintEqualToAnchor:[contentView topAnchor] constant:15.0],
											  [[label leadingAnchor] constraintEqualToAnchor:[contentView leadingAnchor] constant:15.0],
											  [[label trailingAnchor] constraintEqualToAnchor:[contentView trailingAnchor] constant:-15.0],
											  [[label widthAnchor] constraintEqualToConstant:450.0],
											  [[buyButton topAnchor] constraintEqualToAnchor:[label bottomAnchor] constant:15.0],
											  [[buyButton bottomAnchor] constraintEqualToAnchor:[contentView bottomAnchor] constant:-15.0],
											  [[buyButton trailingAnchor] constraintEqualToAnchor:[contentView trailingAnchor] constant:-15.0]
										  ]];
	
	[window makeKeyAndOrderFront:nil];
	[window center]; // Wait until after makeKeyAndOrderFront so the window sizes properly first
	
	return window;
}

@end
