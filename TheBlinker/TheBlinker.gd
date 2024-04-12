extends CPMOSCModule

var is_blinking : bool = false
var should_blink : bool = false
var blink_ticks : int = 3
var blinks_per_minute : float = 15.0:
	set(val):
		blinks_per_minute = val
		_blinks_per_second = blinks_per_minute / 60.0
var minimum_seconds_per_blink : float = 0.5

var _blinks_per_second : float = blinks_per_minute / 60.0
var _current_ticks : int = 0
var _current_time : float = 0.0

func _ready():
	randomize()

func initialize(client, manager):
	super(client, manager)
	send_message("is_blinking", false)
	load_configs()
	control.value_changed.connect(on_control_values_changed)

func _exit_tree():
	send_message("is_blinking", false)

func _process(delta):
	_current_time += delta
	if _current_time < minimum_seconds_per_blink:
		return
	_current_time = 0.0
	should_blink = randf() < _blinks_per_second * minimum_seconds_per_blink

func load_configs():
	if !config.has_section("Config"):
		config.set_value("Config", "BPM", 15.0)
		config.set_value("Config", "Duration", 3)
		config.set_value("Config", "Minimum", 0.5)
		save_configs()
	
	self.blinks_per_minute = config.get_value("Config", "BPM")
	blink_ticks = config.get_value("Config", "Duration")
	minimum_seconds_per_blink = config.get_value("Config", "Minimum")
	control._set_values(blinks_per_minute, blink_ticks, minimum_seconds_per_blink)

func on_message_received(address, arguments):
	if address == "/cpm/gameTime":
		if should_blink and !is_blinking:
			_current_ticks = blink_ticks
			is_blinking = true
			should_blink = false
			send_message("is_blinking", true)
			return
		
		if is_blinking:
			_current_ticks -= 1
			if _current_ticks == 0:
				is_blinking = false
				send_message("is_blinking", false)

func on_control_values_changed(which, value):
	match which:
		"BPM":
			blinks_per_minute = value
		"Duration":
			blink_ticks = value
		"Minimum":
			minimum_seconds_per_blink = value

	config.set_value("Config", which, value)
	save_configs()
