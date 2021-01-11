#import "JJMainMenu.h"

// Apparently these aren't declared anywhere
@interface NSObject(JJMainMenu)
-(void)redo:(nullable id)sender;
-(void)undo:(nullable id)sender;
@end

@implementation JJMainMenu

+(void)populateMainMenu {
	NSMenu* mainMenu = [[NSMenu alloc] initWithTitle:@"Main Menu"];
	
	NSMenuItem* menuItem;
	NSMenu* submenu;
	
	// The titles of the menu items are for identification purposes only and shouldn't be localized.
	// The strings in the menu bar come from the submenu titles,
	// except for the application menu, whose title is ignored at runtime.
	menuItem = [mainMenu addItemWithTitle:@"Application" action:NULL keyEquivalent:@""];
	submenu = [[NSMenu alloc] initWithTitle:@"Application"];
	[self populateApplicationMenu:submenu];
	[mainMenu setSubmenu:submenu forItem:menuItem];
	
	menuItem = [mainMenu addItemWithTitle:@"Edit" action:NULL keyEquivalent:@""];
	submenu = [[NSMenu alloc] initWithTitle:NSLocalizedString(@"Edit", @"The Edit menu")];
	[self populateEditMenu:submenu];
	[mainMenu setSubmenu:submenu forItem:menuItem];
	
	menuItem = [mainMenu addItemWithTitle:@"Window" action:NULL keyEquivalent:@""];
	submenu = [[NSMenu alloc] initWithTitle:NSLocalizedString(@"Window", @"The Window menu")];
	[self populateWindowMenu:submenu];
	[mainMenu setSubmenu:submenu forItem:menuItem];
	[NSApp setWindowsMenu:submenu];
	
	menuItem = [mainMenu addItemWithTitle:@"Help" action:NULL keyEquivalent:@""];
	submenu = [[NSMenu alloc] initWithTitle:NSLocalizedString(@"Help", @"The Help menu")];
	[self populateHelpMenu:submenu];
	[mainMenu setSubmenu:submenu forItem:menuItem];
	
	[NSApp setMainMenu:mainMenu];
}

+(void)populateApplicationMenu:(NSMenu*)menu {
	NSMenuItem* menuItem;
	
	menuItem = [menu addItemWithTitle:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"About", nil), JJApplicationName]
							   action:@selector(orderFrontStandardAboutPanel:)
						keyEquivalent:@""];
	[menuItem setTarget:NSApp];
	
	[menu addItem:[NSMenuItem separatorItem]];
	
	menuItem = [menu addItemWithTitle:NSLocalizedString(@"Services", nil)
							   action:NULL
						keyEquivalent:@""];
	NSMenu* servicesMenu = [[NSMenu alloc] initWithTitle:@"Services"];
	[menu setSubmenu:servicesMenu forItem:menuItem];
	[NSApp setServicesMenu:servicesMenu];
	
	[menu addItem:[NSMenuItem separatorItem]];
	
	menuItem = [menu addItemWithTitle:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Hide", nil), JJApplicationName]
							   action:@selector(hide:)
						keyEquivalent:@"h"];
	[menuItem setTarget:NSApp];
	
	menuItem = [menu addItemWithTitle:NSLocalizedString(@"Hide Others", nil)
							   action:@selector(hideOtherApplications:)
						keyEquivalent:@"h"];
	[menuItem setKeyEquivalentModifierMask:NSEventModifierFlagCommand | NSEventModifierFlagOption];
	[menuItem setTarget:NSApp];
	
	menuItem = [menu addItemWithTitle:NSLocalizedString(@"Show All", nil)
							   action:@selector(unhideAllApplications:)
						keyEquivalent:@""];
	[menuItem setTarget:NSApp];
	
	[menu addItem:[NSMenuItem separatorItem]];
	
	menuItem = [menu addItemWithTitle:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Quit", nil), JJApplicationName]
							   action:@selector(terminate:)
						keyEquivalent:@"q"];
	[menuItem setTarget:NSApp];
}

+(void)populateEditMenu:(NSMenu*)menu {
	NSMenuItem* menuItem;
	
	[menu addItemWithTitle:NSLocalizedString(@"Undo", nil)
					action:@selector(undo:)
			 keyEquivalent:@"z"];
	
	[menu addItemWithTitle:NSLocalizedString(@"Redo", nil)
					action:@selector(redo:)
			 keyEquivalent:@"Z"];
	
	[menu addItem:[NSMenuItem separatorItem]];
	
	[menu addItemWithTitle:NSLocalizedString(@"Cut", nil)
					action:@selector(cut:)
			 keyEquivalent:@"x"];
	
	[menu addItemWithTitle:NSLocalizedString(@"Copy", nil)
					action:@selector(copy:)
			 keyEquivalent:@"c"];
	
	[menu addItemWithTitle:NSLocalizedString(@"Paste", nil)
					action:@selector(paste:)
			 keyEquivalent:@"v"];
	
	menuItem = [menu addItemWithTitle:NSLocalizedString(@"Paste and Match Style", nil)
							   action:@selector(pasteAsPlainText:)
						keyEquivalent:@"V"];
	[menuItem setKeyEquivalentModifierMask:NSEventModifierFlagCommand | NSEventModifierFlagOption];
	
	[menu addItemWithTitle:NSLocalizedString(@"Delete", nil)
					action:@selector(delete:)
			 keyEquivalent:[NSString stringWithFormat:@"%C", (unichar)NSBackspaceCharacter]];
	
	[menu addItemWithTitle:NSLocalizedString(@"Select All", nil)
					action:@selector(selectAll:)
			 keyEquivalent:@"a"];
	
	[menu addItem:[NSMenuItem separatorItem]];
	
	menuItem = [menu addItemWithTitle:NSLocalizedString(@"Find", nil)
							   action:NULL
						keyEquivalent:@""];
	NSMenu* findMenu = [[NSMenu alloc] initWithTitle:@"Find"];
	[self populateFindMenu:findMenu];
	[menu setSubmenu:findMenu forItem:menuItem];
	
	menuItem = [menu addItemWithTitle:NSLocalizedString(@"Spelling", nil)
							   action:NULL
						keyEquivalent:@""];
	NSMenu* spellingMenu = [[NSMenu alloc] initWithTitle:@"Spelling"];
	[self populateSpellingMenu:spellingMenu];
	[menu setSubmenu:spellingMenu forItem:menuItem];
}

+(void)populateFindMenu:(NSMenu*)menu {
	NSMenuItem* menuItem;
	
	menuItem = [menu addItemWithTitle:NSLocalizedString(@"Find…", nil)
							   action:@selector(performFindPanelAction:)
						keyEquivalent:@"f"];
	[menuItem setTag:NSFindPanelActionShowFindPanel];
	
	menuItem = [menu addItemWithTitle:NSLocalizedString(@"Find Next", nil)
							   action:@selector(performFindPanelAction:)
						keyEquivalent:@"g"];
	[menuItem setTag:NSFindPanelActionNext];
	
	menuItem = [menu addItemWithTitle:NSLocalizedString(@"Find Previous", nil)
							   action:@selector(performFindPanelAction:)
						keyEquivalent:@"G"];
	[menuItem setTag:NSFindPanelActionPrevious];
	
	menuItem = [menu addItemWithTitle:NSLocalizedString(@"Use Selection for Find", nil)
							   action:@selector(performFindPanelAction:)
						keyEquivalent:@"e"];
	[menuItem setTag:NSFindPanelActionSetFindString];
	
	[menu addItemWithTitle:NSLocalizedString(@"Jump to Selection", nil)
					action:@selector(centerSelectionInVisibleArea:)
			 keyEquivalent:@"j"];
}

+(void)populateSpellingMenu:(NSMenu*)menu {
	[menu addItemWithTitle:NSLocalizedString(@"Spelling…", nil)
					action:@selector(showGuessPanel:)
			 keyEquivalent:@":"];
	
	[menu addItemWithTitle:NSLocalizedString(@"Check Spelling", nil)
					action:@selector(checkSpelling:)
			 keyEquivalent:@";"];
	
	[menu addItemWithTitle:NSLocalizedString(@"Check Spelling as You Type", nil)
					action:@selector(toggleContinuousSpellChecking:)
			 keyEquivalent:@""];
}

+(void)populateWindowMenu:(NSMenu*)menu {
	[menu addItemWithTitle:NSLocalizedString(@"Close Window", nil)
					action:@selector(performClose:)
			 keyEquivalent:@"w"];
	[menu addItemWithTitle:NSLocalizedString(@"Minimize", nil)
					action:@selector(performMiniaturize:)
			 keyEquivalent:@"m"];
	
	[menu addItem:[NSMenuItem separatorItem]];
	
	[menu addItemWithTitle:NSLocalizedString(@"Bring All to Front", nil)
					action:@selector(arrangeInFront:)
			 keyEquivalent:@""];
	
	[menu addItem:[NSMenuItem separatorItem]];
	
	[menu addItemWithTitle:JJApplicationName
					action:@selector(openMainWindow:)
			 keyEquivalent:@""];	
}

+(void)populateHelpMenu:(NSMenu*)menu {
	[menu addItemWithTitle:[NSString stringWithFormat:@"%@ %@", JJApplicationName, NSLocalizedString(@"Web Site", nil)]
					action:@selector(openWebSite:)
			 keyEquivalent:@""];
	
	[menu addItemWithTitle:NSLocalizedString(@"License", nil)
					action:@selector(openLicense:)
			 keyEquivalent:@""];
}

@end
