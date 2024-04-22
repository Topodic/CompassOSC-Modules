class_name BasicPhysics
extends CPMOSCModule

class Addresses:
	func _init(identifier : String):
		front = identifier + "/frontback" 
		right = identifier + "/rightleft"
		vertical = identifier + "/vertical"
		body_yaw = identifier + "/bodyYaw"
		head_yaw = identifier + "/headYaw"
		head_pitch = identifier + "/headPitch"
	
	var front
	var right
	var vertical
	var body_yaw
	var head_yaw
	var head_pitch

class Motion:
	func _init(identifier : String):
		addresses = Addresses.new(identifier)
	## Absolute x, y, z
	var world := Vector3()
	## Relative front-back, left-right
	var player := Vector2()

	var angular := {
		body_yaw = 0.0,
		head_yaw = 0.0,
		head_pitch = 0.0
	}
	var addresses : Addresses

class Progress:
	var front : float = 0.0
	var vertical : float = 0.0
	var right : float = 0.0
	var body_yaw : float = 0.0
	var head_yaw : float = 0.0
	var head_pitch : float = 0.0

class Rotation:
	var degrees := 0.0
	var radians := 0.0

@onready var control_list = $SpringControlList
var controllers = null
var progress = {}
var dprogress = {}
var d2progress = {}

var velocity = Motion.new("velocity")
var acceleration = Motion.new("acceleration")

var body_yaw = Rotation.new()
var head_yaw = Rotation.new()
var head_pitch = Rotation.new()

# Forward relative to the player
var forward = Vector2()
# Right relative to the player
var right = Vector2()
var body_yaw_xform = Transform2D()


var _scale_factor = 0.1

func initialize(client : OSCClient, manager : CPMOSCManager):
	super(client, manager)
	var sections = config.get_sections()
	control_list.controller_added.connect(_on_controller_added)
	controllers = control_list.get_controllers()
	
	if sections:
		for section in sections:
			var identifier = config.get_value(section, "Identifier", section)
			var stiffness = config.get_value(section, "Stiffness", 0.5)
			var damping = config.get_value(section, "Damping", 0.2)
			var mass = config.get_value(section, "Mass", 2.5)
			var is_active = config.get_value(section, "Active", true)
			
			control_list.add_controller(identifier, stiffness, damping, mass, is_active)
	else:
		control_list.add_controller()
	
	control_list.controller_values_changed.connect(_on_controller_values_changed)
	control_list.controller_deleted.connect(_on_controller_deleted)

func _physics_process(delta):
	if !_initialized:
		return
	for c in controllers:
		var identifier = c.current_values.identifier
		var stiffness = c.current_values.stiffness
		var damping = c.current_values.damping
		var mass = c.current_values.mass
		if Input.is_action_just_pressed("ui_accept"):
			progress[c].v.vertical = -0.5
		
		compute_vertical(c, delta, stiffness, damping, mass)
		compute_forward(c, delta, stiffness, damping, mass)
		compute_right(c, delta, stiffness, damping, mass)
		compute_body_yaw(c, delta, stiffness, damping, mass)
		compute_head_yaw(c, delta, stiffness, damping, mass)
		compute_head_pitch(c, delta, stiffness, damping, mass)

func compute_vertical(c, t, s, d, m):
	var vx = progress[c].v.vertical
	var ax = progress[c].a.vertical

	var vforce = damping_force(d, dprogress[c].v.vertical) + spring_force(s, vx) + (m * velocity.world.y)
	var aforce = damping_force(d, dprogress[c].a.vertical) + spring_force(s, ax) + (m * acceleration.world.y) + (m * 0.08)

	d2progress[c].v.vertical = (vforce / m)
	dprogress[c].v.vertical += d2progress[c].v.vertical * t * 10
	dprogress[c].v.vertical = clamp(dprogress[c].v.vertical, -1.0, 1.0)
	progress[c].v.vertical += dprogress[c].v.vertical * t * 10
	progress[c].v.vertical = clamp(progress[c].v.vertical, -1.0, 1.0)

	d2progress[c].a.vertical = (aforce / m)
	dprogress[c].a.vertical += d2progress[c].a.vertical * t * 10
	dprogress[c].a.vertical = clamp(dprogress[c].a.vertical, -1.0, 1.0)
	progress[c].a.vertical += dprogress[c].a.vertical * t * 10
	progress[c].a.vertical = clamp(progress[c].a.vertical, -1.0, 1.0)

func compute_forward(c, t, s, d, m):
	var vx = progress[c].v.front
	var ax = progress[c].a.front

	var vforce = damping_force(d, dprogress[c].v.front) + spring_force(s, vx) + (m * velocity.player.x)
	var aforce = damping_force(d, dprogress[c].a.front) + spring_force(s, ax) + (m * acceleration.player.x)

	d2progress[c].v.front = (vforce / m)
	dprogress[c].v.front += d2progress[c].v.front * t * 10
	dprogress[c].v.front = clamp(dprogress[c].v.front, -1.0, 1.0)
	progress[c].v.front += dprogress[c].v.front * t * 10
	progress[c].v.front = clamp(progress[c].v.front, -1.0, 1.0)

	d2progress[c].a.front = (aforce / m)
	dprogress[c].a.front += d2progress[c].a.front * t * 10
	dprogress[c].a.front = clamp(dprogress[c].a.front, -1.0, 1.0)
	progress[c].a.front += dprogress[c].a.front * t * 10
	progress[c].a.front = clamp(progress[c].a.front, -1.0, 1.0)

func compute_right(c, t, s, d, m):
	var vx = progress[c].v.right
	var ax = progress[c].a.right

	var vforce = damping_force(d, dprogress[c].v.right) + spring_force(s, vx) + (m * velocity.player.y)
	var aforce = damping_force(d, dprogress[c].a.right) + spring_force(s, ax) + (m * acceleration.player.y)

	d2progress[c].v.right = (vforce / m)
	dprogress[c].v.right += d2progress[c].v.right * t * 10
	dprogress[c].v.right = clamp(dprogress[c].v.right, -1.0, 1.0)
	progress[c].v.right += dprogress[c].v.right * t * 10
	progress[c].v.right = clamp(progress[c].v.right, -1.0, 1.0)

	d2progress[c].a.right = (aforce / m)
	dprogress[c].a.right += d2progress[c].a.right * t * 10
	dprogress[c].a.right = clamp(dprogress[c].a.right, -1.0, 1.0)
	progress[c].a.right += dprogress[c].a.right * t * 10
	progress[c].a.right = clamp(progress[c].a.right, -1.0, 1.0)

func compute_body_yaw(c, t, s, d, m):
	var vx = progress[c].v.body_yaw
	var ax = progress[c].a.body_yaw

	var vforce = damping_force(d, dprogress[c].v.body_yaw) + spring_force(s, vx) + (m * velocity.angular.body_yaw)
	var aforce = damping_force(d, dprogress[c].a.body_yaw) + spring_force(s, ax) + (m * acceleration.angular.body_yaw)

	d2progress[c].v.body_yaw = (vforce / m)
	dprogress[c].v.body_yaw += d2progress[c].v.body_yaw * t * 10
	dprogress[c].v.body_yaw = clamp(dprogress[c].v.body_yaw, -1.0, 1.0)
	progress[c].v.body_yaw += dprogress[c].v.body_yaw * t * 10
	progress[c].v.body_yaw = clamp(progress[c].v.body_yaw, -1.0, 1.0)

	d2progress[c].a.body_yaw = (aforce / m)
	dprogress[c].a.body_yaw += d2progress[c].a.body_yaw * t * 10
	dprogress[c].a.body_yaw = clamp(dprogress[c].a.body_yaw, -1.0, 1.0)
	progress[c].a.body_yaw += dprogress[c].a.body_yaw * t * 10
	progress[c].a.body_yaw = clamp(progress[c].a.body_yaw, -1.0, 1.0)

func compute_head_yaw(c, t, s, d, m):
	var vx = progress[c].v.head_yaw
	var ax = progress[c].a.head_yaw

	var vforce = damping_force(d, dprogress[c].v.head_yaw) + spring_force(s, vx) + (m * velocity.angular.head_yaw)
	var aforce = damping_force(d, dprogress[c].a.head_yaw) + spring_force(s, ax) + (m * acceleration.angular.head_yaw)

	d2progress[c].v.head_yaw = (vforce / m)
	dprogress[c].v.head_yaw += d2progress[c].v.head_yaw * t * 10
	dprogress[c].v.head_yaw = clamp(dprogress[c].v.head_yaw, -1.0, 1.0)
	progress[c].v.head_yaw += dprogress[c].v.head_yaw * t * 10
	progress[c].v.head_yaw = clamp(progress[c].v.head_yaw, -1.0, 1.0)

	d2progress[c].a.head_yaw = (aforce / m)
	dprogress[c].a.head_yaw += d2progress[c].a.head_yaw * t * 10
	dprogress[c].a.head_yaw = clamp(dprogress[c].a.head_yaw, -1.0, 1.0)
	progress[c].a.head_yaw += dprogress[c].a.head_yaw * t * 10
	progress[c].a.head_yaw = clamp(progress[c].a.head_yaw, -1.0, 1.0)

func compute_head_pitch(c, t, s, d, m):
	var vx = progress[c].v.head_pitch
	var ax = progress[c].a.head_pitch

	var vforce = damping_force(d, dprogress[c].v.head_pitch) + spring_force(s, vx) + (m * velocity.angular.head_pitch)
	var aforce = damping_force(d, dprogress[c].a.head_pitch) + spring_force(s, ax) + (m * acceleration.angular.head_pitch)

	d2progress[c].v.head_pitch = (vforce / m)
	dprogress[c].v.head_pitch += d2progress[c].v.head_pitch * t * 10
	dprogress[c].v.head_pitch = clamp(dprogress[c].v.head_pitch, -1.0, 1.0)
	progress[c].v.head_pitch += dprogress[c].v.head_pitch * t * 10
	progress[c].v.head_pitch = clamp(progress[c].v.head_pitch, -1.0, 1.0)

	d2progress[c].a.head_pitch = (aforce / m)
	dprogress[c].a.head_pitch += d2progress[c].a.head_pitch * t * 10
	dprogress[c].a.head_pitch = clamp(dprogress[c].a.head_pitch, -1.0, 1.0)
	progress[c].a.head_pitch += dprogress[c].a.head_pitch * t * 10
	progress[c].a.head_pitch = clamp(progress[c].a.head_pitch, -1.0, 1.0)

func on_message_received(address : String, arguments):
	match address:
		"/cpm/moveAmountX":
			var prev = velocity.world.x
			velocity.world.x = arguments[0]
			acceleration.world.x = velocity.world.x - prev
		"/cpm/moveAmountY":
			var prev = velocity.world.y
			velocity.world.y = arguments[0]
			acceleration.world.y = velocity.world.y - prev
		"/cpm/moveAmountZ":
			var prev = velocity.world.z
			velocity.world.z = arguments[0]
			acceleration.world.z = velocity.world.z - prev
		"/cpm/bodyYaw":
			var yaw = arguments[0]
			var previous_rotation = body_yaw.degrees
			var previous_velocity = velocity.angular.body_yaw
		
			body_yaw.degrees = yaw
			velocity.angular.body_yaw = (body_yaw.degrees - previous_rotation) / 180.0
			acceleration.angular.body_yaw = velocity.angular.body_yaw - previous_velocity
			
			var _bound = fmod(yaw, 360.0)
			body_yaw.radians = deg_to_rad(_bound)
			body_yaw_xform = Transform2D.IDENTITY.rotated_local(body_yaw.radians)
			forward = body_yaw_xform.y
			right = body_yaw_xform.x
			
		"/cpm/yaw":
			var yaw = arguments[0]
			var previous_rotation = head_yaw.degrees
			var previous_velocity = velocity.angular.head_yaw
		
			head_yaw.degrees = yaw
			velocity.angular.head_yaw = (head_yaw.degrees - previous_rotation) / 180.0
			acceleration.angular.head_yaw = velocity.angular.head_yaw - previous_velocity
			
			var _bound = fmod(yaw, 360.0)
			head_yaw.radians = deg_to_rad(_bound)
		
		"/cpm/pitch":
			var yaw = arguments[0]
			var previous_rotation = head_pitch.degrees
			var previous_velocity = velocity.angular.head_pitch
		
			head_pitch.degrees = yaw
			velocity.angular.head_pitch = (head_pitch.degrees - previous_rotation) / 180.0
			acceleration.angular.head_pitch = velocity.angular.head_pitch - previous_velocity
			
			var _bound = fmod(yaw, 360.0)
			head_pitch.radians = deg_to_rad(_bound)
		"/cpm/gameTime":
			var velocity_xz = Vector2(velocity.world.x, velocity.world.z)
			var norm = velocity_xz.normalized()
			var new_forward = forward.dot(velocity_xz)
			var new_right = right.dot(velocity_xz)
			acceleration.player.x = new_forward - velocity.player.x
			acceleration.player.y = new_right - velocity.player.y
			velocity.player.x = new_forward
			velocity.player.y = new_right
			send_progress()

func _on_controller_values_changed(index, value):
	config.set_value(str(index), "Identifier", value.identifier)
	config.set_value(str(index), "Stiffness", value.stiffness)
	config.set_value(str(index), "Damping", value.damping)
	config.set_value(str(index), "Mass", value.mass)
	config.set_value(str(index), "Active", value.is_active)
	save_configs()

func _on_controller_deleted(index):
	progress.erase(progress.keys()[index])
	if config.has_section(str(index)):
		config.erase_section(str(index))
		save_configs()

func _on_controller_added(index):
	var c = controllers[index]
	progress[c] = {
		v = Progress.new(),
		a = Progress.new()
	}
	dprogress[c] = {
		v = Progress.new(),
		a = Progress.new()
	}
	d2progress[c] = {
		v = Progress.new(),
		a = Progress.new()
	}

func send_progress():
	for c in controllers:
		if !c.current_values.is_active:
			continue
		var id = c.current_values.identifier
		var v = velocity.addresses
		var a = acceleration.addresses
		send_message(make_address(v.front, id), progress[c].v.front)
		send_message(make_address(v.vertical, id), progress[c].v.vertical)
		send_message(make_address(v.right, id), progress[c].v.right)
		send_message(make_address(v.body_yaw, id), progress[c].v.body_yaw)
		send_message(make_address(v.head_yaw, id), progress[c].v.head_yaw)
		send_message(make_address(v.head_pitch, id), progress[c].v.head_pitch)
		
		send_message(make_address(a.front, id), progress[c].a.front)
		send_message(make_address(a.vertical, id), progress[c].a.vertical)
		send_message(make_address(a.right, id), progress[c].a.right)
		send_message(make_address(a.body_yaw, id), progress[c].a.body_yaw)
		send_message(make_address(a.head_yaw, id), progress[c].a.head_yaw)
		send_message(make_address(a.head_pitch, id), progress[c].a.head_pitch)

func make_address(identifier : String, controller_identifier : String):
	return identifier + controller_identifier

func spring_force(stiffness, displacement):
	# F = -kx
	return stiffness * -displacement

func damping_force(damping, velocity):
	# F = -dv
	return -damping * velocity
