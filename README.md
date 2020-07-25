# Torrent Searcher
This project is a search aggregator for multiple torrent sites. The cool thing about it is that it works in countries and networks where these torrent sites are blocked.

## Why?
There are three main reasons why I made this.

1. Torrent sites are annoying to browse because of ads, CAPTCHAs, and just generally bad web design.
2. The country I live in blocks access to torrent sites because of copyright. This bypasses the block without me having to use Tor Browser, a VPN, or a proxy site (most of which don't even work).
3. This can search multiple torrent sites at once, which is convenient for obvious reasons.

## How?
Firebase Functions. Firebase Functions is a service by Google that lets you run node.js functions in the cloud. Because of this, functions ran on it are not affected by the DMCA blocks, similarly to VPNs. Whenever you make a search in the client, it calls the function with your search and displays the results to you in a nice table.

The client is written in Flutter and was mainly designed for the web. I did the Android setup as well so this could be built as an Android app but I only did so for debugging purposes (the Flutter plugin for Firebase Functions has some bugs in web debug). Regular HTML/JS would have probably worked better but I don't know HTML/JS.

## Where?
I'm not hosting this publicly since doing external web requests is a paid feature of Firebase. My own usage hasn't even reached 1p yet but I don't want to end up paying for this because of API abuse or something.

# Setup Guide
Real guide coming soon! Here's a rough guide:

1. Make a Firebase project and enable functions.
2. Set up a web app and note down the API keys (or just do step 4 now).
3. Use the Firebase CLI to upload the functions in the functions/ directory.
4. Fill in index-example.html (in `client/web`) with your API keys and rename it to index.html. If you want to build this as an Android app, you'll need to make an Android app and put `google-services.json` in `client/android/app`. You'll also probably want to change the app ID in `client/android/app/build.grade`.
5. Build the project. If you're doing it for the web, You'll need to be on Flutter's beta branch. To build for web, run `flutter build web` in `client/`. If you're doing it for Android, run `flutter build apk --split-per-abi`.
6. If you built it for web, host the website found in `client/build/web` somewhere. `python -m http.server` works fine if you're just running it on LAN. If you built it for Android, install the APK.

# Notes

Android hasn't really been tested and the results don't show properly. As I said earlier, I only set up Android support for debugging, not actual use.

I'm not responsible for any copyright violations or other illegal activity done on this application. I'm pretty sure it says that in the license but I'm saying it here just to be sure.