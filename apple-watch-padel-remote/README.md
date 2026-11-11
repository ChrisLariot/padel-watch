# Padel Score – Apple Watch app (no Mac needed)

Talks to the same court PINs and tournaments as https://scorerecord.lovable.app.
The web remote keeps working as before — this is an extra, native option.

## On the watch
- **PIN screen:** tap a digit, turn the Digital Crown to change it, tap Next / Join.
- **Score screen:** tap top (orange) = Team A point, tap bottom (cream) = Team B point,
  **press and hold** = undo. You feel a tap on your wrist for each.

## 1. Put the code on GitHub (free)
1. Create a free account at github.com → **New repository** (private is fine).
2. Click **uploading an existing file**, drag in everything from this folder
   (including the hidden `.github` folder — on Windows enable "Hidden items" in File Explorer), commit.
3. Open the **Actions** tab. "Build Apple Watch app" runs on a cloud Mac.
   A green tick = the app compiles. (No Apple account needed for this step.)

## 2. Get it onto your watch via TestFlight (needs Apple Developer, $99/yr)
1. Join at developer.apple.com/programs.
2. In App Store Connect → **Apps → +** create an app, bundle ID `com.scorerecord.padelwatch`
   (register it first under Certificates, IDs & Profiles → Identifiers).
3. App Store Connect → **Users and Access → Integrations → App Store Connect API** →
   create a key with **App Manager** access. Download the `.p8` file, note Key ID and Issuer ID.
4. In your GitHub repo → **Settings → Secrets and variables → Actions**, add:
   - `APPLE_TEAM_ID` – 10-character Team ID (developer.apple.com → Membership)
   - `ASC_KEY_ID` – the key ID
   - `ASC_ISSUER_ID` – the issuer ID
   - `ASC_KEY_P8` – open the .p8 file in Notepad and paste the whole text
5. Actions tab → **Run workflow**. After ~15 min the build appears in App Store Connect → TestFlight.
6. Add yourself as an internal tester, install **TestFlight** on your iPhone, accept,
   and install **Padel Score** — it lands on your paired Apple Watch.
