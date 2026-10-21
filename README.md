# 2d-platformer-template

A simple template for 2D platformer movement in Godot 4.7.

The goal of this repository is to have a small, reusable starting point for 2D platformer projects: a playable character with tuned movement and animations, plus a tileset to build test levels. Copy it, tweak the values and start building your game on top of it.

## Features
- `CharacterBody2D` player with walking, sprinting and jumping.
- Jump defined by height and time (time to peak / time to descent) instead of raw velocity and gravity, so it is easy to tune from the Inspector.
- Faster fall than rise for a snappier jump.
- Animations for idle, walk, run, jump and fall, with sprite flipping.
- Medieval tilesets ready to paint levels.

## Controls
| Action | Key |
|--------|-----|
| Move   | A / D |
| Jump   | Space |
| Sprint | Shift |

## Structure
```
assets/     sprites and tile images
scenes/     main_scene.tscn, player.tscn, platform.tscn
scripts/    player.gd (movement), main_scene.gd
tilesets/   medieval tileset and props tileset (.tres)
```

## Tuning the movement
Select the player in `scenes/player.tscn` and change the exported values in the Inspector:
- `move_speed`, `sprint_multiplier`
- `jump_height`, `jump_time_to_peak`, `jump_time_to_descent`

## Credits
Assets used in this project:
- Character: [Girl Knight Asset](https://jumpbutton.itch.io/girlknightasset) by Jump Button
- Tiles and props: [Medieval Pixel Art Asset FREE](https://blackspirestudio.itch.io/medieval-pixel-art-asset-free) by Blackspire Studio

Check each asset's page for its license terms before using them in your own project.
