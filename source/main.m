#import "JJApplicationDelegate.h"

int main(int argc, const char* argv[]) {
	@autoreleasepool {
		NSApplication* application = [NSApplication sharedApplication];
		JJApplicationDelegate*NS_VALID_UNTIL_END_OF_SCOPE delegate = [[JJApplicationDelegate alloc] init];
		[application setDelegate:delegate];
		[application run];
		[application setDelegate:nil];
	}
	return EXIT_SUCCESS;
}
