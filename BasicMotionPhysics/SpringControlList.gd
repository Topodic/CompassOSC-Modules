extends ModuleControlBase

signal controller_values_changed(index, values)
signal controller_added(index)
signal controller_deleted(index)

@onready var controllers_list = get_node("MarginContainer/VBoxContainer/Controllers")
@onready var add_button = get_node("MarginContainer/VBoxContainer/AddControllerButton")

var base_controller = preload("res://modules/BasicMotionPhysics/SpringControl.tscn") 

func _ready():
	add_button.pressed.connect(add_controller)

func add_controller(
	identifier : String = str(controllers_list.get_child_count() + 1),
	stiffness : float = 0.5,
	damping : float = 0.2,
	mass: float = 2.5
	):
	var node = base_controller.instantiate()
	
	node.current_values.identifier = identifier
	node.current_values.stiffness = stiffness
	node.current_values.damping = damping
	node.current_values.mass = mass
	
	
	controllers_list.add_child(node)
	controls.append(node)
	node.initialize(module)
	node.remove_button.pressed.connect(remove_controller.bind(node))
	node.values_changed.connect(_on_values_changed.bind(node))
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
