This is a repo for official modules for [CompassOSC](https://github.com/Topodic/CompassOSC). These differ from the samples in the software's repository as these have more practical utility. To use these, download the standalone release of CompassOSC and put the `.pck` files from here into a `modules` folder next to the executable. Ensure all animations have `Command Activated Activation` enabled.

### Modules

#### [Equipped Gear](https://github.com/Topodic/CompassOSC-Modules/raw/master/pcks/EquippedGear.pck)

Sends `true` or `false` messages when the player has equipped or unequipped a piece of armor (`head`, `body`, `legs`, `feet`, `main_hand`, `off_hand`) at an address based on the gear equipped/unequipped and where it is equipped, ie `/wearing/feet/diamond_boots`, so your animations should be Toggle Layers named for the gear they should be turned on while wearing, for instance `osc:/wearing/head/chainmail_helmet`.

#### [The Blinker](https://github.com/Topodic/CompassOSC-Modules/raw/master/pcks/TheBlinker.pck)

Randomly sends a `true` or `false` message to control a Toggle Layer called `osc:/is_blinking`. Allows configuring average number of blinks per minute, how many game ticks the blink lasts for, and how long between each blink.

#### [Basic Motion Physics](https://github.com/Topodic/CompassOSC-Modules/raw/master/pcks/BasicMotionPhysics.pck)

Sends a plethora of values for between `-1.0` and `1.0` depending on in-game motion to addresses `osc:/phys/velocity` and `osc:/phys/acceleration`, followed by `frontback`, `rightleft`, `vertical`, `bodyYaw`, `headYaw`, or `headPitch`. Currently it's a basic simplified damped oscillator - a spring essentially, so this is useful for wobbly bits and things like tails or capes. Has configs for various values, and supports multiple simultaneous controllers with the addresses suffixed by your choice of identifier, for instance `osc:/phys/velocity/headYawCape` or `osc:/phys/acceleration/verticalTail`, and lastly `(-1.00:1.00)` to work with the range of outputs. A proper animation name will look something like `osc:/phys/acceleration/vertical4(-1.00:1.00)`. Ensure the animations are Value Layers at 1000ms duration and are set to `Linear Single` interpolation or you may have strange results.
