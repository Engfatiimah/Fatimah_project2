# 🇫🇷 La Table

> *Bienvenue, mon ami.* Pull up a chair — the little chef has been expecting you.

**La Table** is a Flutter app serving the classics of French cuisine on a
hand-crafted "printed menu" interface — warm paper tones, a cherry-red
accent, tilted photo stickers, an original mouse-chef mascot, and a
double-border frame wrapping every screen. The identity is inspired by
Parisian bistros and the movie *Ratatouille*.

## Overview

A list-then-details flow over two related [TheMealDB](https://www.themealdb.com/api.php) APIs:

1. `filter.php?a=France` — the French dishes list (menu screen).
2. `lookup.php?i={id}` — full details for the tapped dish, using the id
   passed from the list screen.

**API note:** the brief referred to the area as `French`, but the live API's
actual value is `France` — `French` always returns an empty list. Verified
against the API during development; the app queries `a=France`.

Favorites are a small static curated list (`lib/data/favorites.dart`) that
marks hearts on menu cards and fills the Favorites screen — no persistence.

## Demo

🎬 Splash animation, menu, dish details, and favorites in one walkthrough:

https://github.com/user-attachments/assets/0fe2f86c-4b4f-4eaa-87f9-f94f897aad70


## Screens

| Splash | Menu | Dish | Favorites |
|---|---|---|---|
| <img width="200" alt="splash" src="https://github.com/user-attachments/assets/7db297dd-ac67-4d2a-8a85-6803ed8f3456" /> | <img width="200" alt="menu" src="https://github.com/user-attachments/assets/fcd44664-99c5-472e-b940-77360fd94b8e" /> | <img width="200" alt="dish" src="https://github.com/user-attachments/assets/b04d2140-b69a-4bb3-ad4b-0d8846bceb7d" /> | <img width="200" alt="favorites" src="https://github.com/user-attachments/assets/baa2e8ee-a5bd-4444-8b0f-0208ec53803b" /> |

1. **Splash** — the chef dashes across, the logo pops, he peeks back in;
   tap anywhere to be seated. One `AnimationController`, `Interval`-based beats.
2. **Menu** — pinned **Chef's Pick** (Ratatouille, of course) + a horizontal
   rail of dish cards with favorite hearts.
3. **Dish** — photo sticker, vegetarian badge, receipt-style ingredients
   with dotted leaders, and full instructions.
4. **Favorites** — the chef's dearest dishes, always matching the hearts
   on the menu.

## Project Structure

    lib/
    ├── main.dart           # App entry + theme setup
    ├── theme/              # Design tokens (AppColors, AppFonts)
    ├── models/             # fromJson models (MealSummary, MealDetail, Ingredient)
    ├── services/           # HTTP layer over filter.php / lookup.php
    ├── data/               # Static favorites list
    ├── widgets/            # Reusable UI (frame, cards, stickers, async states)
    └── screens/            # Splash, Menu, Dish, Favorites

## Extra Credit

- [x] Custom 3-stage splash animation (single `AnimationController`,
      `Interval` curves, tap-to-continue).
- [x] A fifth screen (Favorites): a curated static list sharing one data
      source with the menu, so its dishes and the menu's filled hearts
      always match.
- [x] Unified design-token system applied across every screen and state.
- [x] Custom reusable widget library (`MenuFrame`, `PhotoSticker`,
      `DishCard`, `LeaderRow`, `KitchenLoading`/`KitchenError`...).
- [x] Original mascot artwork, not derived from any copyrighted character.
- [x] Branded loading, error, and empty states.
- [x] Discovered and documented a brief-vs-API discrepancy
      (`French` vs `France`), verified against TheMealDB.

*Bon appétit!* 🇫🇷

*Inspired by the spirit of a little chef who believed anyone can cook.*

Créé avec ❤️ par Fatimah Bin Mohammed 
