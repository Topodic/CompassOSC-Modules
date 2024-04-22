class_name SpringControl
extends ModuleControlBase

signal values_changed(new_values)
signal clicked(button)

class ControllerValues:
	var identifier : String
	var stiffness : float
	var damping : float
	var mass : float
	var is_active : bool = true
	
	# Dependent values
	var critical_damping : float

@onready var remove_button = get_node("MarginContainer/ControllerVBox/HBoxContainer/RemoveButton")
@onready var active_toggle : CheckBox = get_node("MarginContainer/ControllerVBox/HBoxContainer/ActiveToggle")

var current_values = ControllerValues.new()

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			clicked.emit(event.button_index)

func post_initialize():
	controls["Identifier"].connect("text_changed", _identifier_changed)
	controls["Stiffness"].connect("value_changed", _stiffness_changed)
	controls["Damping"].connect("value_changed", _damping_changed)
	controls["Mass"].connect("value_changed", _mass_changed)
	set_control_values_to_current()
	
	active_toggle.toggled.connect(_active_changed)

func set_control_values_to_current():
	controls["Identifier"].text = current_values.identifier
	controls["Stiffness"].value = current_values.stiffness
	controls["Damping"].value = current_values.damping
	controls["Mass"].value = current_values.mass
	active_toggle.button_pressed = current_values.is_active

func _identifier_changed(new_value):
	current_values.identifier = new_value
	values_changed.emit(current_values)

func _stiffness_changed(new_value):
	current_values.stiffness = new_value
	values_changed.emit(current_values)

func _damping_changed(new_value):
	current_values.damping = new_value
	values_changed.emit(current_values)

func _mass_changed(new_value):
	current_values.mass = new_value
	values_changed.emit(current_values)

func _active_changed(active):
	current_values.is_active = active
	values_changed.emit(current_values)

func _recalc_critical_damping():
	current_values.critical_damping = 2 * sqrt(current_values.stiffness * current_values.mass)
	controls["Damping"].max_value = snapped((current_values.critical_damping * 1.2), 0.1)
	_damping_changed(controls["Damping"].value)
