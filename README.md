<div align="center">
    <img
        alt="Game icon showing an UFO with cat ears pulling up a cow with its tractor beam."
        src="./icon.png"
    />
    <h1>
        U.F.O. - Unknown Feline Object
    </h1>
</div>
<div align = "left">
    <p>
        Inspired by the <a href=https://itch.io/jam/stop-waiting-for-godot>STOP WAITING FOR GODOT</a> jam, I wanted to learn working with Godot. 
        Unfortunately, time was short and participation in the jam was not possible. 
        So a rough deadline was set for my own little jam: two and a half to three days (that's how much time I thought I realistically would have had available for the jam) to watch tutorials, read the documentation and code. 
        The result was a small game, where a flat cylinder tries to save rectangular cuboids from cubes with the help of its tractor beam.
    </p>
    <p>
        After a short break I returned to the project - it looked like a good way to learn more. So whenever time allows, I'm tinkering with the game.
    </p>
    <p>
        If you want to make your own version of the game, feel free to clone the repo. If you just want to try the game: the latest build, as well as the original prototype, can be found on <a href=https://elstudio314.itch.io/ufo>itch.io</a>. 
    </p>
        I hope you have fun with it! <br>
        <em>-- elpollomaniaco</em>
    </p>
</div>

***

## Table of contents
- [Prerequisites](#prerequisites)
- [How to use](#how-to-use)
- [Version history](#version-history)
- [Licence](#licence)

***

## Prerequisites

Name | Version | Comment
-----|---------|---------
[Git LFS](https://git-lfs.github.com/) | - | -
[Godot](https://godotengine.org/download) | 3.4.4 | Started with 3.3 and updated without problems. Newer 3.x versions SHOULD be compatible.
***

## How to use

### Open in editor
Clone files and scan root folder with Godot to add the project to the overview. BEFORE opening the project for the first time, you should read the section on [audio dummy files](#audio-dummy-files). That's it. Now you are ready to change the game as you like. 

### Audio dummy files
Due to licensing (i.e. I'm not sure), some of the audio files are not part of the repository - neither as music files nor in any other form.

In order to be able to start the game in Godot anyway, there are *muted* copies of the files inside [_dummy_files](./_dummy_files/). If the *audio* folder is moved to the root directory before opening the game project in the editor, no errors due to missing dependencies will occur, and it is possible to work with a mostly silent version. Otherwise, either the dependencies in the scenes must be removed/changed or your own sound files with identical names must be created from the editor before playing the game in it.

To check settings for your own audio files (i.e. loop = true/false) please refer to the dummy files in the editor.

<details>
<summary>_dummy_files/audio/</summary>

```
├── music
│   ├── game_over.mp3str
│   ├── level.mp3str
│   └── menu.mp3str
└── sfx
    ├── air_compressor.mp3str
    ├── blood_A1.mp3str
    ├── blood_A2.mp3str
    ├── blood_A10.mp3str
    ├── cow_moo_B.mp3str
    ├── cow_moo_C.mp3str
    ├── cow_moo_D.mp3str
    ├── menu_button_pressed.mp3str
    ├── menu_selection_changed.mp3str
    ├── metal_bang_fast_01.mp3str
    ├── metal_bang_fast_02.mp3str
    ├── metal_bang_fast_03.mp3str
    ├── metal_bang_slow_01.mp3str
    ├── metal_bang_slow_02.mp3str
    ├── metal_bang_slow_03.mp3str
    ├── sheep_bah_A.mp3str
    ├── sheep_bah_B.mp3str
    ├── sheep_bah_C.mp3str
    ├── woosh_D5.mp3str
    ├── woosh_D6.mp3str
    ├── woosh_E10.mp3str
    ├── woosh_E11.mp3str
    ├── woosh_E12.mp3str
    └── woosh_I4.mp3str
```
</details>

***

## Version history
This list shows the different release versions of the game as seen in the main branch - from oldest to newest.

- **JAM** - the quick one.
    - Initial release to see how Godot works. 
    - Primitive meshes as models.
    - Basic menus.
    - Movement only by using directed forces on objects.
    - Simple attack with ball. 
    - No sound.
- **A/V Club** - improving look, hear & feel.
    - New models for all objects.
    - Basic animations for player object.
    - Background music.
    - Sound effects.
    - Menus with new graphics and animations.
    - New HUD.
    - World props influenced by forces.
    - Changed attack to claws following player.
    - Smoother level barriers.
    - Some performance improvements.
    - First balancing.
    - Milk regenerates energy.

***

## Licence

GNU GPLv3 - see [LICENCE](./LICENSE).

For the licence of the included third-party audio files see [the corresponding licence overview](./audio/sfx/license.txt).

***



