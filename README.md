# DirectCall

DirectCall is a Flutter mobile application designed specifically with accessibility in mind. It aims to make mobile communication effortless for older users by allowing them to create simple, highly visible "speed dial" contacts right inside a clean, distraction-free interface.

Often, navigating through complex contact lists or reading small caller names can be challenging. DirectCall solves this by focusing on large, photo-centric speed-dial contacts that initiate calls with just one tap.

## Key Features

- **One-Tap Direct Calling**: No need to open a dialer or browse native contacts. Tapping a contact's photo in the app instantly triggers a phone call.
- **Photo-Centric Grid**: Contacts are displayed as large, easy-to-recognize circular avatars rather than text-heavy lists.
- **Accessible & Modern UI**: Features a beautiful "Deep Blue" Material 3 aesthetic. It includes high contrast, large touch targets, clear typography, and a friendly onboarding/empty state to guide new users.
- **Robust Input Validation**: The app prevents user errors by strictly validating contact names and ensuring phone numbers follow international numerical formats (only allowing digits and an optional `+` symbol).
- **Performance Optimized**: Includes built-in image compression upon photo selection to prevent Out-Of-Memory (OOM) crashes on older or low-end Android devices (e.g., older Vivo models).
- **Local Persistence**: All contacts and preferences are saved entirely offline directly on the device.

## Recent Technical Updates

- **Minimum SDK Bump**: Upgraded the minimum Android SDK requirement to API 24 (Android 7.0) to ensure modern security and compatibility.
- **Custom App Icons**: Integrated a sleek, custom app icon tailored for both Android and iOS utilizing `flutter_launcher_icons`.
- **Streamlined Architecture**: Removed redundant calling screens to trigger `url_launcher` natively directly from the home screen grid, greatly speeding up the user flow.
- **Enhanced UX Feedback**: Implemented visual confirmation (SnackBars) upon successfully saving contacts.

## Getting Started

This project is built with Flutter. To run the project locally:

1. Ensure you have [Flutter installed](https://docs.flutter.dev/get-started/install).
2. Clone the repository.
3. Run `flutter pub get` to install dependencies.
4. *(Optional but recommended for speed)* Run in release mode to experience actual performance without debug-mode stuttering:
   ```bash
   flutter run --release
   ```

## Dependencies
- `url_launcher` for executing phone calls.
- `shared_preferences` for local data storage.
- `image_picker` for selecting user avatars (configured with strict compression limits).
- `uuid` for unique contact identification.
- `flutter_launcher_icons` (dev dependency) for automatic icon generation.
