extends ModuleControlBase

signal value_changed(which, value)

func post_initialize():
	controls["BPM"].value_changed.connect(func(new_value): value_changed.emit("BPM", new_value))
	controls["Duration"].value_changed.connect(func(new_value): value_changed.emit("Duration", new_value))
	controls["Minimum"].value_changed.connect(func(new_value): value_changed.emit("Minimum", new_value))

func _set_values(bpm, duration, minimum):
	controls["BPM"].value = bpm
	controls["Duration"].value = duration
	controls["Minimum"].value = minimum
