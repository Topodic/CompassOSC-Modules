extends ModuleControlBase

signal controller_values_changed(index, values)
signal controller_added(index)
signal controller_deleted(index)
signal controls_reorganized

@onready var controllers_list = get_node("MarginContainer/VBoxContainer/Controllers")
@onready var add_button = get_node("MarginContainer/VBoxContainer/AddControllerButton")

var base_controller = preload("res://modules/BasicMotionPhysics/SpringControl.tscn") 

var _dragging_controller : ModuleControlBase = null

func _ready():
	add_button.pressed.connect(add_controller)

func add_controller(
	identifier : String = str(controllers_list.get_child_count() + 1),
	stiffness : float = 0.5,
	damping : float = 0.2,
	mass: float = 2.5,
	is_active: bool = true
	):
	var node = base_controller.instantiate()
	
	node.current_values.identifier = identifier
	node.current_values.stiffness = stiffness
	node.current_values.damping = damping
	node.current_values.mass = mass
	node.current_values.is_active = is_active

	controllers_list.add_child(node)
	controls.append(node)
	node.initialize(module)
	node.remove_button.pressed.connect(remove_controller.bind(node))
	node.values_changed.connect(_on_values_changed.bind(node))
	node.clicked.connect(_on_control_clicked.bind(node))
	controller_added.emit(controls.size()-1)

func remove_controller(controller : ModuleControlBase):
	var index = controls.find(controller)
	controls.erase(controller)
	controller.remove_button.pressed.disconnect(remove_controller.bind(controller))
	controller.queue_free()
	controller_deleted.emit(index)
	
func get_controllers():
	return controls

func _on_values_changed(values, controller : ModuleControlBase):
	var index = controls.find(controller)
	controller_values_changed.emit(index, values)

func _on_control_clicked(button, controller : ModuleControlBase):
	var current_index = controller.get_index()
	match button:
		MOUSE_BUTTON_LEFT:
			controllers_list.move_child(controller, current_index + 1)
			controls = controllers_list.get_children()
		MOUSE_BUTTON_RIGHT:
			controllers_list.move_child(controller, current_index - 1)
			controls = controllers_list.get_children()
			
	controls_reorganized.emit()
