# Swap Monsters

A 2D cave-escape platformer built in Godot around one central question: how can a single level make three different character abilities necessary?

![Swap Monsters gameplay showing the cave route and Bunny character](evidence/gameplay-screenshot.png)

## Project snapshot

- **Role:** Solo student developer using a supplied starter framework
- **Development time:** Seven working days during a two-week, 30-hour Urban Arts course
- **Engine and language:** Godot and GDScript
- **Foundation:** Endless Access Moddable Platformer starter framework
- **Status:** Completed and published playable level
- **Recognition:** Best Unique Character Abilities; nominated by the instructor for an RIT alumni award

## What I built

I removed the original level content from the starter project and developed a new cave-escape game featuring:

- Three switchable characters with distinct abilities
- A limited switching meter
- A projectile and breakable-object system
- Character-specific movement and animation behavior
- Crystal collection and environmental hazards
- A cave route designed around ability sequencing
- Tutorial signs that introduce mechanics inside the level

The level asks players to switch among:

- **Bunny:** an air dash for crossing gaps and gaining height
- **Owlet:** a glide that slows falling while preserving horizontal momentum
- **Dude:** an arrow that breaks crystal barriers

## Design approach

I designed the route so that changing characters was part of solving the level, not just a cosmetic choice. Tutorial spaces introduce one ability at a time, then later sections combine those abilities and place limits on how often the player can switch.

The switching meter became the main constraint. It prevents constant swapping and makes the player consider which character is needed before entering the next section.

## Development evidence

These materials document the seven-day build and selected implementation details. The code images are screenshots of original GDScript from the project. They provide evidence of Charlie's work but are not a complete, runnable source release.

### Daily progress journal

The [seven-day development journal](evidence/daily-progress-journal.pdf) records the sequence from adapting the starter framework through building the state machine, character switching, unique abilities, switching meter, map, and final level.

### Selected GDScript

The switching example shows character-state changes, meter limits and recharge, and ability-state handling.

![GDScript showing character switching, meter recharge, and ability-state handling](evidence/character-switching-code.png)

The projectile example shows arrow creation, direction handling, scene placement, and spawn positioning.

![GDScript showing arrow instantiation and left-right direction handling](evidence/arrow-spawning-code.png)

### Gameplay walkthrough

[![Swap Monsters walkthrough thumbnail](evidence/walkthrough-thumbnail.png)](https://youtu.be/zS3NLN07p0Y)

[Watch the complete gameplay walkthrough on YouTube](https://youtu.be/zS3NLN07p0Y).

## Attribution

Built in Godot using the **Endless Access Moddable Platformer** starter framework. I replaced and customized the player systems, programmed the three-character switching and abilities, created the switching-meter and breakable-object mechanics, and designed the cave's route and progression.

Visual and audio assets came from credited third-party sources, including CraftPix, itch.io asset creators, Endless Access Studio, and Pixabay.

## Repository status

This repository currently documents the project and its design process. The complete Godot source project has not yet been published here.

## Project links

- [Play Swap Monsters on itch.io](https://spaceninja910.itch.io/swap-monsters)
- [Watch the gameplay walkthrough](https://youtu.be/zS3NLN07p0Y)
- [Read the full portfolio case study](https://www.charliebarra.com/swap-monsters.html)
- [Visit Charlie's portfolio](https://www.charliebarra.com/)
