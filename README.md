# 🎵 Flutter Spotify Clone

This is a UI clone of the **Spotify** mobile app built using **Flutter**, based on a YouTube tutorial and Figma design file.  
The project is focused on **clean architecture**, **BLoC state management**, and good UI/UX practices using custom widgets.

> ⚠️ This project is for learning purposes only.

---

## 📺 Demo

You can preview the latest version of the app by watching the demo clip:

[📺 Watch Demo](https://drive.google.com/file/d/10M-ycwtW4tnO04xZIZq4L1HOgajgkBFC/view?usp=sharing)

The demo shows the app based on the latest source code.

---

## 📺 Tutorial Source

Clone and implementation are based on the following YouTube tutorial: 👉 [Flutter UI Tutorial - Spotify Clone](https://www.youtube.com/watch?v=4TFbXepOjLI&t=5941s)

However, the implementation has been significantly improved and extended with additional features, including clean architecture, BLoC state management, local caching, responsive design, authentication, and enhanced song player functionality that were not covered in the tutorial.

---

## 🎨 Design Reference (Figma)

Figma design used as a reference:  
👉 [Spotify UI - Figma](https://www.figma.com/design/RSDzrYPq3Vz2Jjw0TovCZO/Spotify?node-id=0-1&t=WfUjrDjUpPfJ5Gb7-1)

---

## 🚀 Tech Stack & Libraries

- Flutter & Dart (Flutter 3.x+)
- Routing: go_router
- State Management: BLoC, Hydrated BLoC
- Caching / Local Storage: shared_preferences
- Backend & Database: Firebase (Auth, Firestore)
- Audio: just_audio
- Dependency Injection: get_it
- Environment Variables: flutter_dotenv
- Assets & UI: flutter_svg, Custom Widgets, responsive design
- Error Handling: Failure state, snack bar messages
- Async Handling: async/await, synchronized, rxdart package

---

## 📚 Key Learnings & Features

#### 1. Clean Architecture

- Organized into Feature Layers: Domain, Data, Presentation
- Uses UseCase abstractions for business logic and Repositories for data sources

#### 2. State Management with BLoC

- Uses Hydrated BLoC to persist state
- Uses StreamController as a single source of truth to keep new songs and playlists in sync across the app, without relying on a global Cubit.

#### 3. Authentication & User Management

- Supports Signup/Signin via Firebase Auth
- Creates user documents in Firestore
- Manages authentication state with a global AuthCubit
- Supports Signout and Clear Cache

#### 4. Song Management

- Manages New Songs, Playlists, and Favorite Songs
- Implements local caching in SongRepository
- Supports seek position in Song Player using just_audio
- Uses synchronized package to prevent concurrency issues when adding/removing favorite songs

#### 5. UI/UX & Responsive Design

- Uses MediaQuery, LayoutBuilder to handle responsive
- Uses Inkwell for tap overlay on choose mode button
- Custom BasicButton supports loading state
- Enhanced AppBar to support custom actions and configurable properties
- Handles error messages via snack-bar
- Responsive design for all pages

#### 6. Routing & Navigation

- Uses go_router with custom extensions popUntilPath
- Uses popUntilPath for complex routing instead of goNamed
- Checks canPop before popping routes

#### 7. Code Quality & Best Practices

- Uses Constructor Injection for testable repositories
- Clear folder structure and naming (sources, features, common, core)

#### 8. Local Caching & Persistence

- Uses hydrated_bloc to persist authentication state
- Uses shared_preferences for short-term caching of profile, new songs, and playlists
- Implements clear cache use case on signout

#### 9. Assets & Styling

- Integrated various assets including images, vector graphics (via flutter_svg), and custom fonts (Satoshi)
- Implemented ThemeData for both dark and light themes
- Customized global themes using ThemeData (e.g., elevatedButtonTheme, inputDecorationTheme)

#### 10. Testing & Maintainability [Planned]
