<div align="center">
    <img
        alt="default Godot icon"
        src="./icon.png"
    />
    <h1>
        U.F.O. - Unknown Feline Object
    </h1>
</div>
<div align = "left">
    <p>
        Inspired by the <a href=https://itch.io/jam/stop-waiting-for-godot>STOP WAITING FOR GODOT</a> jam, the idea was sparked to learn Godot. 
        Unfortunately, time was short and participation in the jam was not possible. 
        So a rough deadline was set: two and a half to three days (that's how much time would have been realistically available for the jam) to watch tutorials, read documentation and code. 
        The result was a small game, where a flat cylinder tries to save rectangular cuboids from cubes with help of its tractor beam.
    </p>
        Fast forward one month: the project is tackled again - with the aim of upgrading it visually and acoustically and improving the gameplay. 
        Whenever time allows, the game is tinkered with to further learn. 
        The latest build, as well as the original prototype, can be found on <a href=https://elstudio314.itch.io/ufo>itch.io</a>. 
    </p>
        I hope you have fun with it! <br>
        <em>-- elpollomaniaco</em>
    </p>
</div>

***

## Table of contents
- [Installation](#installation)

***

## Installation

### Audio dummy files
Due to licensing, some of the audio files are not part of the repository - neither as music files nor in any other form. 

In order to be able to start the game in Godot anyway, there are *muted* copies of the files inside [_dummy_files](./_dummy_files/). If the *audio* folder is moved to the root directory before opening the game project in the editor, no errors will occur due to missing dependencies, and it is possible to work with a mostly silent version. Otherwise, either the dependencies in the scenes must be removed/changed or own sound files with identical names must be created from the editor before playing the game in it.

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




