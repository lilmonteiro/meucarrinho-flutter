# MeuCarrinho Flutter

🛒 **Simple shopping‑list / cart app built with Flutter**  
This project is a lightweight grocery/cart manager created as a learning exercise.  
It runs on mobile, web and desktop thanks to Flutter’s cross‑platform support.

## 🚀 Features

- 📦 **Add, edit and remove products**  
  Keep track of item names and quantities.

- ✅ **Mark items as purchased**  
  Tap a row to check/uncheck; checked items are visually struck‑through.

- 💾 **Local persistence**  
  Products are saved locally using `shared_preferences` so your list survives app restarts.

- ☁️ **Cloud backup (Firebase Firestore)**  
  New items are automatically pushed to a `products` collection in Firestore.

- 🎨 **Custom theming & UI touches**  
  A curved app bar, custom colors and responsive layout make the app pleasant to use.

## 🧱 Technologies & Packages

| Layer | Used Packages / Tools |
|-------|-----------------------|
| Flutter | `flutter 3.x` (stable) |
| State & UI | `material`, `provider` (built‑in state), custom widgets |
| Persistence | `shared_preferences` |
| Backend | `firebase_core`, `cloud_firestore` |
| Others | `dart:convert` for JSON serialization |

The project is configured for **Android, iOS, Web, macOS, Windows and Linux**.

## 🛠 Getting Started

1. **Clone the repo**  
   ```bash
   git clone https://github.com/<your‑username>/meucarrinho_flutter.git
   cd meucarrinho_flutter
   ```

2. **Install dependencies**  
   ```bash
   flutter pub get
   ```

3. **Firebase setup**  
   - Register your app in the Firebase console.
   - Replace the generated `firebase_options.dart` (already included) if necessary.

4. **Run the app**  
   ```bash
   flutter run
   ```

> 💡 On desktop/web you don’t need Firebase configuration unless you plan to use Firestore.

## 🗂 Project Structure

```
lib/
 ├─ main.dart          # entry point & app logic
 ├─ firebase_options.dart
 ...
```

Most of the core logic lives in `main.dart` (adding/editing items, storage, UI).

## ✅ Future Improvements

- User authentication (Firebase Auth)
- Sync full list with Firestore (read/update/delete)
- Categories, sorting, and total cost calculation
- Unit & widget tests

---

Thanks for checking out **MeuCarrinho Flutter** – a simple but functional cart application built to explore Flutter and Firebase.  
Feel free to open issues or submit pull requests!
