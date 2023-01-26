![](cover.jpeg)

# measure

![buildStatus](https://img.shields.io/github/workflow/status/theapache64/measure/Java%20CI%20with%20Gradle?style=plastic)
![latestVersion](https://img.shields.io/github/v/release/theapache64/measure)
<a href="https://twitter.com/theapache64" target="_blank">
<img alt="Twitter: theapache64" src="https://img.shields.io/twitter/follow/theapache64.svg?style=social" />
</a>

> a shell function to measure the graphics performance of two APK files with maestro and gfxinfo

## ✨ Overview

This is a shell function called `measure` that compares the graphics performance of two Android apps (APKs) by running a flow of user interactions on each app and collecting data on the app's graphics performance using the `dumpsys gfxinfo` command. The function prompts the user to input the names of the two APKs, the flow to run on each app, an optional setup flow, and an optional number of iterations to run the flow (default is 3). The function then installs and runs the flow on each APK, collects the graphics performance data, averages the data, and saves it to a file.

## 🦿 Prerequisites

- Android device connected to the computer via ADB
- [adb](https://developer.android.com/studio/command-line/adb) and [maestro](https://maestro.mobile.dev/getting-started/installing-maestro#upgrading-the-cli) command line tools must be installed and available in the PATH
- [gfx-avg](https://github.com/theapache64/gfx-avg) command line tool must be installed and available in the PATH

## ⌨️ Usage

```console
measure <apk1> <apk2> <measureFlow> [setupFlow] [iteration]
```

- `apk1`: The file path of the first APK to test
- `apk2`: The file path of the second APK to test
- `measureFlow`: The file path of the flow file to run on each app
- `setupFlow` (optional): The file path of the setup flow file to run on each app before running the measure flow
- `iteration` (optional): The number of times to run the measure flow on each app (default is 3)

## 🌊 Script Flow
1. The function starts by initializing and printing some information about the input arguments.
1. The script then prompts the user to uninstall the package of the application if it is already installed.
1.  Then the script installs `apk1` and runs the setup flow if provided, otherwise it waits for the user to press enter.
1.  Then it runs the measure flow on `apk1` for the number of iterations specified, collecting the graphics performance data using the `dumpsys gfxinfo` command and saving the data to a file.
1.  Then it uninstalls `apk1`, installs `apk2` and runs the setup flow if provided, otherwise it waits for the user to press enter.
1.  Then it runs the measure flow on `apk2` for the number of `iterations` specified, collecting the graphics performance data using the `dumpsys gfxinfo` command and saving the data to a file.
1.  The script then averages the data collected from both `apk1` and `apk2` using the `gfx-avg` command.
1.  The script then prints `"Done!"`.

## 💻  Installation
- The function does not require any installation, it can be used by just copying the function to the shell script or by sourcing the script containing the function.


## ✍️ Author

👤 **theapache64**

* Twitter: <a href="https://twitter.com/theapache64" target="_blank">@theapache64</a>
* Email: theapache64@gmail.com

Feel free to ping me 😉

## 🤝 Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any
contributions you make are **greatly appreciated**.

1. Open an issue first to discuss what you would like to change.
1. Fork the Project
1. Create your feature branch (`git checkout -b feature/amazing-feature`)
1. Commit your changes (`git commit -m 'Add some amazing feature'`)
1. Push to the branch (`git push origin feature/amazing-feature`)
1. Open a pull request

Please make sure to update tests as appropriate.

## ❤ Show your support

Give a ⭐️ if this project helped you!

<a href="https://www.patreon.com/theapache64">
  <img alt="Patron Link" src="https://c5.patreon.com/external/logo/become_a_patron_button@2x.png" width="160"/>
</a>

<a href="https://www.buymeacoffee.com/theapache64" target="_blank">
    <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" width="160">
</a>

## 📝 License

```
Copyright © 2023 - theapache64

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

_This README was generated by [readgen](https://github.com/theapache64/readgen)_ ❤