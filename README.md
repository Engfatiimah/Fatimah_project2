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

🎬 **[Watch the app demo](demo/la_table_demo.mp4)** — splash animation, menu,
dish details, and favorites in one walkthrough.

| Splash | Menu | Dish | Favorites |
|---|---|---|---|
| ![Splash](screenshots/splash.png) | ![Menu](screenshots/menu.png) | ![Dish](screenshots/dish.png) | ![Favorites](screenshots/favorites.png) |

1. **Splash** — the chef dashes across, the logo pops, he peeks back in;
   tap anywhere to be seated. One `AnimationController`, `Interval`-based beats.
2. **Menu** — pinned **Chef's Pick** (Ratatouille, of course) + a horizontal
   rail of dish cards with favorite hearts.
3. **Dish** — photo sticker, vegetarian badge, receipt-style ingredients
   with dotted leaders, and full instructions.
4. **Favorites** — the chef's dearest dishes, always matching the hearts
   on the menu.

## Project Structure