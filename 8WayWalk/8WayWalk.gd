class_name EightWayWalk
extends CPMOSCModule

class Motion:
	## Absolute x, y, z
	var world := Vector3()
	## Relative front-back, left-right
	var player := Vector2()


class Rotation:
	var degrees := 0.0
	var radians := 0.0


var velocity = Motion.new()
var body_yaw = Rotation.new()

# Forward relative to the player
var forward = Vector2()
# Right relative to the player
var right = Vector2()
var body_yaw_xform = Transform2D()

var current_mode = "walking"
var current_dir = "forward"
var active = true
var walking = false
var running = false
var sneaking = false

func initialize(client : OSCClient, manager : CPMOSCManager):
	super(client, manager)

func _physics_process(delta):
	if !_initialized:
		return
	pass

func on_disabled():
	send_message("walking/" + current_dir, false)
	send_message("running/" + current_dir, false)
	send_message("sneaking/" + current_dir, false)

func on_message_received(address : String, arguments):
	match address:
		"/cpm/moveAmountX":
			velocity.world.x = arguments[0]
		"/cpm/moveAmountY":
			velocity.world.y = arguments[0]
		"/cpm/moveAmountZ":
			velocity.world.z = arguments[0]
		"/cpm/bodyYaw":
			var yaw = arguments[0]

			var _bound = fmod(yaw, 360.0)
			body_yaw.radians = deg_to_rad(_bound)
			body_yaw_xform = Transform2D.IDENTITY.rotated_local(body_yaw.radians)
			forward = body_yaw_xform.y
			right = body_yaw_xform.x
		
		"/cpm/vanilla_pose/name":
			walking = arguments[0] == "WALKING"
			running = arguments[0] == "RUNNING"
			sneaking = arguments[0] == "SNEAKING"

		"/cpm/gameTime":

			var velocity_xz = Vector2(velocity.world.x, velocity.world.z)
			var norm = velocity_xz.normalized()
			var new_forward = forward.dot(velocity_xz)
			var new_right = right.dot(velocity_xz)
			
			velocity.player.x = new_forward
			velocity.player.y = new_right
			if velocity.player.length_squared() == 0.0:
				if active:
					send_message("walking/" + current_dir, false)
					send_message("running/" + current_dir, false)
					send_message("sneaking/" + current_dir, false)
					active = false
				return
			var dir = get_movement_direction()
			var mode = "running" if running else "walking" if walking else "sneaking" if sneaking else "walking"
			
			if dir != current_dir or mode != current_mode or !active:
				active = true
				send_message(current_mode + "/" + current_dir, false)
				current_dir = dir
				current_mode = mode
				send_message(current_mode + "/" + current_dir, true)


func get_movement_direction():
	var _forward_left = Vector2(0.707, 0.707)
	var _forward = Vector2(1, 0)
	var _forward_right = Vector2(0.707, -0.707)
	var _right = Vector2(0, -1)
	var _backward_right = Vector2(-0.707, -0.707)
	var _backward = Vector2(-1, 0)
	var _backward_left = Vector2(-0.707, 0.707)
	var _left = Vector2(0, 1)
	
	var dots = [
		["forward_left", _forward_left.dot(velocity.player)],
		["forward", _forward.dot(velocity.player)],
		["forward_right", _forward_right.dot(velocity.player)],
		["right", _right.dot(velocity.player)],
		["backward_right", _backward_right.dot(velocity.player)],
		["backward", _backward.dot(velocity.player)],
		["backward_left", _backward_left.dot(velocity.player)],
		["left", _left.dot(velocity.player)],
	]
	dots.sort_custom(sort_directions)
	return dots[0][0]

func sort_directions(a, b):
	return a[1] > b[1]
