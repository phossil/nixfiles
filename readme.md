# phossil's neetfiles

![Discord Emoji: `:BerylHypest:`](https://cdn.discordapp.com/emojis/734085578026647582.gif)

TODO: use `services.xserver.displayManager.sessionPackages` with a wlroots compositor

NOTE: maybe f2fs isn't always the problem
```shell
phossil in nixfiles on  main [!] at 03:32:40 > alacritty
libEGL warning: MESA-LOADER: failed to open radeonsi: /nix/store/v3kykyqz2nz9cbp7zhxxnbx6434vaqij-gcc-10.4.0-lib/lib/libstdc++.so.6: version `GLIBCXX_3.4.29' not found (required by /run/opengl-driver/lib/dri/radeonsi_dri.so) (search paths /run/opengl-driver/lib/dri, suffix _dri)

libEGL warning: MESA-LOADER: failed to open swrast: /nix/store/v3kykyqz2nz9cbp7zhxxnbx6434vaqij-gcc-10.4.0-lib/lib/libstdc++.so.6: version `GLIBCXX_3.4.29' not found (required by /run/opengl-driver/lib/dri/swrast_dri.so) (search paths /run/opengl-driver/lib/dri, suffix _dri)

libEGL warning: MESA-LOADER: failed to open radeonsi: /nix/store/v3kykyqz2nz9cbp7zhxxnbx6434vaqij-gcc-10.4.0-lib/lib/libstdc++.so.6: version `GLIBCXX_3.4.29' not found (required by /run/opengl-driver/lib/dri/radeonsi_dri.so) (search paths /run/opengl-driver/lib/dri, suffix _dri)

libEGL warning: MESA-LOADER: failed to open swrast: /nix/store/v3kykyqz2nz9cbp7zhxxnbx6434vaqij-gcc-10.4.0-lib/lib/libstdc++.so.6: version `GLIBCXX_3.4.29' not found (required by /run/opengl-driver/lib/dri/swrast_dri.so) (search paths /run/opengl-driver/lib/dri, suffix _dri)

libEGL warning: MESA-LOADER: failed to open radeonsi: /nix/store/v3kykyqz2nz9cbp7zhxxnbx6434vaqij-gcc-10.4.0-lib/lib/libstdc++.so.6: version `GLIBCXX_3.4.29' not found (required by /run/opengl-driver/lib/dri/radeonsi_dri.so) (search paths /run/opengl-driver/lib/dri, suffix _dri)

libEGL warning: MESA-LOADER: failed to open swrast: /nix/store/v3kykyqz2nz9cbp7zhxxnbx6434vaqij-gcc-10.4.0-lib/lib/libstdc++.so.6: version `GLIBCXX_3.4.29' not found (required by /run/opengl-driver/lib/dri/swrast_dri.so) (search paths /run/opengl-driver/lib/dri, suffix _dri)

libEGL warning: MESA-LOADER: failed to open radeonsi: /nix/store/v3kykyqz2nz9cbp7zhxxnbx6434vaqij-gcc-10.4.0-lib/lib/libstdc++.so.6: version `GLIBCXX_3.4.29' not found (required by /run/opengl-driver/lib/dri/radeonsi_dri.so) (search paths /run/opengl-driver/lib/dri, suffix _dri)

libEGL warning: MESA-LOADER: failed to open swrast: /nix/store/v3kykyqz2nz9cbp7zhxxnbx6434vaqij-gcc-10.4.0-lib/lib/libstdc++.so.6: version `GLIBCXX_3.4.29' not found (required by /run/opengl-driver/lib/dri/swrast_dri.so) (search paths /run/opengl-driver/lib/dri, suffix _dri)

Error: Error creating GL context; eglInitialize failed
Error: "Event loop terminated with code: 1"
phossil in nixfiles on  main [!] at 03:32:43 ✗
```