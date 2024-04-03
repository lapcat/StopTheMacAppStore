# Stop The Mac App Store

Stop The Mac App Store is an app for macOS that automatically handles Mac App Store URLs instead of App Store app. If you allow Safari to open a Mac App Store URL in Stop The Mac App Store, the app's page will then open in App Store. This lets you stop App Store from automatically opening. Stop The Mac App Store also works with Safari Technology Preview.

On macOS Ventura or Sonoma, use the [latest release](https://github.com/lapcat/StopTheMacAppStore/releases/latest).

On macOS Big Sur or Monterey, use [version 1.0 of Stop The Mac App Store](https://github.com/lapcat/StopTheMacAppStore/releases/tag/v1.0).

On macOS Catalina or Mojave, this functionality is included in [version 2.2 of StopTheNews](https://github.com/lapcat/StopTheNews/releases/tag/v2.2).

## Installing

1. Download Stop The Mac App Store.
2. Unzip the downloaded `.zip` file.
3. Move `Stop The Mac App Store.app` to your Applications folder.
4. Open `Stop The Mac App Store.app`.
5. Quit `Stop The Mac App Store.app`.

## Uninstalling

1. Move `Stop The Mac App Store.app` to the Trash.

## Building

Building Stop The Mac App Store from source requires Xcode 12 or later.

Before building, you need to create a file named `DEVELOPMENT_TEAM.xcconfig` in the project folder (the same folder as `Shared.xcconfig`). This file is excluded from version control by the project's `.gitignore` file, and it's not referenced in the Xcode project either. The file specifies the build setting for your Development Team, which is needed by Xcode to code sign the app. The entire contents of the file should be of the following format:
```
DEVELOPMENT_TEAM = [Your TeamID]
```

## Author

[Jeff Johnson](https://lapcatsoftware.com/)

To support the author, you can [PayPal.Me](https://www.paypal.me/JeffJohnsonWI) or buy the Safari extension StopTheMadness in the [Mac App Store](https://apps.apple.com/app/stopthemadness/id1376402589?mt=12).

## Copyright

Stop The Mac App Store is Copyright © 2021 Jeff Johnson. All rights reserved.

## License

See the [LICENSE.txt](LICENSE.txt) file for details.
