# 🚪 Premium Teleport & Zone Unlock System (Roblox)

A highly secure, modular, and optimized zone progression system for Roblox experiences. Built with Luau, this system handles economy-based zone unlocking and secure player teleportation with a focus on premium UI/UX.

## 🚀 Features

* **Server-Side Security:** Teleportation and purchasing processes are strictly validated on the server. It provides complete protection against client-side manipulation and exploit attempts.
* **Dynamic & Modular Structure:** Add an infinite number of new zones simply by dropping a new model into the `workspace.Zones` folder—zero code changes required. The UI and core functions automatically adapt to the map.
* **Premium UI/UX:** Smooth, "Pop" style opening effects and dynamic button interactions powered by `TweenService`.
* **Defensive Programming:** Robust, crash-resistant infrastructure that handles edge cases gracefully (e.g., when Character or UI elements are momentarily `nil` during respawns).
* **Economy Integration:** Built-in dynamic currency control synced seamlessly with `leaderstats`.

## 🛠️ Architecture

The system consists of three main pillars:
1.  **ZoneService (Server Script):** Initializes player data, validates purchases via `ProximityPrompt`, and handles teleportation requests with strict authorization checks.
2.  **UIController (Local Script):** Manages dynamic button states, plays `TweenService` animations, and fires secure teleportation signals (`FireServer`) to the server.
3.  **RemoteEvents (The Bridge):** Facilitates secure communication between the Client and Server (`UnlockZone`, `TeleportRequest`).

## 📦 Installation

To integrate the system into your project, set up your Explorer hierarchy as follows:

- `ServerScriptService/`
  - `ZoneService` (Script)
- `StarterPlayer/StarterPlayerScripts/`
  - `ZoneUIController` (LocalScript)
- `ReplicatedStorage/RemoteEvents/`
  - `UnlockZone` (RemoteEvent)
  - `TeleportRequest` (RemoteEvent)
- `ReplicatedStorage/`
  - `MapTemplate` (UI Frame)
- `workspace/`
  - `Zones/` (Folder)
  - `TeleportPoints/` (Folder)

## 🎮 Usage

Follow these steps to add a new zone/door:
1. Add a Part inside the `workspace.Zones` folder (e.g., `Zone2`).
2. Configure the following values from the `Attributes` section of the part:
   - `Price` (Number)
   - `ZoneName` (String)
   - `MoneyName` (String)
3. Add the target teleport point inside the `workspace.TeleportPoints` folder and name it exactly the same as your main door (e.g., `Zone2`).
4. The system will automatically handle the rest!

## 💻 Tech Stack
- **Language:** Luau
- **Services:** `TweenService`, `ProximityPromptService`, `ReplicatedStorage`
