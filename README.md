This is a repo for official modules for [CompassOSC](https://github.com/Topodic/CompassOSC). These differ from the samples in the software's repository as these have more practical utility. To use these, download the standalone release of CompassOSC and put the `.pck` files from here into a `modules` folder next to the executable.

### Modules

#### [Equipped Gear](https://github.com/Topodic/CompassOSC-Modules/raw/master/pcks/EquippedGear.pck)

Sends `true` or `false` messages when the player has equipped or unequipped a piece of armor (head, body, legs, feet) at an address based on the gear equipped/unequipped, ie `/wearing/diamond_boots`, so your animations should be Toggle Layers named for the gear they should be turned on while wearing, for instance `osc:/wearing/chainmail_helmet`.
