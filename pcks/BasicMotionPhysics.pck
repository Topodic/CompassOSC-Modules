GDPC                �                                                                         `   res://.godot/exported/133200997/export-108ede1a8a7450ffd81a9134cec80e29-BasicMotionPhysics.scn  P      �      Q^N驒��)�j�by�    \   res://.godot/exported/133200997/export-35ff2bbe3bf1c2421cbc160bbcbbc8db-SpringControl.scn           �      g���c��ļ*��
�    `   res://.godot/exported/133200997/export-ef1d8f9c8499bcdb48634226fefdd4f3-ModuleControlBase.scn   �P      !      h�~��ۓ{���j     `   res://.godot/exported/133200997/export-f22fa40d7be8abc802cdcfb538c90ae3-SpringControlList.scn   �J      �      �l���`�i�vώ�     ,   res://.godot/global_script_class_cache.cfg  �     �      ��<�ש���I
c}         res://.godot/uid_cache.bin  `�     �      S�'�Q� ��b��g�G       res://Logging.gd``      �      �}|�9G��2�^m��        res://core/ModuleControlBase.gd �T      �      �h|8��D�/g5�G�\    (   res://core/ModuleControlBase.tscn.remap ��     n       C���q�_��Fz��o       res://icon.ico  Pf      �=     Fwtt�Ӳ�����z       res://icon.png  ��     �      ����`c/"z_��(�Y    8   res://modules/BasicMotionPhysics/BasicMotionPhysics.gd  �      1      ��k��@Wf�d�3N    @   res://modules/BasicMotionPhysics/BasicMotionPhysics.tscn.remap  ��     o       �P:��\�-���    4   res://modules/BasicMotionPhysics/SpringControl.gd   �      j      ��	��c~��U0����    <   res://modules/BasicMotionPhysics/SpringControl.tscn.remap   0�     j       ��a�2�F��I�!�[    8   res://modules/BasicMotionPhysics/SpringControlList.gd   PZ            E�(�-%�e�rݞ�;    @   res://modules/BasicMotionPhysics/SpringControlList.tscn.remap   �     n       �;�.� ����X�-       res://project.binaryP�     T      ��P�l;��*�m                RSRC                    PackedScene            ��������                                                  MarginContainer    ControllerVBox    NamespaceHBox    Identifier    StiffnessHBox 
   Stiffness    DampingHBox    Damping 	   MassHBox    Mass    resource_local_to_scene    resource_name 	   _bundled    script       Script 2   res://modules/BasicMotionPhysics/SpringControl.gd ��������      local://PackedScene_m88it �         PackedScene          	         names "   '      SpringControl    size_flags_horizontal    script    control_nodepaths    PanelContainer    MarginContainer    layout_mode %   theme_override_constants/margin_left $   theme_override_constants/margin_top &   theme_override_constants/margin_right '   theme_override_constants/margin_bottom    ControllerVBox    VBoxContainer    NamespaceHBox    size_flags_vertical    HBoxContainer    Label    text    Identifier    custom_minimum_size    tooltip_text 
   alignment 	   LineEdit    HSeparator    StiffnessHBox 
   Stiffness 
   min_value 
   max_value    step    value    custom_arrow_step    SpinBox    DampingHBox    Damping 	   MassHBox    Mass    HSeparator2    RemoveButton    Button    	   variants                                                                                                      	                           Identifier: 
      C       
      �   This represents what identifier this
controller will send its messages under. 
For instance, setting this to "Cape" will 
send messages like "/phys/acceleration/
verticalCape", so you can organize 
appropriately. (Empty works, but is not
recommended.)       Stiffness:    �   This value sets how "stiff" the spring motion
is, in other words, how hard it tries to return
to its resting position. As such, higher values
will make the oscillation faster. )   ����MbP?      A)   |�G�z�?)   {�G�z�?   	   Damping:    �   This value sets how "damped" the spring motion
is, in other words, how quickly it loses energy as it
oscillates. A value of 0 will cause it to oscillate forever,
and higher values slow it down faster.       Mass:    �   This value sets how "massive" the spring motion
is, in other words, how resistant it is to changes in
movement. High values will make it tough to get
going and vice versa.      �?
     �A  �A      -       node_count             nodes     �   ��������       ����                                        ����                     	      
                       ����                          ����                                 ����                                ����                        	                          ����                          ����                                 ����            
                    ����                                                                     ����                    
             ����                   
          !   ����                                                     "   ����                                 ����                             #   ����                                                           $   ����                    &   %   ����                                     conn_count              conns               node_paths              editable_instances              version             RSRC  class_name SpringControl
extends ModuleControlBase

signal values_changed(new_values)

class ControllerValues:
	var identifier : String
	var stiffness : float
	var damping : float
	var mass : float
	
	# Dependent values
	var critical_damping : float

@onready var remove_button = get_node("MarginContainer/ControllerVBox/RemoveButton")

var current_values = ControllerValues.new()

func post_initialize():
	controls["Identifier"].connect("text_changed", _identifier_changed)
	controls["Stiffness"].connect("value_changed", _stiffness_changed)
	controls["Damping"].connect("value_changed", _damping_changed)
	controls["Mass"].connect("value_changed", _mass_changed)
	set_control_values_to_current()

func set_control_values_to_current():
	controls["Identifier"].text = current_values.identifier
	controls["Stiffness"].value = current_values.stiffness
	controls["Damping"].value = current_values.damping
	controls["Mass"].value = current_values.mass

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

func _recalc_critical_damping():
	current_values.critical_damping = 2 * sqrt(current_values.stiffness * current_values.mass)
	controls["Damping"].max_value = snapped((current_values.critical_damping * 1.2), 0.1)
	_damping_changed(controls["Damping"].value)
      RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script 7   res://modules/BasicMotionPhysics/BasicMotionPhysics.gd ��������   PackedScene 8   res://modules/BasicMotionPhysics/SpringControlList.tscn ,IA@-��E      local://PackedScene_8111x �         PackedScene          	         names "         BasicMotionPhysics    script    module_name    module_description    module_version    module_author 
   module_id    module_namespace    module_git_repo    has_config    Node    SpringControlList    visible    	   variants                       Basic Motion Physics    �   Allows for basic control of animations via in-game movement, which should enable making much more natural movement for things such as tails, capes, and other such dangly wobbly bobbly bits.             Topodic       topodic.basicphysics       /phys    .   https://github.com/Topodic/CompassOSC-Modules                             node_count             nodes     "   ��������
       ����	                                                    	                  ���   	         
             conn_count              conns               node_paths              editable_instances              version             RSRCclass_name BasicPhysics
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
			
			control_list.add_controller(identifier, stiffness, damping, mass)
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
     RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       PackedScene "   res://core/ModuleControlBase.tscn u)���-u,   Script 6   res://modules/BasicMotionPhysics/SpringControlList.gd ��������      local://PackedScene_r5128 k         PackedScene          
         names "         SpringControlList    anchors_preset    script    control_nodepaths    control_collection_type    MarginContainer    layout_mode %   theme_override_constants/margin_left $   theme_override_constants/margin_top &   theme_override_constants/margin_right '   theme_override_constants/margin_bottom    VBoxContainer    Controllers    HSeparator    AddControllerButton    text    Button    	   variants                                              Array                   +       node_count             nodes     F   �����������    ����                                            ����                     	      
                      ����                         ����                         ����                         ����                         conn_count              conns               node_paths              editable_instances              base_scene              version             RSRC  RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script     res://core/ModuleControlBase.gd ��������      local://PackedScene_pm0qp          PackedScene          	         names "         ModuleControlBase    custom_minimum_size    anchor_right    anchor_bottom    offset_bottom    grow_horizontal    size_flags_horizontal    script    control_nodepaths    control_collection_type "   metadata/_edit_horizontal_guides_    metadata/_edit_use_anchors_    PanelContainer    	   variants    
   
          B     �?   9�H=   s�}>                                    �            node_count             nodes        ��������       ����                                                    	      
         	             conn_count              conns               node_paths              editable_instances              version             RSRC               ## A very general base class for module controls. Useless if not extended.
class_name ModuleControlBase
extends PanelContainer

## An array of paths to [i]relevant[/i] control nodes, ie sliders, input fields, or other ModuleControls.
@export var control_nodepaths : Array[NodePath] = []

## Whether the controls you wish to track will be in a Dictionary or Array.
## Dictionary will be more useful for controls with specific, known names,
## while Arrays will be more useful when you just need an easily-iterable
## list of the controls.
@export_enum("Dictionary", "Array") var control_collection_type = "Dictionary"

## A collection of the actual controls linked to by the above.
var controls = null
## This control's respective module
var module = null

var _initialized = false

func initialize(module : CPMOSCModule):
	self.module = module
	assert("control_collection_type" != null, "Control collection type not set!")

	match control_collection_type:
		"Dictionary":
			controls = {}
		"Array":
			controls = []


	for path in control_nodepaths:
		# Just skip empty paths.
		if !path:
			continue
		var node = get_node(path)
		if node is ModuleControlBase:
			node.initialize(module)
		match control_collection_type:
			"Dictionary":
				controls[node.name] = node
			"Array":
				controls.append(node)
	
	print("Controls connected: " + str(controls))
	_initialized = true
	post_initialize()

func post_initialize():
	pass
            extends ModuleControlBase

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
             # A simple logging utility. Uses a fair few bitwise operations, recommend
# knowing what those are if you plan to edit this extensively (or are just
# curious, they're handy and neat).
extends Node

enum MessageLevel {
	INFO = 1, 
	DEBUG = 2,
	WARNING = 4,
	ERROR = 8,
	INCOMING = 16,
	OUTGOING = 32
}
var logging_level : MessageLevel = 0

func write(message : String, level : MessageLevel = MessageLevel.INFO):
	if !should_log(level):
		return
		
	var from : String = ""
	if EngineDebugger.is_active():
		# Fetches trace of caller for logging clarity.
		from = get_stack()[1]["source"]

		var split = from.split("/")
		from = split[split.size()-1]
		
	var level_str = level_to_string(level)

	var final_message = "[{level}] {from}: {message}".format({"level": level_str, "from": from, "message": message})
	if level == MessageLevel.WARNING or level == MessageLevel.ERROR:
		printerr(final_message)
	else:
		print(final_message)

func should_log(level : MessageLevel):
	return((logging_level & level) != 0)

func set_level(level : MessageLevel, enabled : bool):
	if enabled:
		logging_level |= level
	else:
		logging_level = logging_level & ~level

func level_to_string(level : MessageLevel):
	var string = null
	match level:
		MessageLevel.INFO:
			string = "INFO"
		MessageLevel.DEBUG:
			string = "DEBUG"
		MessageLevel.WARNING:
			string = "WARNING"
		MessageLevel.ERROR:
			string = "ERROR"
		MessageLevel.INCOMING:
			string = "INCOMING"
		MessageLevel.OUTGOING:
			string = "OUTGOING"
	return string
                        e�  f   ��     ( ˸  @@     (B  �� 00     �%          �  �(      h  k9 �PNG

   IHDR         \r�f  � IDATx���I�m[�&}c�9W��>��{�{����pD8ۉ-gd�v"7l�H ٤d	�6�Aа��G)
!@����7h�A!��̴($rIdD$������W1�4�k͵�>�}����{�}����Ƙ���7��^�~�����?� ~�� �m~��	�P�?'��!��wND@ڈ`b���P�0��	n��8?��	FH��>��4� ��_ �c �����q�� �]�?��?�-z�����Kk�O��_�_�i  ��d�~ ��7V�
��{�`����4�g�u�g�RU��=��$o Y������`��o8 �p�}��EJ�V��M~���?�_���T|=�m���7���?����BD���_�7�=������0� �R�����Q����E=���t�����􍪂I�%�*�"p��4~u�� *^�A
������|d�Q)P+PD�?��G8 ?���l�{"�9DxR�kg����߹����g y�덣�� 2��
��P���0�A���@�TS���oB���K ��x��z[s����?*
U��B$@D��@���'�aB=�h|��0�+�C Mg�F o|�����)���� ��o��hxK䯉�RկTq��yW��w8|�G�Y
��� �i���� XUT@܈�k���(�U E��c�q��S�b�1���A� T��Ws�_W��$A��!"���G�a��@��T`$��:x4�щG+�
��	��@�0]6�Q��j#�& x1GD�l jR=v@_�NxV ��gyZ�kg B��~M�a�C��wy#B���w�J*
Q�JD0����mU�Ue�r�\kv��0�#��}�J�EZգE�U�����B��ӄi0=&(�x� &�~B�'t~�6l$�A���� �iAU�
D�v�b !
��u nHu���bU`Ը�{���iɯ�P}pq2�+�"o�ئ�ժj��=��TU�c6m媋�m^6m�����U���Tl�Pv�U��7�� a)��8_��=��	� ���h Z?b�'���"l5�J6%i>x@(j� ��tpy&%�IՂ�U`�-ox��; &��������Y/�v���tn�W ^x`�E�n�r`J%""b�̵un���n��.���lۺ�����f&��I�C��)�Oy9�2�PA�=�0`8�q�G�~@?0&(D<l����4b<.%�JB�`E`��� Uy���6{ (M���Z6��kZ*�I%`0үa^�K�_;`��gP#�KD�3 _#�x6�Z��! �11	`�uκ���k����v��v]�6u]W�CDU �����@%��D0/� 	ӄ�?�x�p DpO �H��@�Gl��]�Ԁ�x���*ZU8D/ �[�D�
��HT큍<Ց�5���]p4ǐ&0��1����_;������ h���@?��;U�EԦ8^�H�a���Yk�s����m�z��T��z�۸�m�s10 �}�4� 1 ("��Ǣ���q��!�����w �0	�aB�Gl���\����P\hUQ'l #�  �b$�07@E���#�ڤ��!�)�)*��]���g�E�g ~D�}��u���_����������?��ҿ�����9�QK��-���W �Iۅ�4"jE4� b���r�#�*����ucڶ5���\�vf�鸪*bc��)`��lD�`%#�Ph�C��X	�� ijg!&V���ц��߄��*. \�pE@��C4 @L�{ @�T��\�b�&K�1D�!� �h�7F�"c��%_�x ��]�O?�Jk�����[�����S���oQZ�[kͅ�抙_�]x� W�^�j���	3��r�4꺦����k��M�PӴԶ-�u6PB���)`�<���������X�3���u��9L� pTe�UA��V҆\�Pt lTQcQ�,�X�$"�U��������=�N�$�w��,_�|q�u|`��[J�+B	"��L �2Sm��`6��ʽ�ּ0�\і�:"j4�Q��D` &&v֡ijt]��iQ�5���s�sp��u�#"�Y
 �;  �&��9�֢1#x�X��h�(jDE/O�����6Æ����l*�*U �p��*`@d�*W� <{ _�|q�u���_���@�~U�EDCUUQ%"�>T"�e�+���u]_U��YkZcLEDL�;g�E"(��a�A]W�l:t]��iQU5�u0�F��;{��`V�10 ���G�� U�Xc`��Q1�f��D�4�Y���(C��xT\DCK��5fQ�=ь��߻3~�/G�8�@�\�2}�!ְ�TV�U% Ж�.��Wm[�j�梪��9WYS���k�e��0�9��m�u���u.�� Hz_F��D�OyJT4�(��R��K�����r6� ���ᨰ���D������䴟R�k��И�������� |Y������� \"&�^!��. ��pQ�8g�5%��Ƙ��vW���f�]v]�5M]9�s���T�H� "�5u]�i�uk�D	!(&�X8G4f!h|B�ƀ���5�a�1���.))�!L��h��VDp�5z�o>waq������a���=�/R�8��:�)����oU5��J�*D�ư�l;cL]U�m��뺶���v]�UMSkm61��>�̰֢�*Tuk����>D%N+�(� Epo�hl �[�sRl�$�@�a�Q���E+�C2�S���r��(5B������e�g Q�g,9����� ^�,~���Kb�Q�,���9k�sU�TU׵�v��v�m�u�q�3C	�0yA�A4��3�Z�n� D�r�U*HaD6 E�2 ��H䜀`	1.g�2��&��?3�8q�n��/^��Mp� LD��XD�?� ����9��ɓ3 ����x��R�j��+|���������C��^��iKe<��� ưTU�UUQ]W��+��ڴmc6���v��l��+2�PL>��2�'��D�h�_��2��r�4 �?�bCZis�^
�IJk�a!0�,��{/�L/v;�)?�����  z�Ƴ<yr�:������w߽�8���m����n6]��{e�`�+fz�"\t��P�VUl����9�%���VS��h��ڶ��k���X�S��X�Gk �b���yE��,�V�BN�IbM�R� ������1����9�*���lX$�1 � ?˗#O� <T�A���v���Zk�����3��Ƙ+c��Ue�2ƾ0�/�y�L@-��'��F��9f�k�v��]עm4M=���ʁ�@`�X�֜���d#p��?���u�BSV2"h�3��a���}�)���8�� ����%;
�c����a	����g���������!NI��9���&��A.D����}�4�K�܅s�5�T�̔���K���s΢�kl�v[l7�.��rp���+�2`X��s��uv���8���`D&`PR���x�;���)�>�����dC��S6>���Y�yr�:�}QMD��4�.Uq��W ���s�U]ׯ�����zSU��6��.���]g&cPU���v��fۡmTUk��Ǟ��q�&�h�ػ}>s�P�q��B�)���S��W qA���?�*�^�yZ�Kp��s�Eɓ3 Ő�d��2�7��b�Wy#���t��W�ګ��.����l�M�6UUU�Z3�j�j�����
m�b�i�4���Z���ޓ7�u�N�����xǹ���"��J�P��Hʗ�P�{-�� �E��ʿy�/K��x��OD�Z[����������3c�+c�kͅsv[����n��6�mW�v\c�H����s�k����4��!�f*��IH@�S#P���ˌʌ�E`�9�>������J��?�#O� <T�VՊ�[U�`��Ƙo��?w�~c��r�m��uu]�m�V�mg//c;n]�W�Y[��E?z�����/�H�Xyc}^
��i�"|�d�~l��!>~U	��	"�P���m'C@~�����
�e���g�r���Z��e�.٩�%3�`6_����vWU�6UU�u]ۦ���Z�l6��6�4�d^�Y���~�l�*���\��ܩp��)��5��,� �"P�À0�� G�4ރB K��� �N���rZ�'��H�l���U�y��(R�B��^������?��q���J�������܀'&�� |�:�y!�/ �L�k틺vWm�^6M�6Mm�B]���4ڶ�sK���e�M��(K{T*Q�֥�����Wg�^�>� 2����� ����?� �Fp2N.��E򨭏6d��
��i�}Pf��!"�F�.�n�ݵ���_i[s�{��_�x,��z�~��ĳ| ������͕s�kf�1��si��9纈�o���3��ߦ^����\k��$��l��I�%��x	s2���`���G�4�om��|��䏜XL�E���G��C���5��k�7Лk�q3��i�I����S�i@��c�T�+���"��a�r�M�sT_�"�ADUW��|Uި��h ��9ԑD�yn����<X�W���U]W�T�{霻�*�V����i��Z�v�D�Q�ߤ~�,ݜL?}&�N�y��"��#Q�2�(%R�H�A�`ҙ⻬�/�gI�k��O�!��c��?�����p���Л��wo`n�a��q���P� u& �>�(]�8�(�a$񜉌*�"�VT/F�eP�&UT�W��n�|ê{�[�����OH>�x\?�}u~�b�ιWmۼj��i�M��u]�&�v#�o��V-���3"����>}8�J�f!���r�O��3@
���8��bҐn��^�0D$u ����#��������;��5ps�~��-�wo`�������4��� Ԣ�5�̜ ��?9�wI�g�UX"�D��
l<p	U/ yU�N�o,�&zk��k�鏞���'7 ����2�u~"�2����]�ms��n.6�v�u]ն������u;�RG(�媡9���'�p�`�A|'��^� ҅ $���c?V(��M]ӄ��1�opx����߾A�~�~{s�f������=��n��: �!@fzJ/��Tb$IS��a�` ���>�!�IB@+�V�mhMdf��܀�=��On W痚�su~~a���*�m�z��t��Ŷ��6u�u�nj��u�Xc�������UaX#`�0J�7��g���:?saHJ����@���"�HKj����(�i����\���5?|�����o߀�ߡ>܀{T�#h8��iD7Mh|@B�P����������
L9󟛋��DF�z���J�V��
\h� :\�(z C�?⑹�g�4���O��;箪�m���ڶ�7�����ڋ���n7\�59v(�d5n>(DcǞ�X�
èBML�-��x@K��8Ȍ}���*4PI,©d��@�H?��J��8�3����c������^�������� �y9�a�#dA��=�Є�Nb���:�&�Y����#�4OD���@EqV�F����i��iA�)r4<�=1���������r���ꦩm׵��t��m��n�ij�� ��[!��9;7� ��$/�|[kdO!�2�?z�E@b�I`��� ���Ws��/�?Ǿ�p�A}��78�}�����w���8@&�&��V�����1�c��%�'�4�("
�qDl�,�`n��4��8��` ����!�U�g����Q�g6/T������m.۶i��1�Wm�$"��s��A@�@�#@���G����`&�Ӥ`��0�^B4����Y�}��S��!���M=�8�s1C܎G�#��CJ����U���@�s��a��>�%�>F��<.Y#�'�؂�gď���43��a�F���y{��&� |�:���kc�:�1��_׮mۦ��6f���v���w�#�}��4�JrQ�!.� !PD���lǑpX{,+�I�P"�����E��c'���4��  ���H�~��c<��=����?b쏘�#d�a�H��/�X#��Ҳ����@���KXz*"�<� ˪o�4ĳ|b��������r�TU����:�m[�v�������0 �_ߚe�!ʐ���'�M��SRʄA��ʱ���nF�F
.��\3�@�i�0�~�8���
My��4`�p<����0`F�i��	|D��u�=˯�|p���U����e�6���릩M����u��`������t��_��c��t]�VMF���7L+�ϽI�tëF�^��F}��a�0���� )�"�q�t��?�x8bL��=B�G@fh��R�,?U>��0u~���u��w�ͦ�ڶ�9֏@�]�	;̪ŷl�Ej���Z  Q�OW֘4Y���0�a��Ӓ�[!
OW����pD0�S��k6 �sD ~�?01FL�B�&$$!��$ݳx��"� |�:�sn�4�f����]��m�ͦ3m�$��MS��i����*QGQß��i����'`��]x���ri/��.���]�E��q�0���#����8!� ����P�'���1�a��C��&^�D����|��Y��7 ���<��m�z�i��nc///�n��m(+}��50�v�C4��JRr�Ű]b]@55�b��g�=�%�8d�LDr���T(�0��cR�x8�p8b�8@���b��� C��c�q����ڃgBPf�*Hd���l����{�O��_�զ��ij۶K���R׵�"��̹Eroa�)�d���/	AZ�մ��e�Ø%��bro6 ��1�cL��~@�sV�x��<��  x����q�OU��z9��T��n�����g�������mmb����I:]Z������E�*Sgύ;���E52�&ؚK� 0&+}�H�{��n�0�8����d�0#�a��! P ��NQ����R��ک�Ε��؛��Ex�O%�m >E��ݘͦ�f����:^�#Է������^����PP^B *���2�F�<�������ǾG?��	�O.}8	��|�����&���"�Oy�&Oi�?G�\�|��=�R��l�:�̛�����%�{������K&_�ȱC��<��փ?$��$�����C��>����i�|�!���8�e��͹�u���>�b���VJ�p�X�U����6 ����b���u���ҪϷh�V>7�dn�s��q@'�j��o?V�B�������L�&e�G�������#�c���)'��kw��˶�\@KKr��8�٧����4��ͳ'��������x������9␌�*W�����'�0%E�ܿO�ɳ�UBo�FL㘾N��9!��r�χX����P��y!����������HeY�ή�8��S��y}�����g��������3���˟c~A	�9U~ ���ݯ/�� ɏ�@d���"���(�~�&�T��I�dB� $�f	2��3�ʹM�`�#~�m.=�Hh.�a��S�y}�3�����t�����GN�X�4�� ,	��k�|��~}V�,\�yK0��)�?����1�7b�K�>{R�?�774`�p�"��D�g*`�Di���bx�����h)� �ls�PJlƴ�IE�
����u���,���[��v�~��~��E���u�ޖ���{�Q|	�s<R?�y�)�!��?e�.��L�JiV��,���Sx)&2�CyR/���y�'v��B��R�[�$݄�eH5��yv���[�����D�mN�|}(9�i�~Y���}S�n�ߧ	�4��0��X�K �áG<���8��|)1���8*�1����qrN��gbp�L
�s:nN�FN��-=h��G�4>��}����2oDp����!���I����-�t���,>�v��z��4�}B�G�W�ajo�������q��c� �_���q����E��r$_`��#��C\I��B�P1������g`���K<�q%z!��t<5B>^ ���ĨΜ`��t�}=�OX珏J�d��cdɥ�GzA*���l}��3�/��q;�	�;`H��S�^*�C��w�>��1���@T�����Yi��kz��dMR��(��<��c���#���Xj"�̐t��h5��:�){��/��S��/ pw��a�[vJ�]��Ƚ	cj؉�~T���@<1������4ͥ�D�^�3��9�7�y�$�%��C)�CN��� ��}E��	j!T�D՝�?����	B畿"B�����c� �V,y��t�x*u�%3��Yy ����_�O
��fp<.!@���C
@�<H��Q�Y�1�XU �^�7��O�	�pĨ���!�^ �P�~|����d����!��� DV�x^F���*�Ӓ[�)��#�6kI9r��K�!��Ɲ\�;��ȡ@?$埉94g��W� �2Tt����\��[6U�T^�̿K�M�f%�oZ�~l9M��@r�B�	bX��g��r� <�:����,3�?}��{?�u�aD�b��>�vR��g��' 1����s0�����9���@�KƀR�T��<
���ϊƧ9�%H�hq�T�"�&��r���ѳ<�'u�']��U�4!��+����R_"��1�7'����}�oi���y�7k`}N:{�^�	��9P�T�" pj<b��>�f7�{G�9 �	7�G����d#�s |b ʰ�9��\���O��_�~�q���v|q�u]��D�1�^����ާ�߮��l��!)�g�E��8MK������T�Ϥ1�g2N�}���F�r�_Y�/�D����%/r��S�_5���A!�$�yD����(~Rƌx�T��-�O��5$N!�� <� ONN d����FU-3;km�#���2�}MD_1SQ�]UUm�֫:d�mfοp�-tڷ�,��왇i��[���r�8L8{���S��p8΀�!�|�%�È%{��{E�^l,�y0�ǌ�I=J��W&x���i�	6x��UX�豈Xʎ	{������b˫��ƍ�Z*�tF�Y'g ��*c�RE�L].��`���W��o��/����:UUܶm6݊��m3o��c�5h'��	:���.�/*K�?+��gps���f�����'6��uw�����M�+�@Ѕ�0{s��LT������ &�8�3�B29Z@����^>�V��M^V| UR��y0�ӓs %wi`�����Dte�yY�����^�u}Y���i���kӶ�u��ܛ�<֠��9���Otd��9�C��#���?��9��f��>%��� ��2�|V1�8"s�~	��^d��a����(�
+!L�i O#�4"x� a5 �gc~�����3�ٳ<99g j�6Dz�%���F��p�l���WM�\n6�E׵��k��ml�,���uuk�/�x���߽�e�_��\QAR�,@=Ǩ���!��S��|b^`��k���f��$"+#�T#/0� �x��0� 秹�XN�DV��[���N���t�@L:w .��� ~�k"z����m�ԛͦ�v�m��m��L��g���(����	%�-9����e"O��\���1��׹Ο�~���l�n)��/�y�_<��
�~V��Z�_���0 �e�@%���GT~���9�<��ߡ����8����?�=M�� ������ � x�L[cLWU�nۦ�n7��bw�Ο�����x��[cޟ-������1۟W�c���z���=nn�s��c���O��ov�S;g�����<r��& ��r��#�i�	�fe^<���
 &T��0y%��xV��dβ�p��,OG�&'�6��ݳx���b9���Z��n;�v[�`]�/�Ғ���'���ט��K��b�}b�=.��8.�7f7;���x|�ۙta�]0^}�¤����M@�\��FcB,N<�0Q�!�j�N�ּ�OK�����w���gy:bo�����@�
l�@4 6D��k�ʡ�����U���I7�a'�w�Usl��_^���)�3u��������x<&�ߴ��$,YՈ�K����������҇�Jgr����{B����5��DD�P��
@�"$�YC0����ʑ����C+���?�c�3 )*�
��0ê�K[��s[wF�e7�9�6[��&ν� �ޝ���cm]y��bL2�^��[���v���2����uO?�@��(x��~�ē}Q���%j�C�H�B�/"^�TE��| D��r�`U���
*�I���N�ҟ����G����g&��xu7#��Ċ����ZS�ID��O{ybN���R�1�µ�	N���V�1�L��-?IF�!��~��7���\矇s��D��L�%�b�Fd��8	(�K�$4��!!�0	� �$D�AT�"ҋ�T}���$
J���q�I�3*Vݰꆢ��
�Hs�ͧT�s�
̱���9�v��Y����ܒ%>�W~$�,	/o���bM�!��s��>H1�
�%!��$O�I8W��.@N�MӔpf��������Z�~�~3�_��[��䯁��.B��-���K�1$ADE$�U_"ᝊ��w�z��{Q�Eu��_!()�l��U��ƪ\X�K�2�8��d畟�l��+�7��,����� OJ�����ѯ��*���N1�:���+)����@�3�.z0@��WNk��K����C1y��b��!�|����{�_��y����(B�-ǐŲ���@qT%�Ȩ�y�*�C�{U}�;(�'P�q1g���X�s*�����TA�B���s2ղ�f����\r�ꞕŵ~��!�v=�`ҁ.��3Ȼ(�R��A ����*!��ԂØ����foa)�Ř�"k�ͼ��WJ �n��ǯ��F�y:���%�Px�%�7��4��ç�TuTՃƕ�{���� ��Z��4�D~"V���U���T^lD�N�k�کv�2T�L��:���>s&~�c}���S��/����*���&�cy��'�A@	��i9���� ��a\�%��Ȝ�2_��Jl��\�����֛\�y*+�?�i�\L��"q:o����a����t4%)�zT���|K�?#��	�N��H<�xP�_mU���w�ć��Væ�pQ�Ne2qVi,������t���X���w�����Y/��ZXk���;[�U��5U�9���媪�9K�����r����-�^y E���"o+����잇���C���u�!M�3}wR�0�\h� ���*4��c_B��G�T51q����
 \x]|зL��A�<��;��]���V�����|�aj:�Z�w�ɩx�*NU��De��%H�X�J��m�i#�sӢ�
�ju�~��[�_Oǿ�W����Q��W�/���on6�F�!{���g��_�?���������o�����Dt�e����s�TUEm۬��C@�'@$PP��'EhPz Y�3�>w�i1Jk�l�Ff&��)8���}?,m�)S/r{z�j�`� $�<�� ��$�H!U�IU�nX�#*�; ���Z�k��ۍ�������������?i_�#Wj���N�*E�O%�2���p"p�u�1�~�[���嘬*�j4��UCD�� ��n�ݵ���_i[s�{��_�d�@ ��޶υ�O,��b���@M��Z�c6�"�_0��Z�XkmD�EZ�mQ����;�E�C�}(��[�&�Ƚ����(��Ҫ�5� 2�gX���0o��_N�Y�n/�5'.�����R�^����T�	Ǘ9�y ��N���V��
\�b_k����g��Ëc���������޶���<�T� mQ�-5�:�J�*�"��1�I?)'`���H���<nĀa�rB��"���E�����&j���:�Qz�� �%s�c�X��?�Gk�V�wt 5D��*w���9��9�sζι��*�4K���7y !�
�� k�� ɽ�+`���H�q�pP��C�L~�K�y2o��߮j,�~�5���:����D�*��L�":��+��>���k%�J@?��;:9	������->���M��d�zA*��x�*_�Rl��3�Ʃ�RE-�:��V�^�OB��3�����Qe��[Q���Au�TuPu>&4�m�oXu�}K400������/#f����Zkͮi���i^6MuY�������+S�5�߮�P�5�u q��+��� e���gm�WE��n�#(�2@h��O%Ax�F "�l(B���EER/�V��u|y��ע�W�ATS� ��H3aBފ����aoC+!\�����9��'��@|�.�W}A�K���U��(.�jgU�d ȩ�NF�J^ ���c~�=�t��'Y"c�j6�������@'���7xS���;��1 n����/c1��ڰi�s���w�Mw��t��m���M�� ���#�Pdv�K��\b��g%9��|����5���P4��s�)}���0g��:�D䭈|������Tq�꤀���J���� �A��yЛ��'�7*�F�l4�=��7�DW�R��H�!�$ŕ��`ŕU\U"WNu�b9��d \TaU"��'��,��~��m�A),�*l�8���
�U�D[ZyN� a`B� Ɵv���>b�e�1��ڦ��.��o��vS�]kꪊ����cm�|Kk��W|)z������Wx�2fO�@) 9!w��R�+a�kc�й?a!�	ZyT坬��o@���]~(V�7	�I@�'���7{2�#��Lӕx�E�@܀�Ө�?#����_1�*] �3Q�Z��U�J�8U�I������*0�BV�Jm� ��P�̀�R���=�� �(�@�����\)��b��XUu�0�5��s�j���l���b�6����b��I�|,U���Ȓ�;Af�ʟAEq�.��z�H|O(V�[[�嗂�/{�Yf�o2 �b�QUQU��kި� ~AD�3����n�`FPD�� D�M���z���k���7�*��A��
l�p�kR�ܐ�E�Q�+�n��4V�U��1����0���cKN���!*?L�<U.��6J�Q`�D[��R���ׄyv���b�������03[kM�i��t]g��7MM�ڈ]Ӣ��KT�����x�p��Wx<
A#��8��:2�����<��$�6�����_f/ ��AT��r��}��5������%�w ���cM,e)(V��8�]�M����������V����7����Qe���D�W�J@�(��B_ V jVu�K��F�\a ��Si���V^��1"� GĆ�Q�V�I�N#ɌC�X���0O<6 �P,"�GJ�6113�5TU�꺢���iX�S����t���!�������4���Dq�f"����?w�MiZo�����ω>MF@cF_|L��^Dި�kU}�kU����� ������w�_������?��_��o1k����|����= ����_��v�B��K����2���h\�6J���N�K$���xUr����ߺv��9�m��<�
GD6e�)Z��_��A���? �P4
E����A,b�	J����i�;gQU��0Ʀ�Zt�=1�0���MC��g�����ɫ����{S�>M��Ol��D�1b�
���v-.�X��>Ac]�Ab��*oT�[U�.���Bq�@G�z �?���K8�{�������^��~����~���~�:���\`�Lq��`)��-�x�E��O��ck=�|�+/a�� *U��m�W}�OS�|�YQ�-q��w��_���Xa�V���G����Ϳk8L41��}b�ML�~�0Nq��~�u���}��{�v��+��?��铻��ʯ�T�u���JU@��Ԩ�]h����X��̄���|�g�1b���݀iS5�ۏ�������^�^�~ɤ��c�qLW��GzE�����zL����7Su�D�U��F�ߋ�kQy�*o��Fo }��?�.�����b (�����u�e.����3��,C4 eRo�lSt��W�B�T,��@PDB�ɇ4�w�#���2�/�(��(z��=�P��
Tŧ:�^Tި��Q��=�?D#���|��#����ݔJ��~�����Y>������ج(�����K� ~�e��߉�����c�8�w�~���^���[�{��2�3|Qd��!�u�!���V!�)��P�%��Ax�; 7��8�W�@ ���5��#��,��!����
���+ ����g�E����dƟq��7)����`�?�����o*J�3�OV>�S }�:?�)���J�_ �+�Q���{F<���@���C@v-��_���
��_=˳|)�B��.e=)0�!���j�ۆz������o���a�����>�r��ձ�����_����*e��;��%�[�a�>"�E���a0�9��]�� 7����3�Ɓ!�`mP���|h��W铸�	�8���jub�b?��x��
>�~�8�w��GP�,�;�H��z_��u�� �5�^#���t�]��V��B���|{����A��:}����.�b{V�g�b�̻\)~�I��i���]�;��-��L�~x��Vߌ,�2$���KP���h���c�� �?w��{�?�����������!�-o3�O�M���w�x��,Z�� ����A#�_H�c9+�V�ߏ��p�u���iO6 �pz��DpODC/�Ώ��?����
T��}��d &Ux՘y��~���'� �����{�}ڂ�`��<N�w��}-x�s�1���� �J��\'����ίxz|��!9��i@!�J�+ ���`CS�]��1{E��,��!e� �μ\�Ϡ��}"�o � &������#zڬ_| �Y���NA-��)��US�_�h���]�W�0�����b�:	hTa��<�:��<�g�b���(�� 
_�{Hf��l(>�dp��Ls_sfZZ{EB�$c�Bd��������������X���u�=  �I`�B�t��LEB�1�Y>�X�L.� 4z �,�8�#��_�Ko訒�Sѓ[�y��s��޸�u~��.���+ջ�� <=����<� c Ql������*=+��|h�����]�L�C�������q��K�����ފ=,\�!���X��^��� }���B&������1 1��tB�G6' �� D�HQ&|�g��r�
Pv�-�9�-��F����#�j��� ���PZ��tN���L
��8��'�5��!f�����u�Hk��?$� "NH9�H��c
�?M�={ ��1�v��@�l8a���{�����C����խ�.0�e6��$y�ꡘ@4�H')�p�|��:�C�0E򀓘>1*��<����cʝ݀��&os�^�������Y�׼�(�1T@IH��o���~�<��
%��N�F���t�_���X�g���`;0p�멏��)��B��ֺ�(�~6b��OA��&���;~�3���Y>�<j�=���c}����l��؁�>屗_�ߟ�~�g�Pr�p�f,+�L�C�C}h��a�rx�C�h8����C�C{?��<��gy��!w�Ӈ.���5})a]��9�?{�T(�γ �O��҃����=��v�#Z�g���{<�3�#��* ��`��޺�?���S��_淤;��� MD��{�̯}V)��[�^�(�E��l#�u�D�ۿb�a X�Κ��ӬU���o�����sއ�2}t�C>�1s� �ٗE������4�'���%�� ������@�Tz��Dy�9=b�������	 ���)X�6��=�JN��#B�G |��l��ο�T��|\JfG7'[�٩!�����GV�pf;�1��X�얽<�m����xJ���#��?"�F@���Al��@n��#��^��=���O�����T���*�����!��@nb�؊�/��'��=z =���T�<%A�R���a�wv��ݍ4��d�sL��O���>����A|�G,P��Q�8�v�sҟ�F�?�� !x�K߽�����¿�=�_��w����S�4ayj��_F"��8��BTtI݂6������^��ܝ��g@SR�!�ŋݧcϮW��._�pQL���U!�A늭�8�'MA"^����ɮN����Z9bX���Xn�r�=���{kp�'Ș��:�&�y�oT~gh>��� a/�E��oE�o\��w���@�~�ϼ^���N� �D8 v-DP'�0�����$y阏�SR��G�we#��i�ji�b��?=h6 ☷��u���� eR�"��%�	�S��[k� MZ�
����߯,��[����w��!!�#�	>L�?���!�7��=b����kC���3�?�d����U2ߩ�"]Q��!�|"�������K?�m`F���H�}2G�'qB�X�^'�ʹ$�S��<:�K _x�8	���g�n�L��/�ܕo?���ĸ,���Ţ�eH�ڵ��>�c^�37z������4���A�[U���_�/A�=b��5'�O\O�8�(�j=Q�G4 �|m��S(�)h���#��f�8 �E���j�9����)�!q0�R� �x�g �p�@��������}�O.]9�1'��<����"��1�5���4�Giׯj�JR@f:�hB@^}��}�G��NU �_1���W�@19�#ŕ���ƾř/)ܴ�f#� %��<(���yr哚�o Z�@�Ȝ�|��|�HǪ���uV̜��BT��#� ��\���>�Ǧ���f{�ůJ?+Á�D�x '�Ӻ�����0P|��5'a1٧�	^����#� �3}�h ���	��ָ�avP^���9�UvL�f[��q�̘TQ�E�BJ01�F�O�*NSI�f"˓}�|�|ŏ�����4�믾�q���M�������f�@;������,�yF��B?�8�}�7�[�o�<�q_���� $~�A�̽�kcPv�-GQ��)3��m@i&�E�@D{ ׆�;bz�޹*X]�7"�?o+�2��zE ���b^`Y����>R0�\�L[60oٓ�[�O���:|���af������w�Cǁ��_����Ͷf�s��󂙯��^�*� ��@�rDo7;V�_��C(��2�Ԁ2���Ȉ��4��!x�=3q�'��O�w��&�`@B��V���-�'�������+
\��@҈P]��Ì M�4�������C�}�3+��rgEfFᲶ���S�����ɠ��_~�KP��PM]U�իWFT�5����D��c����9��5��d�uj4
X�x@U
����F�#���D�RD�CG�F!� ���a��z�UA�R­ߜ��OU�>�LM��"֞��#��C)o�t<���s��R�V?+���u��8���V������T qe��Y�1�m lA�`���WMS���K�܅u�5l*��t�<�,[避v��)� �*��Q�*�����䧗�8y@�{j��qD41o���F@��@�"�ier8�h槺�z���W���T��]�Se{*R*��s`�P3�FA;"� �%b������5/�~�uݫ�k/��8�jk���sT(�µ���|��wM�B"b����8��C�{ ��T���DDb'?�$�����^�xHs�=[���_��ߟ{U ����i�pޞPW�i�c�s$	�K@� z���{�%]6W�sWm�^�ۋ�v�i�����c#�CQLݒy�v�ؿ�o;��T�`Is������~s<=4y_3�@3<� �X�G��&�w�!+�,n�)p��ҁ��x�¿�"���G�W'����R��*���N���]�D=
��<5�MZ��B�����`�k��i��f��.//��vW�mk�sD�� D�}�es���k�*�r�a9�+g�M�d��X���  ���LG̗ ��YHQ�����y����D`N�N�/�����ZH�_���%w_o��:��9�Q�_�,u~B��� �A��CDWD�5�tι�m�j���/��v�᪪ɰ�x���>`�&��,s6N>ty���<[E6&�`����ec`��0є�y��
���x����d��
�l ���tO���Zq�a���~>�?�[�2��wu�e­���@�[�,.���yߧ�g�x��"������̳�F�+$�m���ֺ���m[l�[\^\PӶdL� ��Q�'�i��>�v֟Zz ��Cr�� �����g"r~��x<Xkm�́�W`�T��	 Dxv��L��}��L��?_\��n�O�?��������UtVƲ�����b?����_,5�1}V��|%�}=��z�:7�8D#�� ��.Ҷ�Dc�s��
Mۢk;X� �$0z�g��� b03rQ!��ir`f���u��Zk�Q����e���b�[ȿY����3L~mR�`����,�\#}�&P͹�7��s�9�'�<h�� ��9�0CR���8f,C���e6^��OF%�П���SQ�����R���@�*��JU*�T��'ð�5�:8� 0�(bS5�`>��rvD=d�a0G�`L\���"�,Yk`��,���ݰ�9i��4L0�a-�X�5����Ԥ��o�?K�q��Ǯ�8�TV[)QW��c����x
ʎ��y��@/�*��͔4�����F���d�����X�}]�OXz�JT*T��L��2��+��-)��F�1��Ya�!l��B�|��N�Ø����a�;8g��b �p����|��q[�MT~cL�<tC�~�kS��,-HyFa�����y�����~OG�%����/�IJ�p�qȨ���B��n��H%�w,�?���!���)�Ǘ���2�� �%����bQ��k��j�!(�h\�)?�em���f�a6���l�'@D`T�5p�D=59T�S�o��	'`vYb�]���l��;'&��z&�@B��?�(�DA��?O:3�o� 4�~��C�]u���v���0󬰎(%B���$���x�h�[��g�(�D4��0�LZ~����C�����C֙�2���ԗ�}� ������[ax����.ս˒83���#cy^�	�[gŞޖ2�?[�Y���olta��4� �;���[MF�_*K}���>�r�c��,9!��!q�"� �,E^�ޑ!�]�H�"��]��h��W}"�`n�����Þl^ 9�ϳ��l ��)(�O��0l��]�a6���U�s1Gow�� M�:3�&~��}R����$`yⳛAK�ߔF���D;������=,F(&;ǋf���>�/��EζZc���aGOVn�O�U�/�癓/�Mj��8�ϭ*\�j6)�s�/)����X�����,������O��2b��)��q˙�؊D#0%#0N �pʠ�&�_�˥���ğs�{ũ��+uHa{��Y�����r���
H�!H�h�R����~���c���v�g�D���:8W�U9�I���&�`T��3�T�ڊ��a�W/����oc޽{K����g�#w���Lל��bs
��yC�4�]�l(S�/���9U�d,ѝ��9�wRZ̮��l J����������9N�[N����~�'\\\��MJp����צ��J�T ���X�c�s���ȹ��u�P�UH�9`�����6��x����$P��)0!z I'�D�ޡ����.��@���(��i��%���s�a�L�5Q�B]�h��� (Yc��&BhT��I-���0���_�Y���ss-UU���W��vO=��l%U�q�A�eRx��N�XT��$D��_ ��+�2éF"���t�0�X1��_����_�N �w���د�i�r~�Qs>�ӟ���?|�q�������v]���Z{a�݉�@GD�1�9�LUWԶ-��AU�p��1đ�gQv��?+��eb~yg�n<ӂ������9�Gg����ۗ��8|^]VF�g�1 ��Q�C :�/�?���F�t�6�� ��uf�;y��7A�BE^�ʐ&8 ���pqq1l6���}U���|�mN�#>�Y!~@d�e �G:�Zy�ND ��1 �U?'xL���2�ZI���8g ���Sf��A3	2�lVtU�@� �!�zF����T��/_U�ɳ��}k��2��b��|a�7���Yk��6M��v�E�m�4-����v���eՏ9�G`WV:�N�p������u����~oM*݊X�y��Ĝ��%	*2���'���fb��uU�i[l�A��M��8T�8���.�iz�i�IUG����#�3�:�\�!	�3W����ޚ�ߥ+28��� l<Q7Dj!�<�2#*?a=�<#CJf�`i J��\�����g ���>$TeR'`�@"�^���T�6r���Z�f������]��r���K�܅��u����i��6�nw�l6h�U���(}3N���' �� ��::o�������`eֽܲ����z;�x�ȥ��1����o-��F�v��h����7����0l�a����}O��i�!�o zCDo�����s���${ �~��")?�k��
��W���.1���@�|�p�%e�3I<�pD+��8M�����+�?+�O[~ ����^u�� ����<���_'��]졧��+"��־���U�4������zS�u]׍i��ڶE�m��l�v�:zDK�z��e����+^ϋ4���c��Ob��$��'Y�?L�w�z���֡���O�_W5�m�a���x�����BD$T�8�D�J#Z���H �m�S2G�K�=�U}�D78�ꨀ��<P���!�H� ����u�y�gB����+��J�e(2�Iuޒ�Au��� �	�߇4�E��܆9�3D>�XP��':��+�|����m6��۴mW�mk�A�4h�mӢm[�u�,�$B ͈����Ѧo�w��8nk�Y�>�3�e\�4�+鿢��}������p
�Dk��M�v��{S���ZU�}5}�.=��[�A(*�?�R})= �j ј�-���
�꤀�2P{�5��!�L���>����
�@�T",W�sU���y��x?ݸ�Ν?3 O1��^����� �T���+�kd����| �O���ۿ����'���_����n��h��m�u�45u���QW���,�f�^�� *o��a�A�ػS���!��g'b��;c�%�苐��k�`�襓�|�Iċ��/�Me@��r��G3�hƆ��#c*5�8V���6"�"z Q�)��t��u���(.QD�QT�$�^#����T'��Q�T;v�:"���0�lZ������d��������T�k�A#�wi FU��TG���w
����T�
�*�7s�"����B�� 0���V��������9��7uSu���vf��r۶TW5\U�Ycl�䚄Q�ղۨՇ�tk l9C3�NV:�хR��}��AمJɧ-�-g=���Ġ8�|2�N�_	���|�Z��F5�d�5*��0�CU��ؖ�'"�9�]zN��� h ��Y�� �2�� ��k"��:�$�����p��� GI�� c�yS��T�|-K� �;���V�f+����'�ϟ�/ �1�?ՃDO���;�%`�� ��� 1�6 L\?�0�Yy���XWU�M�M��n����(���fś��{�ZffD�c�J��އ�0,I}OhF����DtRH��1��a�0�0Ʀ�C��AΘ���M8BPX���*�9�bf���Ȃ��7� ��.�H�z��	�����a�ƣ�� ��4�-�-[&j�Q �u �W� �� �*e#�ݝ�x>"ԓ��uN�͉?@=�a��KP�s�O�M ^��k�ɾ �&�5���w̾+���Ћ|t������.-"K�?ц�8{��9T	�Ҵꪆ1&%�nc��G��h\���*B T�4�z:���	f���~){ ��I�%IQ��~��أ�c]� f�Ć�+�P���0?��<_Df��br��+�e�/�jUlNU��U2Dʩ���>d{�����ͮC�r���%>
p�k o�� �:�N8z���W�&���ALQ�1+��`�֧V|-i��/ |���R_����1�!����W�V��x��o\3�AU�c}<�����1��"ʒ���6=K峕pX%b��:��U��S�,��;��O�
 $�>v���c�qq8q<���a�4E�o	27�͟D�]Q{PQ���0L��#n�=�q���*c]R�Lq����@g�1��'��0�fP�ݜ�>'��ժs��)�<p������8�p "���� Au��t|��	'`1����e�T|!:��gw��ä����{nx�V��E�WR��Uu�����/�3�����e�^��/�*q�2sOJ����#j����1��H�|�s���'���ရ�=�c2�)�QY����v颋�&7'D0�p豿9�r5��$h�)�m�s� 3�,����e��q��[��vӑ.��倅�7[5��&��=�sʃ$����I���R�&� �T�306�,b���By����pZ�r|�ڊ:����T�:� ox��� �����р�;���j��˄B��&o�߿NY��p
�ߏ	�Y�
s_A��%! �	�8az�{\_ﱿ9�p�1C4 ^��#����-TĬa�!.E]��J�`l&Tu��U��c�)�q�?֓�x̍*�������XnFycr�E����9��>]���!H8fʏ �I����z��"��pV�2D�K8�����6���W�tm�,�Rޛ����T����լ�? x����u������� dhޚ%��^��[.��o+�����c���ɿ���{�i�4��}��p����nn�0�#�1��X��� �RDw"��T���d�B�&�8z4M@��ZQ�i��i'xA�.������Ӊ$у�R����+ݲ̟K,�$�@2r��f�2N@� D�;m�I8���E�Ƃ(��#�u����L����A�xr�_�V��Ώ����C��������t�yB���H1Cc�4��Kx��<��$�=�q�0�������777��9�x��g ���,�/@>����q4}�h��
!x�[X�(�=��|�%g9aq�c�Y�xЙe�tpB���c�5�g� ���z��C�W2 L$Au�jP`$�'`�D7�P���.�v�p�'��ߦ�~���^QQ,��s�a��g�������R����7Lt#�DC6R\�?��c��#mw��L��*{���4
�L~F)�sޣpj�J#��wV$菇�����������8����= �= ��XJ���� �� @c�O� b�10��U.�Js�������R�#�<�D����&� rΓj�0O�/��WI���zKd80�' 8$��9� '��?�	����Q�K�����iď�����ި�be���b��`@�#���O�U֥g�V����v%�򳮉����1r�gR6�f|NL�c��B����G�?�տ0�r�T�t�Ha����i�恅~�y�1#�m�b��&��P�9��Z���x��z�b�s� ����ޗ/��f� ��?��ҿ~��o��W_���+!|��ATU/���� >)�8Ԟ�U� �j@,s%t`�Ȟ��S������^u~����P�C���쎱𳨂��������[ ���K~���l7������S�{��뺎0_�`�I=�%
�����A�K*�"�`��1����c��~@�� ��/9��;	��nװ�%��`2�8�p�5Zc����=r�`�/E�к��q��Һ/��p���/`�;MS��"Hx��O2M��Ʊ	��i��H�^aG1�|�L���	�.��P��P�@dX�x���= �adR���c�����4��k�,R��ŅQ��+�4��a�e�+k�W��K�������u��٠mb�_$�HF`�����+s�=����J@��'�C	4b�~�9(���^�8K<YM�=&K��0�)��VmM���� ƹ���W�L2K����I+�i�plz��ơ���b�Ɨ�8N�0�4�.�Ѕ �D�D{":Ы�BS��ɇ�	�nL8�@T1O���-�*^uS?��V珣��
AXU���C�:݄ ���0Ƽ������^V��p�k몮���6���v;l�4m���b�/s�K'�~�sUN�l�(�BD�N�c�&�ӈq�0M�W��9#�<bs-=�Dm?�;�4V�N�C� �8; ��:'p��o�� �D���K|T�M��u�����/��C��� t
���7D���߁�:�p9\�l�!pzN� �U��
@aBP<����S����KT�Tc�?��+�^�2�_VU��k�Wm�]6M�i��n��4MKm�b��`�٢���]Lbq��{���r�z��X�uf���-�����mO?p��dY,M�;a�d�?��3ux�AF f��Շ7�~��:�݂u]CT��p_@���x����X+
���ʰi�y��D�e��0Wb"Hl(⑘>+_���	���TG�)���b�ZǪ��Ʋ�W`�>��	���|!u~�r,l��2�U\1�+f~Eį��%3_6Wι��m/7���v��tݦj��6M�6������	?rB0?�?sr�	(�!M��:�C��?+�蜛8�83 cjJ��p�a3$X&��E�pB�X]XJ�/8wo��p ��f_�kcT��i��~h��[fs��;cLg�:HD=c��sdß�	�8���TUmP���%�%��*g������? �I��u��|D c��	ب⒙�2����3f~�l^k/*Wm���lR��n��7��4mKM���	WUn���/d����'��H��~�:����<{92��N�7T9cMb1*'��bL���W��,(t���'��x�/�����fcm��f�����UǍsn��:�D��<���kcL�c�m �H|��$�#��C�{�<��M���_B��Yw��VՊ�[@/���1���ϝs�8g��s[WU]]7u�v�v��������y�~�p�Z�]���0���/э�݉>�=� �`�3gy�����2���`��+�#�	%����M*�q���*��/@��i�}�W�㡩��WU�UU݆f�	Q�&�;c̵s�0� _����0�1��x�����	Pd����b���S��ǜNP�
�o���[U}�������:�ǋ/4�VD%���~������2sB�)���^0���s_�u�uU�WUUm꺪���m�r�mh�Y��g�i���f}L�y	�9���̥7&cqn��+�+�su,����̨��6|� �!�I*�#Lx�K�yn�~o�-� $p�O���=�}��i�4�i���Py�- c�i�G�p#"7 n��HDS�������7o����PU�W_�2H�<N ��Ȍ�K�_Ҥe�̟ ��J�a��{��7	��������!��w�q�z{�WWWv��� 6Ƙ+f~��/ �d���s�EU�Wm�^�m۶Mk��8�������EQ>�E�=�7��w�<^v���JC0/�t�cֻ��Gt��8�L�V�9@�N&�B�n�$4��e�s�u��P�P�4�59���gBƮ�0�#|@m�mǱ�i�y�/C/D�!�0y�u�&7�S+!��y�p�E�p��#*����A��h ���wX{_�}\���E���7��Ѷ���JB��q�x��ۯ�1_1�ƘKk��9�UUնm[o�;�3��ܳ�kTU�J~n~�|l������2`'��.y�S�_U=	J��rϷ�>t��8����^�E���clrEB���3��Ġ3�K?�2� S-@����l�麙 �1T�5�P��؎�x1���q�aUuJ8��NTo��zU�"pX�_#��u�}����D�����]�x:�����kED5�:Q݄�:?�yUU�7��^�����������ۦ��f��n���.M��4_1��44^����\����e[�y����sK�� VWvV�rK~.yrK�	�T������ ,
9)�>��2alG�/��qm�Iʯ0Ơ�*j���?^��>�|�	h�	N��]'g���p{5����}�h� ���K� z�ҾF|!u~j&�h��'�:�u~W�j��U�6�mӮ��]�a��b�ݢ�6K�?q����D�;K���Xy���!���ν.�$sc�:���P�PI �� A�H�/ H�&�%Úݟ|���"I�9A���E���x����# �_�qh�hKL3N��T����RpX�|Gĕ}�E�mqGːҜ�FT��X��*���3��B��x���K"�2�\���j��r��^l6�M�骮�b�?��]סk[T�`���|������;�B��v�r�ϼD�g��s��Y��*��_�c��$.6D
�I�q�N|��,AC�ނԉ�J/�0*W-��;4u��=��x4u]�6�|B5ck��c.��1�� ��'|98� ;�����}�ȹ��=	�1u~cl`��%�R�7l^c^X���M��l����R�oۖ��E�Ԩ�H�G{- �%���-w���r�[�2�%r�t��#B�"}�%R�(9����YQy���5,xi`y�j9f\0����l�*�ù����P�4l�� �|5�C��'���	�/'��  ��~�E���#��3�g7 ���C+�w��ݕsn[�U�6M��t�n����WK��n��]خ�Ē�+/݇,��+�g.�u�/W�Ζ��e|���뇃��V�c7�ƸeW�l��� 
���F�� hJލX^/\�?#��k,�U����ר���u {?�a�����U����q|N`��I���w���7���������_窮�8��~����<�#x' �S��[?`����W;@6��b��I�����W:�}�S�q������{�W���:��:����_כ���il�v��lh���bwAm�R��{��O矻���K�)�(K����f��L����)+�ҹ�������-b�g}�C����U5�bT�E��㸢�*�T5eL�R]���# �pYb��8�S��p'жno�"�ZD�\с�&�=�H�������G�w~��Kϖ�>�IU�G<DYI�!X��������؏����(��l�SUe6�������W~�w~�DĪjk��`��{��/��խ:[��ۢ��}�:�r�m���/V�\�3Aψ�O4`cj��Fx?-�?"����q�T��S���O1����ȅ�T�$8�=M�H�0�x�,$u�`m���N���e�&�9�,���#�J��p a�L�O<MS;��0M�O^��P��υ�����N��듓����ϠEYN7�P���U���h�f��6�\X�^ï������+^z�W��_�F��������d����s��!�����k� �aR�I�����:"�v<��Z tr��Z�v�ډJ	��O��0t쏨�n^�c��`�&�턶��4�V�-\*�1���W&��T!x"8�i�v�8^M�8�q�&�pBED$>|i�H�$Aq�%��~���Q��#.@b��+��|w��ةIB�Ttk_UU�uUUW��v�rO�Ώe���s�7���P �\�Q�}<q������������Ȅ�!�I$T�سqЈ���h �:Q~�� ݩ�NE.���	��4�v�C�W�LT��6����{����=f��� *3�A�N�ꇡ���E����O5���=ŧ��vO)C4 Z��r�5y�F`6y��?�q�e���\�Ԝ
��)U�*�B[f���ꪋu���i����O]��9�+�岹� xMD;��k�{G�G��{������pأ���4��S�Q9��[��U�5��5��D���VA;�^2��PODMn��)�T�A"c4 y.���x�5�ԃ)�eV����	��'p謵�@��W��o�yODbk�'�#̔��x��o��pb2�V	�_Ky�����D��
��(Z��M�H�3i��6�l��ڵm{��n/7ݦ뺮�q����ο(�G6�U>JF�O����~�뛛�����}�a�c> L!?�������U���<j�� ���R[p���U�H	j!��(Q�f֠Hb`��d��0�Jr��s�9�D�D�u�a�^���8��h�C��RN���&���3% �*�2������������O'���P�=�W ~�4��m��2qZ6����6�8km]��mڦ��:��l�nә���u��S\������
	�4���h ����������1� z��1&�{B����U�ơ-����(�Á	
o�G�� 5�VcY�^�*:%�T�h TfҨ���1N��g�ϫ�su]�\�������I��#�`��Y����q��8몤�f��XW��Z�sAD������B�DnۤC�ud����x���x�r`�������BUk��K^Db�Ѹ�8�\e���ڦ�6�M����j�ݚ�U�_#�R}�(�$��o�4�{��˰���kܤ`�1}T����$`ADF9��B@��Ȅ.��Po��?3l,��5�x`C�^I{(�T^(���8(ħ�!���
��
MS'e7�V��xqbO�N��Ȇh{<6u]7��*��*���(����iL�2�'�czpq�Ϲ���v�hEd�Q����������-�����������4�a��8��*��OD-u��� ^ x�h�F4 m*�QJ�a#����+����u�MӘ�m�f�1����;�u�%�\�nY���:Q�Ţ�=�i�8F�xL|����������!x�HҫA����н*�����[@#���$x[W�1�v�Д\�FUo 4	(�,|���8��e~J.�su}D�6i���5�[h��Օە/s~�?N��O�0ps�9�o[��W�0M�D�@��c���=3Ո�?AqP赪�S�����F��������O����������"�����#���)����+f~ADWD�"���� � ��ur�b�WUڶ-����i�I�~ӶԶ-�mG��Xc5�z� 	M��;?yL��G~���"�����ŧI�	Tu�����rR��{�*oUa��&��AUFUL@�z�G���@e�B 4��&c&87��-z�c�����ဳ��P����Q`�?!N@걡�n(C�M�8Ep���)����̖� b�t+"�!�����0��4�8��0�4M>�|L!������T��u�h ��s�Kk��|��["ꈨQ��63S��ذa������]��A��~�:��W�yjV�̬�A�@�cK}��2�c��|$J���=�f����*�@��htx 0 ����鳴�����M�����0�)~98�3ib��ݜ:�\���B�P����8�<m(1�n6x?
Xk1=|)�D3b�B����T!�v���0�W�c?L�i��8�B�	j͢��'ߔ��|�:��l��*Aw�*W����1�bfΔC�U;�u.�wc����&��[�I�� �m��OȏY���t�������a�헀>38��+��ċ�|�f4��H��S�W�����O35������ d�<z�O��F��J�=1 �c���H��U��i�7�'P�5�i�``���̣�HE��Ǳ;�s8���kU\(��Щ���!��J���'8|V�Ǯ�h���Y{�4ͫ�i/�*k�a6T���21�5��:�-6�m��V����?���]�����'Q� �c�q��0��h���=nnb�?��������Ŧ3Z�~�M�\?9�[�A4�ɝw:�`�+�T�p�<]�p�a؀�4t4��,�aL��L �}dD�'`��K��D#�i���C� 0�*�|���U�f��x8v��������e�=L���H1�@J�hEȱ����>v��j6���횺��l6�]�隦���2��7��e�=���[F�u�& c�*���u��l��@D��1�J��C���c��� �{�8�U�6��K��Ƽ�r �P���KP���R���
��r������4�d�E�E�h��s��k"(�9�Ԥ���&b�O�H؀��`�CӴ�~�J �$k�<QUh�&s<�����q��CU��d�_�b�����>I���9��M�uݦ��v�f����1�s�f��˳Kiv�24���8�/��>U��i�3�/~h��0������p\m}��D}�y�3�4��(4����+��s'�8��nr�8{ ��I�\Ǥ��J�ep��z|�� �Xp�p��6�S�E>	N�S��`��)�a�	�k�3� D�`��}���ޛ��X�u��*7V��U傪�ٓj��1�����>E�:g+WUM]W]�U����]\T�nc��"k휻ɡg��1'��l�m��ӧ��c��s��1��*��rC����� {���0`F���)= �4��[���q�u7=����;	AHA*��F�"b(g�@��GF��T�y^�<'Mtճ`V"�`��]̒O C'���8,Ӈ(c�:4c�E��s1�D���~��cC����iۺi��ԍ4M�?�# e��q��b������L������?���K��o��iۖ�����o|T��*"2���?�����������������pu���u�u���fc�ۭ�mw�4-Y�4=��Ǽ0�❮��?~��f����Nsk���Gh�����=�#�ǥ�w�&L�#�����ʼ���Į4:4�+Q*�����媚��9}��
m[��Xr�"D!�D�(���Ks�+ �Kl��0��8�|�>N`I�,!��&s
G�h�H���YWYTU4 qZ�Xk8�@��s۵�k�m�]��8�
 �9
�����bOt�@�:�	���K����]�ֲ����|,QQ6~�w��������u�����j���u��i�:~�ƌ~9�o~ư(G�M����=����:
)E I7��f��b����b���_��S" 	!�}TEE����D�yt�K�O  �����Aʄ��;|���v�#���B+Q��b���iR ��J��&g_@\�s_�� ��:W��8���Oop����Yv��+����C0P�1>����f��űO�sEUU�1���Js(��-q!����`�~'�**�$"l�1�J����KD�o���Xi�9Q�h���4��S}�:~{��_W5�˝{�ǉUr��~��9���u�|�:���?b8�?.5����0`���⧹�$UQ	
�����.�k�g8.��3�N�@�;B��q�g,� ���Q�NH��P����B�y��2�t��Ǳ^��g��D3�Q7�ʝ����TXz�G6^�F�q�)�*@|O%)ݶ�l:\�[L�Q��]ק�n�����Rd]����N~ڍ�xu<gA���0��A��KL*�(���  8 IDAT���z���W'��抪H����@�B-�a������Xǯo��͉@PR�2���z*����>�����}u����D\�$xov���#n�������L��x?���G�O��&>�AEz���{,^�kD��� ^'���8�3  �t)zDKr��r)J��K)�*�S�l��DK�@v���c�O�o m��ψ���[�}cL�R!Г�}'�s��f�3��]Xc�m���0�m�ðn�����"3MG���Ş���G�z�V?B�c����K����o�;�3'LKڱ�� �����Xǯ�:>S>�urT���X~W���9 ������Q����u�8�3�g]�;��~�폊?�)��>+2 D� "{Q�V�w���o��t�q��wx`��@(��G�BnT�(�QUVe�"������� �3���ʟy�&�i�͇u�W����]?R�2��̈��)�a�h�{�<�u]�۴2L�����1������/= o�a��cwss�E�0T&���|̞���#R�����H�ue��d%��$�4�^T��QPcj6���[t�fUǏ<9߄�v��_�y�|��u1Kb��u����#�?|�-� ��w����~��r����"	^T������{�J��3��J{�	f��H8t� �B�<oN�Ѓ����Z"�U��U��=� G��3�i\0E�`�|��E��()�]\��8��/��aI�>�X�`B�0? ��H�B褋Ugѵ-��,��uCR�a��x���� �q��ñ�.�����>@!
��fb��i�c��?���
Ra�\I5|�����c�o8�8��r�_�r�s>�z��w��ꗷ�4�����	�>��o��(A�G1�iV|/>x��_x*"AUQ٫�[U���L[�_�E@�T��x��s�B'�W~�p�2�A�ԁh'$#I$^L.� Đ���@�R"�{�h1�{���lc�N�|0��i&��ZS~���@H-R$
���� 8a����d�/e3R�S�����M�D���T.����8�T�k���~|��iƤ'@�9�(u|{���N��m��L+p�ھW�����=�7\��?�{�����q2!̹�N@�D�G��K����
�
�<G=��Ni��Һ�TU|���̆_�1ZL"`@j ;��D��+qJL-�w`#���BXC2�$\�)H�`3H�%�я��+q�W�5||ͫ��ʋq��su��ۂ���3r+��Gff�/pMh�F�z�h�$rp�~��+< ���+q<�����S���7�����c����g�9���pH~�2����}AH!D�hB�$��*^U{�a�; ? ���b�$x� ѳr���{�s@ ��� �M!���}�T5����&"
DP0@B��@�p1�$�ok�i�t�2�iĪ�8k͌L�=��w'8���f���>T4S*��|\J��a	���3+e����
�tr�1�#��}�[�p-��ծk�U�<B�%H%���Oj���t��8yש��ʟ&���u�����-5m{w_u���v���֐��\o%g��v��aBY�+���Xw�U�c�T�/Z|�x��R�oj����~h�����J �;W�2��p��	������y�v;9�������^X)�4�|J*���]Q�F9%�kR�g�l��{��
�I�0Y�T�JV��C����Ocn��|�����{�E���>|��a�q��Ǿ�4NPD>�acwXfEZ��n���?+}.<�
Ă}�{����� d|�&pW�V�n�1�׶h�M�ޫjT�F��l�O@��jX�c�9 �^�ZaO�qyq�탒C���i;&t_&�3�'D�����C�Н�=>���I՚�9������ n�Sƨ3���՜��Y�kL�+w�q�oN�PsiF�aY�g�@��N�z�	����w�b��0�����+:�Re"�V����|X�7��#�����D���÷���3�׌�TP��#h��l�j��Yڶ`].s�i�s��6Ё�� ��P�c��U�L����4V?��Տn�8�7h�.%�ϛe��ً(�tֵ�|3������'����ح_�߯b�ŋ���P�?���'b�1%�Ҫ�yŗ�����ag�3+tC���M�2 �]&��Z\�[;�[o�1��*c�x��f�\�r�q�T�6	HRŤRV��@x\�)�Vyn]��v������ď�^��N���w��{2-��CSb�A�4�l����G�h�}�'�dd�d]9�����f��
rr�󃗕?���2GĪ?݈9sO{^����g�^�r=��+ϑ��^�NB��{�+�BI�Ӭ�i��Ο�@$�Xp�1�_���_g ����k�����[�!r놭n�I�d�A<�*���x����	?ѹRq�zf\@��������,[�Z���̪���C�ddq�l^��o������ !Kז�h|{z��*��ٱx���q2��������ޣ�̮��<{ǎ��bE���KANRN��h��e��*v��X�}��5&�=�������GSR����+�������v�d\ߞ��B���Eg	e7d~�S,�v24^�2*;�c��̫���<��|���K+�u�mp�ʱ�w�%�w���8}�~��v�nh¶����s�o�_fbrz��������`�oH>���|έ�v5aLx��T?|��]�[ʁ��yw�m��b�G�p6/�'i���D���`�W��\�����T,�� 
��K���%���I��f�­�s�ͅnl�Rb*b�6	�v�5�_�l�k�"�`�ZA���l�̚�r�g.�@�I�}Űc��;�Ҟ�"�c.��Bg5aX�8�zS�3 Ƌ���_������M������!<3;�0v~��j�kw���[4�s}����;�o��z�o������^l	oQ�f�t~b��T B��x0~Ի{IX6�S�wԙ�M������)`�n!�R��x�q�-'G�v����Rċ#[Ws靜9�E|�&���e����S�1&[��5�T��.�G��o�?�{����7��U"�_�㘺�� H� 4�:� ����e٢�iƂᏫ*����H��ߝ�����K.G�NR��0rU��4Ǳ���QR�����s8`��w��������O��V~����&��Ou������\��' ;BQ��wz^�zHe�GUܼd�"!
T|�J�f����%n�E�$WC��Bbɰ������2~<w;���$�_����^}�?7����V~޹,��H��8�Z�/5v��ƬK�aG�ѵ������+���;�3�;�\zxh=O�\��7�Gxr��Fui�Bn?<��ws�l\"9��8�g��P�X~�!{{�3!���p���45p_���T�>�ԋ{6ק����?���ϞL�����=iD������p�l�� 6��^`��5鬷%�*<�n��@N��*
W�Rb���ql`���kE�4�<��7�c3��9��#�1r�Ăo����l@T��`\�e���՘� T�_p�1ˆ0�:��d5����k��E?�ej�����B]��	�a���ih�0���k`L��}���$�\�o�wv_I��ſT���Uֈy��@���������7�ǐ���� b�Ge`Џ�%�� �@�Uu����A;���ŃN�Q�6_���Ʋ��i�H���fmFaN���V�B�1��N�Sh9o#�ݶ÷y��~__����'��4dI�RFJ�+�<��s��j0��yM����͓@��5ԝ�P/ݧ���_|tx9���L�y��_ϧ2P�+���.�Z�s���q���E�o[�������M%�]��y�%�]�#{�u&�޿�y���}��}?�
��Z�P����l�oi�/ߐ�L�W���I)Y��
k7ƙs0�JX+�:k"9�)	�u(�����zD��&�cI!3�e8b͕��xxA?m5��%�n�x�&,b�n!6�7k�KU�,��ҥm@�dso���B]{ k��Hb܊��!;1H[2K\���T �W�S��!N�䴯���z�i������;�l�y�q(B�;܄�L��Py�����u��䵚Ԋ��Q5��'uK�}��+�?�@��t�@�#o�3_��B��H~������v�iH�u�����^�B���@�\�v!�8�����e���nQ�b�뵑m6y�`��u�j�@�m�}p���~�8%-��E�k�Ԭ3=��34��ynT�u*)�E��z -��n���>���͆h��Sx0�z�#��ci�e�`.F�h��Y�cc�?8��B~���-~]�2~-P	q�&��>J�T=(󍪾W�zt��?�+_�7�&r �m�n`u6*�#����5��G��ĕP�*i��@��̂0v0�A��Ny��e�ϳ[���u|���("��-���.�����8�Xa:���W������2S�#v��D�;��{��N����ڭw>Li�/�%Q���"�����K\�n���\��=�X�
������̣����y�}+v�E\`���C�md�i��0a�|���;F=�K���V��/�!�����Ч������+������0ş��q5>����j��Y�(z:�
�z�t�D.E�u����~�ؕ�	�e,�?g�#������.�m@���0\�M��x�\�����\X��B�ۖ��s�E����)Z�L��h���JC=cj�P_�&�*�#���A����vy���(�{24��b�D}�9�E3n���򞆬T(́�K��5���Ҿn�~o����w�}�Ǘs.t��H��p�e�M�f��m������� �}I�J��� ��z�k 7 ���o��o< �L�(��,�-z"Wy�#E�@�L@h����I�p	�q��JR��$���OE<�B�+ͬq�8�*�P�K�q�	=6}.��aq�����jh��� Ԧ�M�z�[���"O����AХ���`��m�KG��5�g��Ǐ���\��?�ꕔo�s|1γ-�/��寛z����p:�<G�$��'k��d9�f3qS�#���?y�#��<[�m�Gg_��'`z�L�1�a?�q���D����/D�s��p ���B��"��{@P�ޫ���;J��$�%f/����0v����)}	�җ���b�@���sC~j��;�����r�F�Rcca����E�iPՓ�����D������;��Tt߸��~w��j9K��pH?�,�~�}�����Z��k��7
=sQN��?���e1/�̚dg��O������'�v$�����k ?�%�zj��8��3����O"�V�u�A9�y>��$W/A|#�o@�F��"isgR7��JM�*J�hM���74f[,��ر/�I� �j �utW��_��94<�U�H�lFݫ�B�#\��՞�A=�﫻�	5Ay��"I��M!����<��h�7�~N�2z$^��ԟ��@@�9k�Y����a��Z�[@���]8~=F�yݔ�j�g�K���~��R�7��&���$~��@^�,�[�ֳ�vi�<�M81 �z��������E�G�3�@�`|�-��"r�
�Mʴ�+�$�k51��`�	�!<���͌��Z�@0�R�<�X5�P�� �H�u��� ���J��B��{�c%����*G��KU��S/��/=��?��?w��:t;'�#��K��앤"F����/�W��Wi�����E��|.ɵL걧y�|D��ð�|*Ο35���Am׿���KZ����{�- ;@ ��|�v޳~O�G{ ����Ͳ� 'wo^��x�W�O %)���N��'�N�'U0}<�w�# |r��ެ�Јu?[���4\�F�z�F�,^e���8���5����O�&w ͹&1��!�ۓ{'(@[�����ci�wJ�^�q�;�z#���k%4���I��0�x[]qjju�nv���������Z|�w�W?�j��i����Ο�٤�+�O�&���k���W�?�o|Bp� �IV����I�[2�
�wJ�V�_ ��p���L��r�uq%�6�>m�3 QhJ@Q6ʧn���*�y��p������,��M���b":�'P	Nh\ ��'���ʫ;>����(JI��bxQAjp��W�^���؇����?U�����wG�i�(Xwx���G��X$�}ǲsg����8�����n���rr�������{Ђ�~��w������oH�H����Ӕ~Dç���=���a�E,L�(�x$�E�}���1JaR�U�:O�y���� e(Y^�	���L�~�}��D��{[�N�<����^WA*�cÂD�����e=�4$���:�%%;�f����;� #	�&���������舘�Gɐ��w��>�8g��`Y-tij5^���^%���]a�9���)�KB�p��ǖ����Dk���T�l�������ώ��YU���(��q~����oX?]�r���O�����kJ ���b�K���+��I�����^�����>���vL��� --���杋HE�1���i�j?6<�����d�W�.6k�.�sH![���:�pCJ�M�-��[��g�w�	�B�A�
���F���
�lZf�)C�n���$�m�~�q��m��q����k2��'W�8�O�"ʬ�LW���hOV�M�/���c(8����~�%��q~���y�wC`+����|���z w�G�
�`���!�k�\�%0AU(��
��"�H����9ʹBT���������3t	ν���8y2�&�Rg F���xy�9�}0��P�
VcF��ʎ}W���q�o �����h�=�r��e/d�8;Kk��Ѥ�%�N��1L��ZJ�m�V����=�w������r���<�BΥ�Y�R����%��gը�µ6o>�P��s��I݁0]�W��WyC�kX�?���Q�������7 wo g@U�L�y2&�����H
��+@����;�  Ck*�'D��ow���#@!�0�FY�@湯*|X�|�_���L9���ܻ�X�`tD�{oCQ�b8G�?�dn����+Ǿ!ۜ��r/��?�-�'�I=��y���0���T\'�}�*�_�l�Y��em�Ê�w���H���2�Je_������8��i.�k ? �R��y� 7Y�������7���c ��z}�+n��:� Ny��'��Q:���&HBB��7�BaI�C�ф+Ҩ�O]�4�X��?;K߂�je����[`n�8f�aD\�/:Y�g�-	F�VA���q�<¼x�<@u��b�՟;�~7�		�rtz�N�i������+���ĝ������_�-�)8�~�	�_v��fֆk8�c�->� <	�@������a��Q��x�i��HBΊ<�I,R��֣�'�MK�9��@�j0(�����$���R*2g�sh��gE>�h��%�D�qu<�ݑN�oS�X�]�a)�:qs���巶;{�_t�禪O��ފV{?���|�;Q��}����p���c'r� %%�5�#?�;�sM°)�-I���U���Y����9c�@K%.��TZx���,����¥� �1���Kђ��~�>����m�m��gҍ��::D7�s���$��r 垆x'Zp�*��z���
��}�������-�ƈ��(��q[��������xt�9x�� H����@T���6	V輋��(NU����E8T&�X�z<NE��v��e�$�x�ۡPu7���.��c F��][18��\��w�%x���	����� w�-9j嶓c�;�g�9+z10+55�w������������6j<�a7d��Oi��,\	-�Z<��\YΥx�8����"��x|��w<�'@Ikr 9��Ԓ����MZ-L����E�� ڸ��n���g�L��p�:�Ȃ �{X�%�0�N���z#..6x���t�E0��3W~F�r�4���W?\��~q�{�[�����K�Kto��9�o
�6��*B���d�������e��g$�����ށ��%�.L��h�)���iO�h������~/+�ou�O�o����x�x*���P�;�v�j�a�6���j�p��g"o�b����i��?�b���Z��G�t�b��]c.�e�n\x ��
WW��gc1��j|�l�H�#����>f�o�}#�Q�����8Tw���o߾�����nw8���m��M�  ���E���|��om�N���/D�6D3R�T�Ey/ dj�Q��,���M���׷�(��xt��<��h�	�%O�%�h��ނ�AALw���vђ��lw�*�\wO�L
�0x���y��Ε�S%��.݉(���4$l6kL�%���Á�\'<à~�������cK�w@�,�m��o���5޾}���-�#4�,�0��X��t*Z�v��1�4y~�Xu�J���yhEa����7�֛P����za����{���ǌ�٨�O�o<���y��yI�� -�X���?��F�O��11ZZXU�4�\Ax �8v5�C�8�F�J����!�x�q(������/�8k�����c 2�z��8����q*M2{�����r�Rl+�S���5M-)NV�=�ۓ��DӍV̳�;GG ��f�4��(&i
~N9����k���7>�xt�@�&��O@�a�-h;���L-,���{V~w�zF@�(��0̋l�/aD���<u�����zsV�b�g"���vP���z����Bô$�4�c]{<�ȣ�^��O�g�j���<crf`]�1Ϡ<-d�̎���G)�����R�K�?O�o<��l<�URnTt-R����{�ȶ�����r�H���sCT�d[�.K�����735Y�Y�Ś�sգ7w�q8�m��f�F4+���Zm�&,K��O<a�:�"�:�}[aw��0��ږ`�HH�#������r&bqj�6�>�dsl%�O�/�թ�!�uz[��d��Wՙʣ������ϝ|$� _��F�τ�JT
O@<pY}'�����I,oH��k�]:zhĥ$L�,��
t!`�؍j]y|L���4�:!&�o��$0&�+o�� }��)Qǚ���R���0�����/9uq�$z��i�L4D����/��"�ӄ(�8H6����^`F�mQO�N��lt��^��'���7>�x<� �#�[Uyd�;�28c��&'� &� Гh�8��T�G��i@�h\R�|����9���W8n����b�z̀����kZQ�����E�3��g��F�O9Z���~��c{�á�� ��M����Ajb�5|����'F.>KRԆ��t��q͘��H�?\G�z u����L2������?Q�����=����<^��)��(i�Z��"���+踅_TĚ�K�U�j�Z���Փ��GF�\*D(hr/"��"��P_�a*1'�{8�h�G��gI�@�ه��v���Ts���l��{D�~(P]J}���CX\u���\7�R'�̵��(�5���y�
�υ�X�,�K<4�_�F��P�����_��s|O ؒ�@R�GR6"z	�K2[`� DRRp�ɗ��3��m!Na���
rn����>59����.����0��u���q<X'��D��N��<���!��^ÒQ��j/� ���Z	����4h��6�{9�Bo��T">�}AR�/��U���s�Г���O M=���O�o|v�P��@� '��W�<�E�U\8�l�F���P�m�@�k�P�ԃs�-i'�V��P�TWC�+�b.�2�Z��X����a84��ʓ/���Zm=Es��f�LRm��8*Q���X`�2E��Dl����x_#�1?�5��@����\A���if-}�	� ��#�_�^� ������<&芐+�� ��l��!�� @E$�}w)�1��G�C |�Qi���b�A�� m�XSLTv�&�n]�vw3��vk]�z�>��<�~z,�d케��Vqٜl�E4XkMj�w�媩ӥ2 OE�=��y��-|�cvx�B�)R�T�舽C遉� ^���K^
���xj�~�����+��a�9�+��W�?7���*ޕ	"�I"2dI�d�Vx�G�DA"�}<�_>�_��y4�?��
IQ�}6�-ZV�AY	�2;_��F�@z�V������b�?g�:����J�!-�E�?$��<k�g�y�ٚq�C��WI��b�$!QE���C������o��p���g7 �	`pa��e�c`CplR�(�Tdյ��E�:Cր�	�f�U�V(�A���|�+
,�ňG₥5��.��fFb�MY�u�\�{b���� �z*���V1�(����_f_*�_	����6.kCԊx?�>3 �y֜�s>�����z��Ljv�# ]�Y �o,�P;��9���`n�����O-	�<��M��¿���[�d�,T��VN)Q�"�Qꥉ��+�� ������f�0#��	��D���2J�y(`(�4��˜'K�7�>���@(�zۥ��w��?bf�Ҫx��>������"�鼁��b/E�/�y��4ʮ��;ռUխc�;���u�XDj��<:r��ҟ��	����'g ��	�2�G��} ���ΗV`i/j��&�5�ܐ|F�9�/Te�O�i$uԔ�5!�!OMEYS�ֈ��&&�����R��gJV��d�9FX�>O�|�]������%q�n��jJ��4���/�zD���,*���P�{����3���j��Q���V����$o� G�Q@C�E(�[����[��O.��xr��^k ���2?��T�5�� ���w�# H�L�e��J&>�V�o�}�Cr���(�Fp
���"l'�zR1q@A#E ����'�����#���_Jz5�T-Z 4�hGjM}�fRU5 ��?�¯�,~�ĳ6���-�<��ԷJ��v��w v�28d�ɰ���󿃅 ���O� �3�  ̨Vy�$D&�p�9�[��w,�ֵ���>� #�)�R{��?#V�����/!*.�u�Ep��D` Dƚ7 ��q6�o���Cn�E�Y�LH�������kT���=1��c�?0a���k;�V��c�Ini��_y�~���w�&��s�'�4 _=����P �uX䵟��Yt
��	�n yA`�i�)��"G{����um6���E?X�Wi��4�֬�0L�C
Vp|U���w��%�����R�!���f�s��S���h��t�Z��h��1�	�t4R��yZ��DPV�A��w��KZ��+y��\pF���$���sp��j :��	����g�o��N�WVbb�R;XYؚ�3�<'�-hY\VNE�1AERR�'�$�A�aG<a�.ۀ������mR�r(�rűQ�[�\����F��b~�1�F@{�-}:2����w�G̳R&�B�jY4��p�'N��9OȪB�@6�k``Ϻs_x����K���}�叐� �"�؄ԟ���$�C��q�� u�Ѝ����_���ο��o,���0�(�
�HD�s�A"�x$F_�
@�$���!YsR̓j�:�ꠒ�)�Y�`���U�p �Xr�������a�}��~n�z�+���-'�H�͕�3��q}��I�{��|�ڠj��=t�s��L�*JuN�+@�	����f�~��/~�����Ŀ���)���Nr&X��l���k3~}�����?���k�b�� ~�? ���[ ��7 G��(��$���W�z�7�����b�Y_����z5���0��4�����M��ĦUʫ�"��X5�:�q��߲���K��ch	@5s_�7 9��G� \�ո6�)0[����9�y�����p<���a<���t��y��#�p�ᬳX-~����?�����`ɽ�m����'_��?�xr�C�c�H�		�TB(����+�nT�2�|5��*��
��GI)����� dM� ���0̘Ӳi�.t
1>���?	-�P__��;a�hê�k1f�Z�B�Y��<��<os.X���8'�峰�br.b�������3 ���r>x-+C�ŕ�(�LU�g�/�y� kҜF@ƨ�=`(ǕfL	9�����O�����%�5UZ��/W
`�GѺ���HgWh�^��wZ���2�A�0z�f�s��y��e�oU���O=X�_���mM���p������P�8���o;����P�K$+$V/I�P��朏���iNCZP��t,���唐r�3(��!DFc��<�|@suׯ�j������k9u��sNE���ǧns�o�P��c�v��o��YB d&� �8�8��_S���gg ��������`���A�"�D�����g��ӥ�<$�\῾��i�_iJ��ƛHƈa�C��<\Tѝy�ӎ�����Z��/�H���}��.���I���2��k|$�U�;��J�+�/�+��� ��1��2��,p|�������T��@8ئA� ������
rވ�7"�M����	ނYQ�� �� dC��9��4"Zùz�/�����!�ys�h@i���[��i7d�r8N�}�&������"rp���$!���OQ��??�`A��Im���&=�I�%l��V�gy.��07����d��W�z�r�M�$I)A� �*���PB4QU7m��z ��z�L+��h�Ĝgf�t�%I��p�ܓy]%�1C��÷k68>�x�$�C��8��}��g��?t�� �x"BU����������O�����# ���WA#��=��]�	֤캉&""�$1	� 
 RH&єBA�� �T`qh֬9�����9g�Ӧ�3��K�b��+Z����Ǘw v���2ǽ�����)�����:�&��Ǉ����!��<p����ea��G֊ ��RJ�0���8�6�0��aܤ4�RJ�$i���j�3]�J����y�UuR�S��!��8��u>�gU�U�Vq��x� �aɻ ~����= �q8�C���x�P�3\r�0���O ;@�"�jBSK>�>���a0(���̚�A�,�}E��R�ZO�	�3tR��l����)uO�dy&�`a�D�}cL����2�5����4
�;x��1�C�W�z?�(�[x��d �
血x]B��Ka��{�v  dH��+P>�跪&-CrP�"c�k��K0:�Ql��[����7T�e��+9��!��C�D ,@�`0����0�_�G��`9>� ,�& 7�\Q�0
�`B�'ԉ�yU��^��!^����Rg��%m ��F����>�8��t1��R�T�U�+��H�N�H C���$�0��d,gC`�pװ��7������ ,��I����<`%%~-�E��5@����� ��LRy#*W��@�n����a��Kίx	�k��ܖq�M�߅ EN�]%�!�@9�5����7������ ,���F&�J�0E��KHk5y�m!*�(%�_��y��1u�7|�$O�"l�N � �|���������+u1(�K�D�Cs�:��d����'<�����W�C���]<�FV��M:�J�B���	��*�t)������ĝ�����]��l�X�N��*����w0.�o�#�A����s�����?���F��_�b|�@�;���E��g�)���G�����{��߯ <�vI��!� �ݞ��/����Jg9��� ����ٟLq���?����?(�����#�S'������`���� �c�m��w���Om`�� ���������o`����������t����u4�����:�����Zc��5�    IEND�B`�(   �                                                                                                                                                                                                                        :*& :*& :*& :*&:*&":*&]:*&�:*&�:*&�:*&�:*&�:*&�:*&�:*&�:*&�:*&�:*&�:*&�:*&�:*&�:*&�:*&�:*&�:*&�:*&�:*&�:*&�:*&�:*&�:*&�:*&]:*&":*&:*& :*& :*&                                                                                                                                                                                                                                                                                                                                 <,( <,( <,( <,( <,( <,(<,(<,(<,(<,(<,(<,(;,( <,( <,( <,(<,($<,(^<,(�<,(�<,(�<,(�<,(�<,(�<,(�<,(�<,(�<,(�<,(�<,(�<,(�<,(�<,(�<,(�<,(�<,(�<,(�<,(�<,(�<,(�<,(�<,(�<,(^<,($<,(<,( <,( ;,( <,(<,(<,(<,(<,(<,(<,(<,( <,( <,( <,( <,(                                                                                                                                                                                                                                                                                 :*& :*& :*& :*& :*&:*&:*&:*&:*&":*&$:+'#;+'#:+'"9*%8)$:*&$>-)@@.+s@/+�A/,�A0,�A0,�A0,�A0,�A0,�A0,�A0,�A0,�A0,�A0,�A0,�A0,�A0,�A0,�A0,�A0,�A0,�A0,�A0,�A0,�A/,�@/+�@.+s>-)@:*&$8)$9*%:+'";+'#:+'#:*&$:*&":*&:*&:*&:*&:*& :*& :*& :*&                                                                                                                                                                                                                                                                                 7(# 7(# 7(# 7(# 7(#7(#!7(#97(#N7($Z8)$]8)%]9*%[9*%Y7($V6'#T8($[<,(pB0,�F3/�H41�I52�I52�I52�I52�I52�I52�I52�I52�I52�I52�I52�I52�I52�I52�I52�I52�I52�I52�I52�I52�H41�F3/�B0,�<,(p8($[6'#T7($V9*%Y9*%[8)%]8)$]7($Z7(#N7(#97(#!7(#7(# 7(# 7(# 7(#                                                                                                                                                                                                                                                                                 8)$ 8)$ 8)$ 8)$8)$8)$:8)$d8)$�8)%�9)%�9*&�:*&�9*&�8)%�7($�9)%�=-)�E2.�K74�P:7�R<9�S<:�S<:�R<9�R<9�R<9�R<9�R<9�R<9�R<9�R<9�R<9�R<9�R<9�R<9�R<9�R<9�S<:�S<:�R<9�P:7�K74�E2.�=-)�9)%�7($�8)%�9*&�:*&�9*&�9)%�8)%�8)$�8)$d8)$:8)$8)$8)$ 8)$ 8)$                                                                                                                                                                                                                                                 <,( <,( <,( <,( <,( <,( <,(<,(;+' =,) =,( <,(<,(<,(Q<,(�<,(�<,(�<,(�<,(�<,(�<,(�;,'�;+'�=,)�A0,�I63�R<:�YA?�]CB�^DC�^DC�]DB�]CB�]CB�]CB�]CB�]CB�]CB�]CB�]CB�]CB�]CB�]CB�]CB�]DB�^DC�^DC�]CB�YA?�R<:�I63�A0,�=,)�;+'�;,'�<,(�<,(�<,(�<,(�<,(�<,(�<,(�<,(Q<,(<,(=,( =,) ;+' <,(<,(<,( <,( <,( <,( <,( <,(                                                                                                                                                                                                                 ;+' ;+' ;+' ;+' ;+';+';+';+':+'!8)$6'#:+&$@/,@D2/sE40�E41�E30�D2/�C1.�B0-�A0,�B0-�C1.�E30�J74�R=:�ZCA�bHG�fKJ�gLK�gLK�fKK�fKK�fKK�fKK�fKK�fKK�fKK�fKK�fKK�fKK�fKK�fKK�fKK�fKK�gLK�gLK�fKJ�bHG�ZCA�R=:�J74�E30�C1.�B0-�A0,�B0-�C1.�D2/�E30�E41�E40�D2/s@/,@:+&$6'#8)$:+'!;+';+';+';+';+' ;+' ;+' ;+'                                                                                                                                                                                                                 9*& 9*& 9*& 9*& 9*&9*&"9*&;9*&Q9)%\6'#\5&!Z8($_@0,sJ85�Q=<�T@>�T@>�Q=;�M97�K74�J63�L86�O;9�S?=�XCB�_HG�fMM�lQQ�oST�pTU�pTT�oST�oST�oST�oST�oST�oST�oST�oST�oST�oST�oST�oST�oST�oST�pTT�pTU�oST�lQQ�fMM�_HG�XCB�S?=�O;9�L86�J63�K74�M97�Q=;�T@>�T@>�Q=<�J85�@0,s8($_5&!Z6'#\9)%\9*&Q9*&;9*&"9*&9*& 9*& 9*& 9*&                                                                                                                                                                                                                 :*& :*& :*& :*&:+&:+&;:+&f:*&�9*&�7($�6'#�9)%�B1-�P=;�\GF�dMM�eNN�aJI�[CB�V?=�U><�YB@�^GG�dMM�iQR�nUV�rXY�uZ[�w[]�x\]�x\]�w[]�w[]�w[]�w[]�w[]�w[]�w[]�w[]�w[]�w[]�w[]�w[]�w[]�w[]�x\]�x\]�w[]�uZ[�rXY�nUV�iQR�dMM�^GG�YB@�U><�V?=�[CB�aJI�eNN�dMM�\GF�P=;�B1-�9)%�6'#�7($�9*&�:*&�:+&f:+&;:+&:*&:*& :*& :*&                                                                                                                                                                                 <,( <,( <,( <,( <,( <,( <,(<,(;,( <,( <,( <,(<,(<,(R<,(�<,(�<,(�;+'�:*&�=-)�F41�UA?�eNN�qXY�tZ[�oUV�gMM�aGF�aGF�fLL�mST�uZ\�y^`�{`c�}ad�}bd�~bd�~be�~be�~bd�~bd�~bd�~bd�~bd�~bd�~bd�~bd�~bd�~bd�~bd�~bd�~bd�~bd�~be�~be�~bd�}bd�}ad�{`c�y^`�uZ\�mST�fLL�aGF�aGF�gMM�oUV�tZ[�qXY�eNN�UA?�F41�=-)�:*&�;+'�<,(�<,(�<,(�<,(R<,(<,(<,( <,( ;,( <,(<,(<,( <,( <,( <,( <,( <,(                                                                                                                                                 ;+' ;+' ;+' ;+' ;+';+';+';+';+'!9*&9*%;+'$>-*@@.+s@/+�A/,�A0,�A0,�B1-�E41�M:8�[ED�jRR�v[]�z^`�vZ\�oST�jNN�jOO�oTU�w[]�~be��fi��gj��fi��eh��eh��eh��eh��eh��eh��eh��eh��eh��eh��eh��eh��eh��eh��eh��eh��eh��eh��eh��eh��eh��eh��fi��gj��fi�~be�w[]�oTU�jOO�jNN�oST�vZ\�z^`�v[]�jRR�[ED�M:8�E41�B1-�A0,�A0,�A/,�@/+�@.+s>-*@;+'$9*%9*&;+'!;+';+';+';+';+' ;+' ;+' ;+'                                                                                                                                                 9*& 9*& 9*& 9*& 9*&9*&"9*&;9*&Q9*&\8)%\8)%Z9*&_>-)sB0,�E2/�H41�J63�M96�P<:�T@>�ZED�cLK�lSS�sXZ�vZ\�uYZ�rVW�qUU�rVW�w[]�}ac��fi��hk��hk��fj��dh��dg��dg��dg��dg��dg��dg��dg��dg��dg��dg��dg��dg��dg��dg��dg��dg��dg��dg��dg��dg��dh��fj��hk��hk��fi�}ac�w[]�rVW�qUU�rVW�uYZ�vZ\�sXZ�lSS�cLK�ZED�T@>�P<:�M96�J63�H41�E2/�B0,�>-)s9*&_8)%Z8)%\9*&\9*&Q9*&;9*&"9*&9*& 9*& 9*& 9*&                                                                                                                                                 :*& :*& :*& :*&:*&:*&;:*&f:*&�:*&�9*&�9*%�:+&�?.*�E2/�K63�P:8�U><�[DB�`II�eNN�iQQ�kRS�lRS�nSS�pTU�rVW�tXY�vZ\�y]_�}ac��dg��gj��hk��gj��eh��cf�bf�be�be�be�bf�bf�bf�bf�bf�bf�bf�bf�bf�bf�bf�bf�be�be�be�bf��cf��eh��gj��hk��gj��dg�}ac�y]_�vZ\�tXY�rVW�pTU�nSS�lRS�kRS�iQQ�eNN�`II�[DB�U><�P:8�K63�E2/�?.*�:+&�9*%�9*&�:*&�:*&�:*&f:*&;:*&:*&:*& :*& :*&                                                                                                                                 <,( <,( <,( <,( <,( <,( <,( <,(<,(<,(R<,(�<,(�<,(�;+'�;+'�<,(�A0,�I52�Q;8�YA?�aGF�hNN�oUV�tZ\�v[]�rWY�mRS�iNN�jOO�oST�uYZ�{_a�~be��dg��eh��fi��fi��gj��gj��gj��gj��gj��gj��gj��gj��gj��gj��gj��gj��gj��gj��gj��gj��gj��gj��gj��gj��gj��gj��gj��gj��gj��gj��fi��fi��eh��dg�~be�{_a�uYZ�oST�jOO�iNN�mRS�rWY�v[]�tZ\�oUV�hNN�aGF�YA?�Q;8�I52�A0,�<,(�;+'�;+'�<,(�<,(�<,(�<,(R<,(<,(<,( <,( <,( <,( <,( <,( <,(                                                                                                                 ;+' ;+' ;+' ;+' 9*%4'"7($;+'>.*@@/+tA/,�A0,�A0,�@/+�@/+�A0,�F30�N97�X@?�aHG�iNN�qUV�w[\�z^`�z^`�uY[�nSS�iNN�jNO�oTU�w[]�~bd��dg��dg�ce�~bd��dg��il��or��tw��wz��x{��xz��wz��wz��wz��wz��wz��wz��wz��wz��wz��wz��wz��wz��wz��wz��xz��x{��wz��tw��or��il��dg�~bd�ce��dg��dg�~bd�w[]�oTU�jNO�iNN�nSS�uY[�z^`�z^`�w[\�qUV�iNN�aHG�X@?�N97�F30�A0,�@/+�@/+�A0,�A0,�A/,�@/+t>.*@;+'7($4'"9*%;+' ;+' ;+' ;+'                                                                                                                 9*& 9*& 9*& 9*& 8)%6'#7($5:*&R>-*sC1-�F30�I52�I52�I52�H52�J63�O:7�WA?�bIH�kPP�qUV�uXZ�vZ\�w[\�vZ[�rVX�nRS�lPQ�mQR�rVW�x\^�}ac�~be�{^a�vZ\�uYZ�z_a��mn��~������������������������������������������������������������������������������������������~��mn�z_a�uYZ�vZ\�{^a�~be�}ac�x\^�rVW�mQR�lPQ�nRS�rVX�vZ[�w[\�vZ\�uXZ�qUV�kPP�bIH�WA?�O:7�J63�H52�I52�I52�I52�F30�C1-�>-*s:*&R7($56'#8)%9*& 9*& 9*& 9*&                                                                                                                 :*& :*& :*& :*&9*%7($98)$c:+'�?.*�F30�L85�Q;9�S<:�S<:�S<:�T=;�XA?�aIH�kQR�sXY�w[]�vZ[�sWX�pTU�oST�oST�pTU�qUV�sWY�w[]�{^a�}`c�{_b�uXZ�nQS�lPQ�v[\��st���������Ƿ��˼��ʻ��ȸ��ȸ��ȸ��ȸ��ȸ��ȸ��ȸ��ȸ��ȸ��ȸ��ȸ��ȸ��ȸ��ȸ��ʻ��˼��Ƿ�����������st�v[\�lPQ�nQS�uXZ�{_b�}`c�{^a�w[]�sWY�qUV�pTU�oST�oST�pTU�sWX�vZ[�w[]�sXY�kQR�aIH�XA?�T=;�S<:�S<:�S<:�Q;9�L85�F30�?.*�:+'�8)$c7($99*%:*&:*& :*& :*&                                                                                                 <,( <,( <,( <,( <,( <,( <,( <,(;+':*&Q:+'�<,(�A0,�I52�Q;9�Y@?�\CB�]CB�\CA�]DB�aGG�iOO�rWY�y^_�z_a�vZ\�oTT�jOO�jOO�nST�uY[�{_a�ce��fh��gj��fi�~ce�vZ[�mQR�kPP�x_^��}}��������������������������������������������������������������������������������������������������}}�x_^�kPP�mQR�vZ[�~ce��fi��gj��fh�ce�{_a�uY[�nST�jOO�jOO�oTT�vZ\�z_a�y^_�rWY�iOO�aGG�]DB�\CA�]CB�\CB�Y@?�Q;9�I52�A0,�<,(�:+'�:*&Q;+'<,(<,( <,( <,( <,( <,( <,( <,(                                                                                 ;+' ;+' ;+' ;+' 9*%4'"7($;+'>-)@>-*t?.*�A0,�F30�M85�U><�]DB�aGF�bGF�bFE�bGF�eJJ�lQQ�tXY�y]_�y^`�tYZ�nRS�iNN�lQQ�uZ[��fh��qs��wz��z|��y|��wz��su��jk�{bb�zaa��on�����³������������������������������������������������������������������������������������������³�������on�zaa�{bb��jk��su��wz��y|��z|��wz��qs��fh�uZ[�lQQ�iNN�nRS�tYZ�y^`�y]_�tXY�lQQ�eJJ�bGF�bFE�bGF�aGF�]DB�U><�M85�F30�A0,�?.*�>-*t>-)@;+'7($4'"9*%;+' ;+' ;+' ;+'                                                                                 9*& 9*& 9*& 9*& 8)%6'#7($5:*&R>-)sB0-�E3/�I52�M85�S<:�ZA@�`ED�cHG�cHG�cGF�cGF�eII�iMM�nRS�qUW�rVW�oST�kOP�kPP�sXX��hi��|}������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������|}��hi�sXX�kPP�kOP�oST�rVW�qUW�nRS�iMM�eII�cGF�cGF�cHG�cHG�`ED�ZA@�S<:�M85�I52�E3/�B0-�>-)s:*&R7($56'#8)%9*& 9*& 9*& 9*&                                                                                 :*& :*& :*& :*&9*%7($98)$c:+'�?.*�E3/�L74�Q;9�U><�ZA?�^DC�aFE�cGG�cHG�bGF�bGF�cHG�dIH�fKK�iMM�jNO�jNO�lOP�qUV�}cd��z{���������ȸ��̼��˻��ȸ��ƶ��²����������ô����������������������������������������������������������������������������������������������������������ô����������²��ƶ��ȸ��˻��̼��ȸ�����������z{�}cd�qUV�lOP�jNO�jNO�iMM�fKK�dIH�cHG�bGF�bGF�cHG�cGG�aFE�^DC�ZA?�U><�Q;9�L74�E3/�?.*�:+'�8)$c7($99*%:*&:*& :*& :*&                                                                 <,( <,( <,( <,( <,( <,( <,( <,(;+':*&Q:+'�<,(�A0,�I52�Q;9�Y@?�]DB�`ED�aFE�bGF�bGF�bGF�bGF�bGF�cHG�dHH�eJI�gLK�jOO�mQR�rVX�|`b��rt����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������rt�|`b�rVX�mQR�jOO�gLK�eJI�dHH�cHG�bGF�bGF�bGF�bGF�bGF�aFE�`ED�]DB�Y@?�Q;9�I52�A0,�<,(�:+'�:*&Q;+'<,(<,( <,( <,( <,( <,( <,( <,(                                                 ;+' ;+' ;+' ;+' 9*%4'"7($;+'>-)@>-*t?.*�A0,�F30�M85�U><�]DB�aGE�cGF�bGF�bFE�bGF�cGG�dHH�eJJ�hML�kQP�oUT�sZZ�x`_�}dd��jk��tv���������;������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������ξ�����������tv��jk�}de�y`_�sZZ�oUT�kQP�hML�eJJ�dHH�cGG�bGF�bFE�bGF�cGF�aGE�]DB�U><�M85�F30�A0,�?.*�>-*t>-)@;+'7($4'"9*%;+' ;+' ;+' ;+'                                                 9*& 9*& 9*& 9*& 8)%6'#7($5:*&R>-)sB0-�E3/�I52�M85�S<:�YA?�_EC�bFE�aFE�`DC�_DC�`DC�bFE�eII�iNN�pUV�zaa��nm��zy���������������������Ƕ��������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������Ƿ�����������������������zy��nm�zaa�pUV�iNN�eII�bFE�`DC�_DC�`DC�aFE�bFE�_EC�YA?�S<:�M85�I52�E3/�B0-�>-)s:*&R7($56'#8)%9*& 9*& 9*& 9*&                                                 :*& :*& :*& :*&9*%7($98)$c:+'�?.*�E3/�L74�Q;9�U><�YA?�]CB�`ED�aFE�`DC�^CB�^BA�`DC�cGG�hKL�pTU�|ac��vw�������������²��Ĵ��Ƿ��ο��������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������ȸ��ŵ��²���������������vv�|ac�pTU�hKL�cGG�`DC�^BA�^CB�`DC�aFE�`ED�]CB�YA?�U><�Q;9�L74�E3/�?.*�:+'�8)$c7($99*%:*&:*& :*& :*&                                 <,( <,( <,( <,( <,( <,( <,( <,(;+':*&Q:+'�<,(�A0,�I52�Q;9�Y@?�]DB�`ED�aFE�bGF�bGF�bGF�bGF�cHG�fKJ�jOO�qUV�{`a��qs��������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������qs�{`a�qUV�jOO�fKJ�cHG�bGF�bGF�bGF�bGF�aFE�`ED�]DB�Y@?�Q;9�I52�A0,�<,(�:+'�:*&Q;+'<,(<,( <,( <,( <,( <,( <,( <,(                 <,( <,( <,( <,( :+'7($9*%<,(>.*@>.*t?.*�A0,�F30�M85�U><�]DB�bGF�dHH�eII�eJJ�hML�kQP�oUT�sZY�x`_�}dd��jk��tv���������;����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������ο�����������tv��jk�}de�x`_�sZZ�oUT�kQP�hML�eJJ�eII�dHH�bGF�]DB�U><�M85�F30�A0,�?.*�>.*t>.*@<,(9*%7($:+'<,( <,( <,( <,(                 <,( <,( <,( <,( ;+'9*&:*&5<,(R@/+sC1.�F30�I52�M85�R<9�Y@?�_ED�cHG�eII�gKK�jNO�pVV�zaa��nn��{z���������������������ȸ������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������ȸ�����������������������|{��oo�{bb�qVV�jNO�gKK�eII�cHG�_ED�Y@?�R<9�M85�I52�F30�C1.�@/+s<,(R:*&59*&;+'<,( <,( <,( <,(                 <,( <,( <,( <,(;+'9*&9:*&c<,(�A/,�F30�L85�Q;9�U><�Y@>�\CA�`ED�dHH�fJJ�jNN�qUV�|bc��vw�������������³��ŵ��ȹ����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������ȹ��Ŷ��ô���������������vw�|bc�qUV�jNN�fJJ�dHH�`ED�\CA�Y@>�U><�Q;9�L85�F30�A/,�<,(�:*&c9*&9;+'<,(<,( <,( <,(                 <,( <,( <,( <,(;+'9*&P:*&�<,(�A0,�I52�Q;9�Y@?�]DB�_EC�`ED�bGF�fJJ�jNO�qUV�{_a��qs������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������qs�{_a�qUV�jNO�fJJ�bGF�`ED�_EC�]DB�Y@?�Q;9�I52�A0,�<,(�:*&�9*&P;+'<,(<,( <,( <,(                 <,( <,( <,( <,(;+'"9*&]:*&�<,(�A0,�I52�S<:�\CB�bGF�cHG�dHH�fJJ�kPP�sXY�~ce��rt���������ο������������������������������������������������������������������������������������������������������������������������������̻��ɵ��ǲ��ư��ư��ǲ��ɵ��ͼ����������������������������������̻��ɵ��ʵ��Ϲ��տ����������������������������������������������������������������������������������������������������������̼�����������rt�~ce�sXY�kPP�fJJ�dHH�cHG�bGF�\CB�S<:�I52�A0,�<,(�:*&�9*&];+'"<,(<,( <,( <,(                 ;+' ;+' ;+' ;+':*&"8)%]9*&�;+'�@/+�I52�S<:�]CB�cHG�eII�gJJ�jNO�sXY��gh��y{���������ɹ������������������������������������������������������������������������������������������������������������������Ǽ����������������������������������������������������������������������������������������������Ȳ��������������������������������������������������������������������������������������������������������������Ƶ�����������z|��hi�sXY�jNO�gJJ�eII�cHG�]CB�S<:�I52�@/+�;+'�9*&�8)%]:*&";+';+' ;+' ;+'                 ;+' ;+' ;+' ;+'9*&"8)%]9*%�;+'�@/+�H41�R<9�]CA�dHG�gKK�jNN�qUV�~ce��y{���������ο������������������������������������������������������������������������������������������������������������������ʿ�������}�{mj�ueb�td`�uda�uc`�ub_�ub_�uc`�vda�wgd�yjg�{mj�|nk�|ol�|ol�|nk�zli�vgd�sc_�vda��pm���������ӽ��������������������������������������������������������������������������������������������������������������ͽ�����������z|�~ce�qUV�jNN�gKK�dHG�]CA�R<9�H41�@/+�;+'�9*%�8)%]9*&";+';+' ;+' ;+'         <,( <,( <,( <,( <,( <,(;+'$9*&^:+&�<,(�A0,�I52�S<:�]DB�eJJ�kOP�rUW�{`b��rt���������������������������������������������������������������������������������������������������������������������������������������~�i[X�UFB�N>:�O>;�QA=�RA=�RA=�RA=�RA=�RB>�SC?�SD@�TEA�TEB�UFB�UFB�TEB�SDA�P@<�N>:�SB>�dSO��ro�����ɴ�������������������������������������������������������������������������������������������������������������������������������rt�{`b�rUW�kOP�eJJ�]DB�S<:�I52�A0,�<,(�:+&�9*&^;+'$<,(<,( <,( <,( <,( <,( <,( <,( :+'7($9*%<,(>-*@>-*t?.*�A0,�F30�M86�V?=�aGF�kPP�tYZ�de��rt���������ο����������������������������������������������������������������������������������������������������������������������ź������{mj�UFB�>.*�7'"�8($�<,(�=-)�=-)�=-)�=-)�=-)�=-)�=-)�=-)�=-)�=-)�=-)�=-)�<,(�9)%�7($�>.*�RA=�tb_际�򶢟�Ʊ��ʵ��ɴ��ǲ��ʵ��Ϻ����������������������������������������������������������������������������������������������ͽ�����������rt�df�tYZ�kPP�aGF�V?=�M86�F30�A0,�?.*�>-*t>-*@<,(9*%7($:+'<,( <,( <,( <,(;+'9*&:*&4<,(Q@/+sC1-�F30�I53�N96�T=;�\CB�gLL�sXY��hi��z{���������ɹ��������������������������������������������������������������������������������������������������Ǽ��������������������������~{�l^Z�J:7�3#�+�.�2"�3#�3#�3#�3#�3#�3#�2"�2"�2"�2!�2!�2"�1!�.�,�4$ �H84�gURĂpmݖ�򟋈���������������������ɴ����������������������������������������������������������������������������������������������Ƶ�����������{|��hj�sXY�gLL�\CB�T=;�N96�I53�F30�C1-�@/+s<,(Q:*&49*&;+'<,(<,( <,( <,(;+'9*&7:*&a<,(�A/,�F30�L75�R<9�X@>�]DC�eJJ�oST�~ce��z{���������ο�����������������������������������������������������������������������������������������������������������}�|ol�xjg�yli�{mj�xjg�n`]�^OL�F62s0 ^(X*Y/ ]0!]0!]0!]0!]0!]0 ]0]/]/]/]/]/].]*Y)X1!^E51sZIF�iWT�q_\�tb_�sa^�r`\�vc`��qn���������Ծ����������������������������������������������������������������������������������������������ͽ�����������{|�~ce�oST�dJJ�]DC�X@>�R<9�L75�F30�A/,�<,(�:*&a9*&7;+'<,(<,( <,( <,(;+'9*&M:*&�<,(�A/,�H41�P:8�YA?�aGF�gLM�oTU�z_a��rt������������������������������������������������������������������������������������������������������������������������i[X�UFC�O@<�QA>�TEA�TEA�RC?�O?<sF73@7'#$,/6&"!7'#"7'#"7'#"7'#"7'#"6&""6&""6&""6&""6&""6&""6&""5%!!0 -8($$E51@M<8sP?;�Q@=�Q@=�N>:�M<9�SB>�eSP��ro�����ʴ���������������������������������������������������������������������������������������������������������������rt�z_a�oTU�gLM�aGF�YA?�P:8�H41�A/,�<,(�:*&�9*&M;+'<,(<,( <,( <,(;+'"9*&Z:*&�<,(�A/,�H41�Q:8�\CA�gLL�qVW�}bc��qs���������ο��������������������������������������������������������������������������տ��Ϲ��ʵ��ʶ��Ͽ����������ź������{nk�UFB�>.*�7'#�9($�<,(�=-)�=-)�=-)R=-)=-)=-) =.* 9)% <,(<,(<,(<,(<,(<,(<,(<,(<,(<,(<,(<,(9*% =-) =-) <,(=-)=-)R=-)�=-)�<,(�9)%�7($�>.*�RA=�tb_际�򶢟�Ʊ��ʵ��ɴ��ǲ��ʵ��Ϻ������������������������������������������������������������������������������ͽ�����������qs�}bd�rVW�gLL�\CA�Q;8�H41�A/,�<,(�:*&�9*&Z;+'"<,(<,( ;+' ;+':+&#8*%Z9*&�;+'�@.+�F2/�O85�[A?�iNN�{aa��vw���������ɹ������������������������������������������������������������������������������ɴ������������������������������|�l^[�J;7�3#�+�-�1!�2"�2"f2";2"2"2" 2" 2"                                                 3# 3# 3# 3#3#3#;3#f3#�2#�/�-�4$ �H84�gURĂpmݖ�򟋈���������������������ɴ������������������������������������������������������������������������������ǵ�����������wx�{bb�jOO�[B@�O86�F2/�@.+�;+'�9*&�8)%Z:*&#;+';+' ;+' ;+':*&#8)%Z9*&�;+'�?.*�D0-�M53�Z@>�lRQ��mm���������ο������������������������������������������������������������������������������Ծ�����������qn�web�tda�whe�zli�wjg�oa^�^PL�F63s0 _'Z)\.\/Q/;/"// / / /                                                 0! 0! 0! 0! 0!0!"0!;0!Q0 \+\*Z1"_E51sZIF�iWT�q_\�tb_�sa^�r`\�vc`��qn���������Ծ������������������������������������������������������������������������������ͽ�����������oo�mSR�Z@?�M64�E1.�?.*�;+'�9*%�8)%Z:*&#;+';+' <,( <,(;+'$9*&[:+&�<,(�A/,�G2/�P86�^EC�t[Z��||�����������������������������������������������������������������������������������������ʴ�������ro�eSP�SB?�N>:�PA=�SDA�TEA�RC@�O@<sF73@7'#$,/5%!!6&"6&"6&"6&"6&" 6&" 6&" 6&"                                                 7'# 7'# 7'# 7'# 7'#7'#7'#7'#6&"!1!.8($$E51@M<8sP?;�Q@=�Q@=�N>:�M<9�SB>�eSP��ro�����ʴ�������������������������������������������������������������������������������������������}|�t[Z�^EC�P86�G2/�A/,�<,(�:+&�9*&[;+'$<,(<,( 9*%<,($>-)@=,(p>-)�A0,�H52�P<9�]GE�oWV��on�����ĵ������������������������������������������������������������������������������Ӿ��ɴ����������sa^�RA=�>.*�8($�9)%�<,(�=-)�=-)�=-)R=-)=-)=-) =.* 9)% <,(<,(<,( <,( <,( <,( <,( <,(                                                 <,( <,( <,( <,( <,( <,( <,(<,(9)% =-) =-) <,(=-)=-)R=-)�=-)�<,(�9)%�7($�>.*�RA=�sa^阅�򶢟�ɴ��Ӿ������������������������������������������������������������������������������²�������kj�lSR�\DB�P;8�G51�A0,�>-*�=-)p>-)@<,($9*%:*&T<,(^?.+sA/+�D1-�J63�T@=�cNL�va`��xw�������������������������������������������������������������������������������������˵��������������mj�dSP�H84�4$ �-�.�1!�2"�2!f2!;2"2"2" 2" 2"                                                                                                                 3# 3# 3# 3#3#3#;3#f3#�2#�/�-�4$ �H84�dSOĀmjݖ��򨔑�����˵��������������������������������������������������������������������������ͼ�����������nl�rZX�`JH�S>;�J63�D1.�A/,�?.+s<,(^:*&T:*&�<,(�@/+�D0-�I41�R<:�bLJ�ydb���������ô������������������������������������������������������������������������������Ծ�����������qn�r`]�dRO�VEA�D30s1!_)Z*\.\/Q/;/"// / / /                                                                                                                 0! 0! 0! 0! 0!0!"0!;0!Q0 \+\*Z1"_D30sVEA�dRO�r`]�qn���������Ծ��������������������������������������������������������������������������Ȳ�����������ts�t][�`IG�R<:�J52�D1.�@/+�<,(�:*&�:*&�<,(�@/+�E1.�M64�ZA@�nVU��wv�����̾����������������������������������������������������������������������������������ɴ�������qm�eSP�RA>�I84�E40sC2/@8($$.0 5%!!6&"6&"6&"6&"6&" 6&" 6&" 6&"                 V V V V V V VVVVVVVVV V V V V V                 7'# 7'# 7'# 7'# 7'#7'#7'#7'#6&"!1!.8($$C2/@E40sI84�RA>�eSP��qm�����ɴ������������������������������������������������������������������������������θ�����������ml�lSQ�YA?�M75�F2/�@/+�<,(�:*&�:+&�<,(�@/+�F1.�N75�]DB�u\[�������������������������������������������������������������������������������������Ӿ��ɴ����������r`\�RA=�>.*�4$ �2"Q8($<,(=-) =-) 9)% <,(<,(<,( <,( <,( <,( <,( <,(                 T T T T TTTTT"T$T$T"TTTTT T T T                 <,( <,( <,( <,( <,( <,( <,(<,(9)% =-) =-) <,(8($2"Q4$ �>.*�RA=�r`\񖂀�����ɴ��Ӿ��������������������������������������������������������������������������̵�������vu�rXW�]DB�O86�F2/�A/+�<,(�:+&�:*&�<,(�A/+�F1.�O75�^DC�v]\���������������������������������������������������������������������������������˵��������������~li�cRN�H84�4$ �)c&9-3#3# 3# 3#                                                 

Q 

Q 

Q 

Q 

Q

Q"

Q;

QQ

Q]

Qc

Qc

Q]

QQ

Q;

Q"

Q

Q 

Q 

Q 

Q                                                 3# 3# 3# 3#-&9)c4$ �H84�cRN�~liᖂ�󨔑�����˵����������������������������������������������������������������������к�������yw�sYX�^DC�O86�F2/�A/+�<,(�:*&�:+&�<,(�@/+�F1.�N75�]DB�u]\�����������������������������������������������������������������������������Ծ�����������qn�r`\�cRN�UD@�D40s2"R%5!*0! 0! 0! 0!                                                 

R 

R 

R 

R

R

R;

Rf

R�

R�

R�

R�

R�

R�

Rf

R;

R

R

R 

R 

R                                                 0! 0! 0! 0! *!%52"RD40sUD@�cRN�r`\�qn���������Ծ������������������������������������������������������������������Ϲ�������xw�sXW�]DB�O86�F2/�A/+�<,(�:+&�:*&�<,(�A/+�F2/�O75�^DC�u]\�����������������������������������������������������������������������������ɴ�������qm�eSP�RA>�I84�D40tC3/@8($%	.7'# 7'# 7'# 7'#                                 V V V V W V W VVVRV�V�V�V�V�V�V�V�VRVVW V W V V V V                                 7'# 7'# 7'# 7'# .	%8($C3/@D40tI84�RA>�eSP��qm�����ɴ������������������������������������������������������������������Ͷ�������wv�sXW�^DC�O86�F2/�A/,�<,(�:*&�:*&�<,(�A/,�G30�Q:8�aGF�x__���������������������������������������������������������������������Ӿ��ʴ����������r`]�RA>�>.*�4$ �1"Q8($<,(=-) =-) =-) <,( <,( <,( <,(                                 T T T T 

P		G		LTZ@]t_�`�`�`�`�`�`�_�]tZ@T		L		G

PT T T T                                 <,( <,( <,( <,( =-) =-) =-) <,(8($1"Q4$ �>.*�RA>�r`]񖃀�����ʴ��Ӿ����������������������������������������������������������Ͷ�������yx�v[[�aGF�R;9�H41�A0,�<,(�:*&�9*&�<,(�B0-�I52�U=<�eKK�|bb�����������������������������������������������������������������ɴ��������������nk�eSO�I84�4$ �)c&9-3#3# 3# 3#                                                 

Q 

Q 

Q 

Q 

N		J		L5

QRZsc�j�n�p�p�p�p�n�j�c�Zs

QR		L5		J

N

Q 

Q 

Q 

Q                                                 3# 3# 3# 3#-&9)c4$ �I84�eSOʀnkᘅ�󪖓�����ɴ������������������������������������������������������η�������||�z__�eKK�U=<�J53�B0-�<,(�9*&�9*%�<,(�C1.�L86�ZBA�kQR��gh�������������������������������������������������������������Ϻ�����������ro�tb^�eTP�VEB�E40s2"R%5!*0! 0! 0! 0!                                                 

R 

R 

R 

R

O		L9

Mc

R�\�i�u�����������u�i�\�

R�

Mc		L9

O

R

R 

R 

R                                                 0! 0! 0! 0! *!%52"RE40sVEB�eTP�tb^�ro���������Ϻ��������������������������������������������������ϸ�����������ef�kQR�ZBB�M86�C1.�<,(�9*%�8)%�<,(�E30�Q=;�bJJ�v\]��pr���������ӽ��������������������������������������������������ʴ�������qn�eSP�RA=�H84�D40tC2/@8($%	.7'# 7'# 7'# 7'#                                 V V V V W V W VT

QQ

R�W�`�o���������������o�`�W�

R�

QQTVW V W V V V V                                 7'# 7'# 7'# 7'# .	%8($C2/@D40tH84�RA=�eSP��qn�����ʴ��������������������������������������������������Ѻ�����������pr�v[]�bJJ�Q=;�E30�<,(�8)%�7(#�=,)�G63�XEC�nXX��mo���������ì��ӽ��������������������������������������������������ǲ������vd`�SB>�>.*�4$ �1"^8($$<,(=-) =-) =-) <,( <,( <,( <,(                                 T T T T 

P		G		LTY@Zt\�`�h�v�����������������v�h�`�\�ZtY@T		L		G

PT T T T                                 <,( <,( <,( <,( =-) =-) =-) <,(8($$1"^4$ �>.*�SB>�vd`�����ǲ��������������������������������������������������ӽ��ì�����������mo�nXX�XEC�G63�=,)�7(#�6&"�=-)�K:7�bPN�ll�������������ͷ������������������������������������������������������ʴ������sa^�N=9�8($�-�*]1!"6'#6'# 6'# 6'#                                                 

Q 

Q 

Q 

Q 

N		J		L5

QRZsa�h�n�v���������������������v�n�h�a�Zs

QR		L5		J

N

Q 

Q 

Q 

Q                                                 6'# 6'# 6'# 6'#1!"*]-�8($�N=9�sa^�����ʴ������������������������������������������������������θ��������������ll�bPN�K:7�=-)�6&"�4$ �=-)�O?<�m][���������˺��������������������������������������������������������������˶������tb_�O>;�9)%�.�,]2#"8($8($ 8($ 8($                                                 

R 

R 

R 

R

O		L9

Mc

R�\�h�t���������������������������t�h�\�

R�

Mc		L9

O

R

R 

R 

R                                                 8($ 8($ 8($ 8($2#",].�9)%�O>;�tb_�����˶��������������������������������������������������������������˺����������m][�O?<�=-)�4$ �3#�=-)�RC@�whf�����ʾ������������������������������������������������������������������Ʊ������tb_�Q@=�<,(�2#�0 ]6&"";+';+' ;+' ;+'                                 V V V V W V W VT

QQ

R�W�`�n�������������������������������n�`�W�

R�

QQTVW V W V V V V                                 ;+' ;+' ;+' ;+'6&""0 ]2#�<,(�Q@=�tb_�����Ʊ������������������������������������������������������������������ʾ������whf�RC@�=-)�3#�2"�=-)�TEB�|ol�����������������������������������������������������������������Ӿ��ʴ����������q_\�Q@=�=-)�3#�0!P7'#<,(<,( <,( <,(                                 V V V V 

S		L

PVZ@Zt\�`�h�v���������������������������������v�h�`�\�ZtZ@V

P		L

SV V V V                                 <,( <,( <,( <,(7'#0!P3#�=-)�Q@=�q_\񖃀�����ʴ��Ӿ������������������������������������������������������������������|ol�TEB�=-)�2"�2!�=-)�UFC�~qn�������������������������������������������������������������ɴ��������������pm�iXT�P?;�=-)�3#c0 97'#<,(<,( <,( <,(                                 V V V V T

P

R5VR]sc�i�o�v�������������������������������������v�o�i�c�]sVR

R5

PTV V V V                                 <,( <,( <,( <,(7'#0 93#c=-)�P?;�iXTʃpmᙅ�󪕓�����ȳ��տ����������������������������������������������������������~qn�UFC�=-)�2!�2!�=-)�UFC�}qn���������������������������������������������������������Ϻ�����������ro�tb_�gVR�[JF�M<8s=-)R2"5/6'#<,( <,( <,( <,(                                 V V V VT

Q9

RcV�_�j�u�������������������������������������������u�j�_�V�

Rc

Q9TVV V V                                 <,( <,( <,( <,( 6'#/2"5=-)RM<8s[JF�gVR�tb_�ro���������Ϲ����������������������������������������������������������}qn�UFC�=-)�2!�2"�=-)�UFB�|ol���������������������������������������������������������ʴ�������qn�eSP�RA>�I85�E51tE51@=-).&5&!<,( <,( <,( <,(                                 V V V VT

QP

R�V�`�n����������������

��������������

�����������������n�`�V�

R�

QPTVV V V                                 <,( <,( <,( <,( 5&!&.=-)E51@E51tI85�RA>�eSP��qn�����ʵ����������������������������������������������������������|ol�UFB�=-)�2"�2"�=-)�TEA�{mj���������������������������������������������������������ǲ������uc`�SB>�>.*�4$ �1"^8($$<,(=-) =-) =-) <,( <,( <,( <,(                                 V V V VT"

Q]

R�V�`�o���������������������  ��  ��  ��  ����������������������o�`�V�

R�

Q]T"VV V V                                 <,( <,( <,( <,( =-) =-) =-) <,(8($$1!^4$ �>.*�SB?�web�����ʶ����������������������������������������������������������{nk�TEA�=-)�2"�1!�<,(�SC@�yjg���������������������������������������������������������Ʊ������q_\�M<8�7(#�-�*]1!"6'"6'" 6'" 6'"                                                 V V V VT"

Q]

R�V�`�p���������������		������  ��  ��  ��  ������		����������������p�`�V�

R�

Q]T"VV V V                                                 6'# 6'# 6'# 6'#1!"*]-�8($�O?;�vfb�����п����������������������������������������������������������{li�TDA�=-)�2"�1"�<,(�RB>�wgc�����̻��������������������������������������������������Ʊ������r`]�N=:�9)%�/�,]2#"8($8($ 8($ 8($                                                 V V V VT"

Q]

R�V�`�o�����������

����������  ��  ��  ��  ����������

������������o�`�V�

R�

Q]T"VV V V                                                 8($ 8($ 8($ 8($2""+].�9)%�QA>�yjg�����������������������������������������������������������������zif�TC@�=-)�2"�3#�=-)�RB>�vea�����ɵ��������������������������������������������������Ǳ������tb_�Q@=�<,(�2#�0 ]6&"";+';+' ;+' ;+'                                                 V V V VT"

Q]

R�V�`�n�������������������  ��  ��  ��  ��  ��  ��������������������n�`�V�

R�

Q]T"VV V V                                                 ;+' ;+' ;+' ;+'5%!".]1!�<,(�SDA�{mj���������������������������������������������������������ȵ������vda�RB>�=-)�3#�8'$�B1-�VDA�xeb�����ǲ��������������������������������������������������ǲ������uc_�RA=�=-)�3#�0!]7'#"<,(<,( <,( <,(                                                 V V V VT"

Q]

R�V�_�m���������		����  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ����		����������m�_�V�

R�

Q]T"VV V V                                                 <,( <,( <,( <,(6&"/P2"�=-)�TEA�xkh񡖓�Ĺ����������п��ɶ��ǲ��Ʊ��Ʊ��Ǳ��ǲ��ʵ��˶��Ʊ����������r`\�QA=�=-)�3#�B.+�K74�^IG�~if�����Ȳ��������������������������������������������������Ǳ������tb_�Q@=�<,(�2#�/ ]6&"";+';+' ;+' ;+'                                                 V V V VT"

Q]

R�V�_�l�~�������		����  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ����		��������~�l�_�V�

R�

Q]T"VV V V                                                 <,( <,( <,( <,(6&"/92!c=-)�RC@�pc`ʍ�~ᡖ�󪝛������������������������������������������������pm�jXT�P?;�=-)�3#�M53�U><�gPN��nk�����ʳ��������������������������������������������������Ǳ������tb_�Q@<�<,(�2"�/ ]5&"";+';+' ;+' ;+'                                                 V V V VT"

Q]

R�V�_�l�~�������		����  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ����		��������~�l�_�V�

R�

Q]T"VV V V                                                 <,( <,( <,( <,( 6&!.1!5=-)RO@=scUQ�qc`�ykh�{mj�zkh�xhe�vea�uc`�ub_�uc_�uc_�uc_�uc`�uc`�tb_�q_\�jXU�^LI�M<8s=-)^3#TV<;�^DC�nUT��rp�����˵��������������������������������������������������ǲ������uc`�RA=�=-)�3$�1!^7'#$<,(<,( <,( <,( <,( <,( <,( <,(                                 V V V VT"

Q]

R�V�`�n���������		����  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ����		����������n�`�V�

R�

Q]T"VV V V                                                 <,( <,( <,( <,( 4$ $,=-)I:6@PA=tSD@�TEA�TEA�TD@�SC?�RB>�RA=�RA=�RA=�RA=�RA=�RA=�RA=�RA=�Q@=�P?;�M=9pH73@=-)$.[@?�cHG�rXW��ts�����̵��������������������������������������������������ǲ������yeb�VDA�B0-�9($�7&"t<+'@<,(9*%7($:+'<,( <,( <,( <,(                                 V V V VS"

P]Q�W�a�r�������������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��������������r�a�W�Q�

P]S"VV V V                                                 <,( <,( <,( <,( =-) =-) =-) =-)=-)=-)R=-)�=-)�=-)�=-)�=-)�=-)�=-)�=-)�=-)�=-)�=-)�=-)�=-)�=-)�=-)�=-)�=-)O=-)<,(=-) ]A@�dIH�tYX��ut�����̵��������������������������������������������������ɳ������jg�^IG�J63�A-*�>,(�?.*s<,(R:*&59*&;+'<,( <,( <,( <,(                                 V V V VR"N]P�W�d�{�������		������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ������		��������{�d�W�P�N]R"VV V V                                                                 2" 2" 2" 2"2"2!;2!f2"�2"�2"�3#�3#�3#�3#�3#�3#�3#�3#�3#�3#�3#�3#d3#93#3#3# \A@�dHH�tYX��us�����̵��������������������������������������������������ʴ�������om�fPN�S<:�H30�C/,�@.+�<,(�:*&c9*&9;+'<,(<,( <,( <,(                                 V V V VR"L]O�W�h�

��

��		����������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ����������		��

��

��h�W�O�L]R"VV V V                                                                 / / / / //"/;/Q/]0a0 `0!^0!]0!]0!]0!]0!^0!`0!a0!]0!P0!:0!!0!0!0! [@?�cHG�sXW��ts�����̵��������������������������������������������������̵�������tr�nUT�ZA?�M64�E1.�@/+�<,(�:*&�9*&P;+'<,(<,( <,( <,(                                 V V V VQ"K]M�W�

k�������������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��������������

k�W�M�K]Q"VV V V                                                                 6&" 6&" 6&" 6&" 6&"6&"6&"6&"6&""6&"$6&"#7'##7'#"7'#"7'#"7'#"7'##7'##7'#$7'#"7'#7'#7'#7'#7'# 7'# [@?�cHG�sXW��ts�����̵��������������������������������������������������Ͷ�������wu�rXW�]DB�O86�F2/�@/+�<,(�:*&�9*&];+'"<,(<,( <,( <,(                                 V V V VP"J]L�W�		m�������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��������

m�W�M�J]P"VV V V                                                                 <,( <,( <,( <,( <,( <,( <,(<,(<,(<,(<,(<,(<,(<,(<,(<,(<,(<,(<,(<,(<,(<,(<,( <,( <,( <,( [@?�cHG�sXW��ts�����̵��������������������������������������������������Ͷ�������wv�tYX�^EC�P97�F2/�@/+�;+'�9*%�8)%]:*&";+';+' ;+' ;+'                                 T T T TN"H]K�U�		k�������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��������

m�W�M�J]P"VV V V                                                                                                                                                                         [@?�cHG�sXW��tr�����˴��������������������������������������������������Ͷ�������wv�sYX�^DC�O86�F2/�@.+�;+'�8)%�8)%]9*&";+';+' ;+' ;+'                                 S S S SN"G]J�T�		k�������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��������

m�W�M�J]P"VV V V                                                                                                                                                                         [@?�cHG�sXW��ts�����̵��������������������������������������������������Ͷ�������wv�sXW�^DC�O86�G20�A/,�<,(�:+&�9*&^;+'$<,(<,( <,( <,( <,( <,( <,( <,(                 V V V VQ"J]M�W�

m�������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��������

m�W�M�J]P"VV V V                                                                                                                                                                         [@?�cHG�sYX��vu�����ι��������������������������������������������������̶�������vu�rXV�^DB�Q97�I42�E2/�A0,�?.*�>-*t>-)@;+'7($4'"9*%;+' ;+' ;+' ;+'                 ` ` ` `["T]W�a�u�������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��������

m�W�M�J]P"VV V V                                                                                                                                                                         [?>�cHG�tZY��yw�����ҿ��������������������������������������������������̵�������tr�oUS�\B@�R98�N75�L74�I52�F30�B1-�>-*s:*&R6($56'#8)%9*& 9*& 9*& 9*&                 q q q ql"f]i�r���

������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��������

m�W�M�J]P"VV V V                                                                                                                                                                         Z?>�cHG�t[Z��|{���������������������������������������������������������̵�������rq�nSR�]B@�V;:�U<:�U=;�R;9�L85�F30�?.*�:+'�8)$c7($98*%:*&:*& :*& :*&                 � � � ��"{]}�����������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��������

m�W�M�J]P"VV V V                                                                                                                                                                         Z>=�cHG�u\[��~���������������������������������������������������������Ͷ�������wu�sYX�cHG�]BA�]BA�]CB�YA?�Q;9�I52�A0,�<,(�:+'�:*&Q;+'<,(<,( <,( <,( <,( <,( <,( <,( � � � ��"�]������������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��������

m�W�M�J]P"VV V V                                                                                                                                                                         Z>=�cHG�u]\�������������������������������������������������������������Ϲ�����������kj�sZY�kQQ�gML�dIH�]DB�U=;�L75�E3/�A0,�?.*�>-*t>-)@;+'7($4'"9*%;+' ;+' ;+' ;+' � � � ��"�]��������		����  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��������

m�W�M�J]P"VV V V                                                                                                                                                                         Z>=�cHG�v^]�������������������������������������������������������������Ծ��į�����������zy��ji�t[Z�iON�_ED�W?=�Q:8�M85�I52�E3/�B0-�>-)s:*&R7($56'#8)%9*& 9*& 9*& 9*& � � � ��"�]��������		����  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��������

m�W�M�J]P"VV V V                                                                                                                                                                         Z>=�cHG�v^]���������������������������������������������������������������������˺���������������lk�nTS�`FE�Z@>�W><�U>;�Q;9�L74�E3/�?.*�:+'�8)$c7($99*%:*&:*& :*& :*& � � � ��"�]��������		����  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��������

m�W�M�J]P"VV V V                                                                                                                                                                         Z>=�cHG�u]\����������������������������������������������������������������������������̿�������zy�sZY�bHG�]A@�]BA�]CB�Y@?�Q;9�I52�A0,�<,(�:+'�:*&Q;+'<,(<,( <,( ;,( ��  � � ��"�]��������		����  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��������

m�W�M�J]P"VV V V                                                                                                                                                                         Z>=�cHG�u\[�}|鲡����������������������������������������������������������������������������������x`_�fKJ�`DD�aED�aFE�]DB�U><�M85�F30�A0,�?.*�>-)s=-)@:*&$8)$9*%:+'!<,#H3 tL 4'?��N��������

����������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��������������

n�W�L�IPPVV V V                                                                                                                                                                         Z>=�cHG�t[Z��utá��۴�������ͽ��������������������������������������������������������������ô������~de�kOO�dGG�cFF�cGG�_ED�Y@?�R<:�M85�I52�E2/�A/,�<,(s8($_6'#Z7($\9*%\:*%P<,7@.7).��3�\��������

����������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ����������		��		��

��p�W�JcF9OVV V V                                                                                                                                                                         Y=<TcHG^qXWs~fe��sr��~顎������˻����������������������������������������������������������ƶ�������jl�qUV�hKL�eII�cHG�`ED�\CA�Y@?�U><�Q;9�L74�E2/�=-)�9)%�7($�8)%�9*&�:+&�;+#d<,89*)�
��+�I�k��������		������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ������		����������vsXR

D5

>LV V V V                                                                                                                                                                         V98cHG$jPO@jQPpmTS�u]\��on�����������������������������������������������������������������ȹ�������tv�{`b�pTU�jNN�fJJ�bGF�`ED�_EC�]DB�YA?�R;9�I52�A0,�=,)�;+'�;,(�<,(�<,(�<,'�=,&P<,)' l  � 	�
��A�u������������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ���������������t�@Z;V V V V                                                                                                                                                                         cHG bGF^CB$Y<;[[?>�dIH�v^]������������������������������������������������������������������������������rt�~ce�sXY�kPP�fJJ�dHG�cHG�bGF�^DC�W@>�P;9�I64�E30�C2.�B1-�A0,�A/,�@/+�?.*s>-)@;+##A- D0 7).$' fA�t��������		����  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ����		�����������^�$~� � � V V V V                                                                                                                                                                         ]BA ]BAX<;#R54ZU87�^CB�rYX��~�����������������������������������������������������������������Ƿ�����������z{��gh�sXY�jNO�fJJ�dHH�cHG�aFE�^ED�[DB�WBA�T@>�P<:�M97�J64�H41�E2/�A/,�<,'s8( \9(P<*
M9)V0$@k&f���������		����  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ����		�����������]�"�� � �                                                                                                                                                                                         ^CB ^CBY=<#T76ZV98�_DC�sZY������������������������������������������������������������������������;�����������y{�~ce�qTV�iMM�eII�dHH�cHG�dJJ�fMM�gOP�eNN�aJI�[DC�U>=�P:8�J63�D1.�=,(�9)#�9)�:)�9)!�3&8�*"Y�!x�������	����  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ����		�����������]�"�� � �                                                                                                                                                                                         aFE aFE]A@"W;:ZY=<�bGF�u\[��~��������������������������������������������������������������������������������������rt�{_a�pTU�iMN�fKJ�fKJ�jOO�pVW�u[\�tZ\�pUV�hNN�aGF�YA?�Q;8�I52�A0,�=-(�<,#�=-"�<,(�7):�.%U�$t�����������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ����		�����������]�"�� � �                                                                                                                                                                                         bGF bGF]BAX;:MZ>=�cHG�u\[��|{񱠟�������������������������������������������������������������������������ο�����������rt�}bd�rWX�kPP�iNN�nRS�tYZ�z^`�z^`�v[\�pUU�iNN�bHG�YB@�Q<:�J74�F40�F4-�F4,�E41�?0?�5*W�)"t�����������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ����		�����������]�"�� � �                                                                                                                                                                                         bGF bGF]BAX;:7Z>=acHG�sZY��srʟ��Ს��������������������������������������������������������������������������ȸ�����������y{��gh�tYZ�mRS�nRS�rVW�vZ[�w[\�vZ[�tXY�qUV�lRR�fMM�^GG�XCB�UA?�UA<�VA;�T@?�M;L�?2`�/'z�����������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ����		�����������]�"�� � �                                                                                                                                                                                         bGF bGF]BAW:9Z=<4cHGQpWVs|dc��poƒ}|ꡎ��������������������������������������������������������������������������ο�����������z{�~df�sWY�nRS�nRR�oST�pTU�rWW�uY[�w[]�v[\�rXY�nUV�jRR�hPP�iQN�jQM�gOQ�]H[�K<k�5-��"����������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ����		�����������]�"�� � �                                                                                                                                                                                         bGF bGF \@?O21V98cHGjPO@jPOtmTS�v]\��on������������������������������������������������������������������������������������������rt�{`b�rUW�lPQ�jNN�jOO�nST�uY[�z_a�}ad�}ad�{`b�y_a�y^`�{`^�|`^�x^`�kTh�UEt�;2��$ ����������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ����		�����������]�"�� � �                                                                                                                                                                                         bGF bGF cHG cHG cHG bGF^CBY=<Q[?>�dIH�u]\��|{񱠟�������������������������������������������������������������������������ͽ�����������np�{`a�qVV�kPP�iNN�mQR�sXY�z^`�}ad�cf��eg��eh��fh��hh��ig��ei�s[n�[Iv�>4��$ ����
������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ���������������]�"�� � �                                                                                                                                                                                                 Z>= Z>= Z>= Z>=U87O109Q43c[?>�mSR��nmʜ��ᱠ��������������������������������������������������������������������������ı�����������qr�}ab�qVV�kOP�kOP�nRS�rVX�vZ\�z^`�be��fi��hk��kk��kk��hl�u]n�[Iq�=3w�"����	������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ������������}�{]�"�� � �                                                                                                                                                                                                 X;: X;: X;: X;: R54J,+N0/5Y=<RiONsx`_��nmƑ|{ꡎ��������������������������������������������������������������������������Į�����������qr�{`a�qUV�kOP�jMN�jNO�mQR�sWX�z^`��dg��hk��kl��kk��gk�t\k�ZHi�;0j�q���������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ������

����r�i�f]l"qq q q                                                                                                                                                                                                 ]BA ]BA ]BA ]BA V98F'&N10^CBhNM@iONtmSR�u]\��on�����������������������������������������������������������������������������Ư�����������np�{`b�rVX�lQR�jOO�kPP�pUV�x\^�ce��gi��jk��jj��fi�sZg�XFb�8.^�b�u�������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��������u�a�W�T]["`` ` `                                                                                                                                                                                                 bGF bGF bGF bGF cHG cHG cHG bGF^CBY=<Q[?>�dIH�u]\��|{񱠟���������������������������������������������������������������������Ҽ���������������tv��jl�}dd�y``�w^^�y__�|bc��dg��fi��hj��ij��ei�rYe�VE]�7-W�Z�

m�������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��������

m�W�M�J]Q"VV V V                                                                                                                                                                                                                 Z>= Z>= Z>= Z>=U87O109Q43c[?>�mSR��nmʜ��ᱠ����������������������������������������������������������������������ͷ���������������������������}|��uu��mo��gj��dg��ef��fg�cf�pXc�UC[�6+T�W�

k�������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��������		k�T�J�G]N"SS S S                                                                                                                                                                                                                 X;: X;: X;: X;: R54J,+N0/5Y=<RiONsx`_��nmƑ|{ꡎ����������������������������������������������������������������������ѿ��˻��Ƿ��ĵ��³���������������}��lo��cf��bd��de�~be�oWc�UC[�6+U�W�

k�������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��������		k�U�K�H]N"TT T T                                                                                                                                                                                                                 ]BA ]BA ]BA ]BA V98F'&N10^CBhNM@iONtmSR�u]\��on����������������������������������������������������������������������������������������������������������uw��gj��ef��gg��fi�rZf�WE^�7-W�Y�

m�������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��������		m�W�L�I]P"VV V V                                                                                                                                                                                                                 bGF bGF bGF bGF cHG cHG cHG bGF^CBY=<Q[?>�dIH�u]\��|{񱠟�����������������������������������������������������������������������������������������̼�����������tv��rr��tt��ru�|ep�^Me�;1[�[�		m��� ����  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��������

m�W�M�J]P"VV V V                                                                                                                                                                                                                                 Z>= Z>= Z>= Z>=U87O109Q43c[?>�mSR��nmʜ��ᱠ�������������������������������������������������������������������������������������������������������������������x��jZr�?6a�[�k�  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��������

m�W�M�J]P"VV V V                                                                                                                                                                                                                                 X;: X;: X;: X;: R54J,+N0/5Y=<RiONsx`_��nmƑ|{ꡎ��������������������������������������������������������������������������������������о��í����������������������xi��G?j�^�j�  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��������

m�W�M�J]P"VV V V                                                                                                                                                                                                                                 ]BA ]BA ]BA ]BA V98F'&N10^CBhNM@iONtmSR�u]\��on�����³��������������������������������������������������������������������������������������һ��ս��׿��й�������{��ULu�'#e�n���  ����  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��������

m�W�M�J]P"VV V V                                                                                                                                                                                                                                 bGF bGF bGF bGF cHG cHG cHG bGF^CBY=<Q[?>�dIH�u]\��}|񲡠�����������������������������������������������������������������������������������������������������ı������ka��@:s�#!x�����������  ��  ��  ��  ��  ��  ��  ��������������

n�W�L�IPPVV V V                                                                                                                                                                                                                                                 Z>= Z>= Z>= Z>=U87O109Q43c[?>�mSR��nnʝ��ᱠ������̼������������������������������������������������������������������������������������������κ���������j`��NG��62��" ������������  ��  ��  ��  ����������		��		��

��p�W�JcF9OVV V V                                                                                                                                                                                                                                                 X;: X;: X;: X;: R54J,+N0/5Y=<RiONsx`_��onƑ|{ꠍ������ͼ������������������������������������������������������������������������������������������Ʋ����������s��^V��<8�� ����������  ��  ��  ��  ������		����������vsXR

D5

>LV V V V                                                                                                                                                                                                                                                 ]BA ]BA ]BA ]BA V98F'&N10^CBhNM@jPOtmTS�u]\��on�����������������������������������������������������������������������������������������������������ѽ��İ�������u��SL��+(����������  ��  ��  ��  ���������������t�@Z;V V V V                                                                                                                                                                                                                                                 bGF bGF bGF bGF cHG cHG cHG bGF^CBY=<Q[?>�dIH�u]\��}|񲡠�������������������������������������������������������������������������������������������������������������`X��1.����������  ��  ��  ��  ����		�����������^�$~� � � V V V V                                                                                                                                                                                                                                                                 Z>= Z>= Z>= Z>=U87O109Q43c[?>�mTS��qpʟ��ᱡ�󺪩�������������³������������������������������������������������������������������������������ɵ������d\��40����	������  ��  ��  ��  ����		�����������]�"�� � �                                                                                                                                                                                                                                                                                 X;: X;: X;: X;: R54J,+N0/5Y=<RjPOs|ed��tsƑ}|ꔀ��~}��}|������������������������������������������������������������������������������������Ǵ������c[��30����	������  ��  ��  ��  ����		�����������]�"�� � �                                                                                                                                                                                                                                                                                 ]BA ]BA ]BA ]BA V98F'&N0/^CBjPO@qWVts[Z�u\[�u\[�rYX�qXW�v]\��on�����õ����������������������������������������������������������������������ð������aY��2/����������  ��  ��  ��  ����		�����������]�"�� � �                                                                                                                                                                                                                                                                                 bGF bGF bGF bGF cHG cHG cHG bGFcHGcHGRcHG�cHG�bGF�_DC�^CB�dIH�u]\ᔀ鴤������������������Ϻ��Ϲ��ӽ������������������������������������������ð������_W��0-����������  ��  ��  ��  ���������������]�"�� � �                                                                                                                                                                                                                                                                                                 Z>= Z>= Z>= Z>=Z>=Z>=;Z>=fZ>=�Y=<�V:9�U87�[?>�mSR��rqġ��ݱ��򸦥�����������������î������������������������������������������Ų������^V��-+����������  ��  ��  ��  ������������|�z]"�� � �                                                                                                                                                                                                                                                                                                 X;: X;: X;: X;: X;:X;:"X;:;X;:QW;:\S76\R54ZY<;_jPOs}fe��tsđ|{�}|��zx��ut��wu���������̺��������������������������������������Ƴ������\T��*(�����  ����  ��  ��  ��  ������

����q�h�f]k"pp p p                                                                                                                                                                                                                                                                                                 ]BA ]BA ]BA ]BA ]BA]BA]BA]BA\A@!X<;V98^CB$jPO@qXWst[Z�u\[�t[Z�qXW�pUT�tZY��kj�����������������������������������������������������YQ�)&n�u���  ����  ��  ��  ��  ��������u�a�W�T]["`` ` `                                                                                                                                                                                                                                                                                                 bGF bGF bGF bGF bGF bGF bGFbGF`DC cHG cHG bGFcHGcHGQcHG�cHG�bGF�_DC�^CB�cIH�u\[��~}鱢��ɽ����������Ͽ��ɶ��Ȳ��˵��ͷ��Ʊ�������w��UKn�*%^�e���������������������

m�W�M�JOQVV V V                                                                                                                                                                                                                                                                                                                                 Z>= Z>= Z>= Z>=Z>=Z>=:Z>=dZ>=�Z>=�W;:�V:9�\@?�kSR��on����ۥ��򪝛������������������������������|�pbl�NCX�/'L�S�m�
������������������		h�

S�H`E7L

R

R 

R 

R                                                                                                                                                                                                                                                                                                                                 X;: X;: X;: X;: X;:X;:!X;:9X;:NX;:YV98YU87WY>=[dMKpo][�wge�zli�{mj�zkh�xhe�vea�uc`�wd`�wea�ub_�kZZ�[KN�G9B�4)<�&C�V�o�
��������������x�		ep

ROE3A

J

Q 

Q 

Q 

Q                                                                                                                                                                                                                                                                                                                                 ]BA ]BA ]BA ]BA ]BA]BA]BA]BA^BA!`AAaAA]CB$YDB@VEBsUFB�UEB�TEA�SD@�SC?�RB>�RA=�RB>�SB>�RA=�N>;�I86�A21�9+0�0$6�$D�U�d�

m�o�	o�		m�

l�

k�

ht

a@UC;LT T T T                                                                                                                                                                                                                                                                                                                                 bGF bGF bGF bGF bGF bGFbGFbGFË� 1%  5'# Q;9?.*$>-)^=-)�=-)�=-)�=-)�=-)�=-)�=-)�=-)�=-)�=-)�=-)�>-'�>-'�<,)�5'/�* 9�F�Q�W�	
Y�

X�W�W�W�W^W$WW W W V V V V                                                                                                                                                                                                                                                                                                                                                                 2" 2" 2" 2"2""2!]2!�2"�2"�2"�3#�3#�3#�3#�3#�3#�5% �9( �<+"�=,%�8)+�,"4�>�G�L�

N�
N�M�M�M�M]M"MM M M                                                                                                                                                                                                                         �������  ������������  ����������      ���������      ���������      ��������      �������        �������        �������        ������        �����          �����          �����          �����          �����          �����          �����          �����          ����            ���            ���            ���            ���            ���            ���            ���            ��              �              �              �              �              �              �              �              �              �              �              �              �     ��     �     ���     �     ���     �     ���          �����          �����          �����          ����         ������        ������        ������        ������        ��  ��        ��  ��        ��  ��        ��  ��       ���  ���      ���  ���      ���  ���      ���  ���      ��    ��      ��    ��      ��    ��      ��    ��      ��    ��      ��    ��      ��    ��      ��    ��      ��    ��      ��    ��      ��    ��      ��    ��      ��    ���    ��    ���    ��    ���    ��    ���    ��    ���    ��    �����   ��    �����   ��    �����    �    �����    �    �����    �    �����    �    �����    �    �����    �    �����    �    �����    �    �����          �����          �����          �����          ������        �������        �������        �������        �������        �������        �������        �������        �������        �������        �������        �������        ��������       ��������       ��������       ��������       ��������       ��������       ��������       ��������       ���������      ���������      ���������      ���������      ���������      ���������      ���������      ���������      ����������     ����������     ����������     ����������     �����������    �����������    �����������    �����������    ������������  �������������  �������(   @   �           @                                                                                                              ;+' ;+' ;+'>;+'�;+'�;+'�;+'�;+'�;+'�;+'�;+'�;+'�;+'�;+'�;+'�;+'>;+' ;+'                                                                                                                                                                 8($ 8($ 8($8($.8)%>9*&=8)%97(#8?.*kD1.�E2/�E2/�D2/�D2/�D2/�D2/�D2/�D2/�E2/�E2/�D1.�?.*k7(#88)%99*&=8)%>8($.8($8($ 8($                                                                                                                                         :*& :*& :*&.:*&�:*&�;+'�:+&�9*&�C1-�R;9�X@>�X@>�X?>�X?>�X?>�X?>�X?>�X?>�X@>�X@>�R;9�C1-�9*&�:+&�;+'�:*&�:*&�:*&.:*& :*&                                                                                                                         :*& :*& :*&:*&/8)$<6'#:D30lL97�K86�G41�F30�J75�T?=�cJJ�kPP�kOO�kOO�kOO�kOO�kOO�kOO�kOO�kOO�kPP�cJJ�T?=�J75�F30�G41�K86�L97�D30l6'#:8)$<:*&/:*&:*& :*&                                                                                                         ;+' ;+' ;+'/;+'�:*&�8)%�K86�gPP�lSS�^ED�]EC�jQQ�sZ[�y]_�{_a�{_a�{_a�{_a�{_a�{_a�{_a�{_a�{_a�{_a�y]_�sZ[�jQQ�]EC�^ED�lSS�gPP�K86�8)%�:*&�;+'�;+'/;+' ;+'                                                                                         :*& :*& :*&:*&/9*&<9*%:@.+lC1.�F30�J75�YDB�qWX�x\^�oST�pUU�~bd��hk��fi��eh��eh��eh��eh��eh��eh��eh��eh��eh��eh��fi��hk�~bd�pUU�oST�x\^�qWX�YDB�J75�F30�C1.�@.+l9*%:9*&<:*&/:*&:*& :*&                                                                         ;+' ;+' ;+'/;+'�:+'�:+&�C1-�Q;9�^FE�kSS�pVW�lQQ�nRS�v[\�}ad��fi��gj��eh��cf��cg��cg��cg��cg��cg��cg��cg��cg��cf��eh��gj��fi�}ad�v[\�nRS�lQQ�pVW�kSS�^FE�Q;9�C1-�:+&�:+'�;+'�;+'/;+' ;+'                                                                 :*& :*& 6(#8)%*@/+nD2.�D2/�D2.�N97�bHG�pTU�y\^�w[\�lPQ�mRR�{_a�cf�z^`��fh��{}������������������������������������������{}��fh�z^`�cf�{_a�mRR�lPQ�w[\�y\^�pTU�bHG�N97�D2.�D2/�D2.�@/+n8)%*6(#:*& :*&                                                         ;+' ;+' 8)%.:*&�C1.�R<:�X@>�X@>�aHG�tXZ�x\^�nSS�mQQ�tXY�z^`�be�x\^�jNO��hh��������������������������������������������������hh�jNO�x\^�be�z^`�tXY�mQQ�nSS�x\^�tXZ�aHG�X@>�X@>�R<:�C1.�:*&�8)%.;+' ;+'                                                 :*& :*& 6(#8)%*?.*nC1.�L75�[BA�cHG�bGF�hML�tXY�tXZ�kOO�tYZ��xy����������}��po����������������������������������������������������������po��}����������xy�tYZ�kOO�tXZ�tXY�hML�bGF�cHG�[BA�L75�C1.�?.*n8)%*6(#:*& :*&                                         ;+' ;+' 8)%.:*&�C1.�R<9�[BA�`FE�cGF�bGF�cHG�eJI�jNN�qUV��vw��������������������������������������������������������������������������������������������������vw�qUV�jNN�eJI�cHG�bGF�cGF�`FE�[BA�R<9�C1.�:*&�8)%.;+' ;+'                                 :*& :*& 6(#8)%*?.*nC1.�L75�[BA�bGF�aED�aFE�eJJ�oTT�|ed��rr��~����������������������������������������������������������������������������������������������������������~���rr�|ed�oTT�eJJ�aFE�aED�bGF�[BA�L75�C1.�?.*n8)%*6(#:*& :*&                         ;+' ;+' 8)%.:*&�C1.�R<9�[BA�`ED�aFE�_DC�cHG�pSU��tv����������������������������������������������������������������������������������������������������������������������������������tv�pSU�cHG�_DC�aFE�`ED�[BA�R<9�C1.�:*&�8)%.;+' ;+'                 <,( <,( 9*&;+'*@/+nC1.�L75�[B@�dHH�gKK�oTT�}ed��ss��~����������������������������������������������������������������������������������������������������������������������������������������������ss�}fe�oTT�fKK�dHH�[B@�L75�C1.�@/+n;+'*9*&<,( <,(         <,( <,( :*&.;+'�D2.�R<:�[B@�_ED�fJJ�qTV��tv������������������������������������������������������������������������������������������������������������������������������������������������������������������tv�qTV�fJJ�_ED�[B@�R<:�D2.�;+'�:*&.<,( <,(         ;,( ;,( 9*&>:+'�E2/�X@>�dHH�fJJ�tYZ��vw�����������������������������������������������������������������������������������������ù��ù��������������Ծ�����������������������������������������������������������vx�tYZ�fJJ�dHH�X@>�E2/�:+'�9*&>;,( ;,(         ;+' ;+' 9*%>:+&�D2.�X?=�gKK�qTV��vw������������������������������������������������������������������|y�bSO�aPM�bPM�bPM�cRO�eVS�gXU�gXU�cTQ�`OL��mj�­���������������������������������������������������������������vx�qTV�gKK�X?=�D2.�:+&�9*%>;+' ;+'     <,( 9*&;+'*@/+nC1.�M85�^ED�tZZ��vx���������������������������������������������������������ø��ĺ������`QN�2"�4$ �7'#�7'#�7'#�7&"�6&"�6&"�4$ �3#�\KGМ��𶡟���������տ���������������������������������������������������wx�uZZ�^ED�M85�C1.�@/+n;+'*9*&<,( <,( :*&-;+'�D1.�R<9�_FE�nST��vx����������������������������������������������������������|y�cUR�eVS�cTQ�O@<l,9.;2#>2#>2">1!>1 >1 >.;-9M=9l_MJ�`OK�_NJ��nk�­�������������������������������������������������������vx�nST�_FE�R<9�D1.�;+'�:*&-<,( ;,( 9*&<:+'�C1-�V=<�oTT��tv�����������������������������������������տ������������������`RN�2"�4#�6&"�6&"/6&" 6&"                         7'# 7'# 7'#/7'#�5%!�3$�\KGМ��𶡟���������տ�������������������������������������������uw�oUU�V><�C1-�:+'�9*&<;,( ;+' 9*&<:+&�B/,�S:9�|dc���������������������������������������������­���nk�`PL�dUQ�cTQ�P@=l+:.<1!/1!1! 1!                         2# 2# 2#2#// <-:M=9l_MJ�`OK�_NJ��nk�­����������������������������������������������}ed�T;9�B/,�:+&�9*&<;+' ;+'8?.*kC0-�S?<�r\Z�����������������������������������������������������[JG�3#�4$ �6&"�6&"/6&" 6&"                                                         7'# 7'# 7'#/7'#�5%!�3$�[JGЛ���������������������������������������������������oVT�Q=:�C1-�?.*k;+'8;+'�B0,�P97�u_]��������������������������������������������������nk�[JF�I85l-:.<1!/1 1! 1!                                                         2# 2# 2#2#// <-:I85l[JFЀnk�����������������������������������������ʴ������qYW�P:8�C0-�;+'�;+'�C0-�U=;��po�������������������������������������������������[IF�2"�-.7'# 7'#                         

R 

R 

R

R/

R@

R@

R/

R

R 

R                         7'# 7'# -.2"�[IF՚�������������������������������������������«���gf�V=<�C1-�;+'�;+'�C0-�U<:��on������������������������������������������nk�[JF�I84n+*#2# 2#                         T T T/T�T�T�T�T/T T                         2# 2# #+*I84n[JFрnk������������������������������������������gf�U=;�C0-�;+'�;+'�E2/�ZA@��qq�ͽ��������������������������տ��­������[JF�2"�-.7'# 7'#                         

R 

R 		K

N*^nf�g�g�f�^n

N*		K

R 

R                         7'# 7'# -.2"�[JF՛���­��տ�������������������������������kk�ZBA�E2/�;+'�:+&�I63�fMN��yz�ɴ�������������������������������nj�\KG�I95n+*#2# 2#                         T T 

O.

Q�d���������d�

Q�

O.T T                         2# 2# #+*I95n\KGрnj�����������������������������Ů���wx�fMN�I63�:+&�9)%�R@>��nn�����ϸ������������������������������`NK�3#�.>8($ 8($                         

R 

R 		K

N*\nd�u���������u�d�\n

N*		K

R 

R                         8($ 8($ .>3#�`NK�����������������������������Ϲ�������nn�R@>�9)%�7'#�`QN�����������������������������������������aPL�5%!�/ >:*& :*&                         T T 

O.

Q�d�����������������d�

Q�

O.T T                         :*& :*& / >5%!�aPL�����������������������������������������`QN�7'#�6&"�gYV�Ż��������������������������տ��­������_MJ�7'#�2".<,( <,(                 V V 

QT*^nd�t�����������������t�d�^nT*

QV V                 <,( <,( 2".7'#�_MJ՜���­��տ��������������������������Ż��gYV�6&"�6&"�gYV�Ż�������������������������������mj�\KH�N=9n6'#*0 <,( <,(                 V V 

R.T�e���������

������

����������e�T�

R.V V                 <,( <,( 0 6'#*N=9n\KHрmj�����������������������������Ż��gYV�6&"�6&"�eVS���������������������������������_NJ�3#�.>8($ 8($                         V V 

Q>T�g�����������  ��  ������������g�T�

Q>V V                         8($ 8($ .>3#�aPM���������������������������������fWT�7&"�6&"�bRN���������������������������������`OK�5%!�0 >:*& :*&                         V V 

Q>T�f�����

������  ��  ������

������f�T�

Q>V V                         :*& :*& />4$ �eVS�µ������������������������������dSP�7'#�@.+�iUR���������������������������������bPM�6'#�2">;,( ;,(                         V V 

R>T�e�������  ��  ��  ��  ��  ��  ��������e�T�

R>V V                         <,( <,( 1 .6&"�cURը���µ��������������������������_MJ�7'#�U<;�x`^���������������������������������aPL�6'"�1">;+' ;+'                         V V 

R>T�e�������  ��  ��  ��  ��  ��  ��������e�T�

R>V V                         <,( <,( /6&"*TEBndUR�fWT�cSO�bPM�bPM�bQM�bPM�_MJ�Q@<k7'#8_DC��fd���������������������������������iVS�@.*�<+'n;+'*9*&<,( <,(                 V V P>S�l�������  ��  ��  ��  ��  ��  ��������l�S�P>V V                                 6&" 6&" 6&"/6&"�7&"�7'#�7'#�7'#�7'#�7'#�7'#�7'#.7'# _CC�ed���������������������������������ya_�P97�B0,�;+'�:*&.<,( <,(                 V V M>Q�

x�������  ��  ��  ��  ��  ��  ��������

x�Q�M>V V                                 1! 1! 1 1!/1!?2">2#>2#>2#>2#?2#.2#2# ^CB�ed����������������������������������gf�V><�C0-�:+'�9*&>;,( ;,(                 U U K>P�}���  ��  ��  ��  ��  ��  ��  ��  ��  ��  ����~�Q�L>V V                                                                                     ^CB�ed����������������������������������gf�V=<�C0-�:+&�9*%>;+' ;+'                 T T J>O�}���  ��  ��  ��  ��  ��  ��  ��  ��  ��  ����~�Q�L>V V                                                                                     ^CB��gf���������������������������������ec�V=<�J52�D1.�?.+n8)%*6(#:*& :*&         h h ^>c�����  ��  ��  ��  ��  ��  ��  ��  ��  ��  ����~�Q�L>V V                                                                                     ^BA��kj�ɹ������������������������������}cb�[@?�Y@>�S<:�C1.�:*&�8)%.;+' ;+'         � � �>������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ����~�Q�L>V V                                                                                     ^BA��nm�����������������������������Ȳ������zcb�jPO�ZA@�L74�C1.�?.*n8)%*6(#:*& :*& � � �>������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ����~�Q�L>V V                                                                                     ^BA��nm�����������������������������������������|dc�]BA�Z@?�R<9�C1.�:*&�8)%.;+' ;+' � � �>������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ����~�Q�L>V V                                                                                     ^BA��jiз����������������������������������������ss�dHH�bGF�[B@�L75�C1.�>-)l7(#:8)%<<,,I3 
�+����		������  ��  ��  ��  ��  ��  ��������

��P�J.V V                                                                                     ]BA8rYXkgfΝ��������������������������������������pSU�fJJ�_ED�[B@�R<9�C1-�9*&�:+&�;+&�<,#- ��#�i������  ��  ��  ��  ��  ��  ���������n

H*		8V V                                                                                     _CB V98<Z>=��kj��������������������������������������vx�tYZ�fJJ�dHG�]DC�R=;�J85�F41�C1.�?.*l:)5>+	1' ch������  ��  ��  ��  ��  ��  ���������>� �                                                                                             `ED W;:<[@?��lk������������������������������������������vx�pTU�eJI�eKJ�nTU�lSS�_FE�Q;8�B0-�:*"�;+ �0%F�������  ��  ��  ��  ��  ��  ���������>� �                                                                                             bGF Y=<-^BA��ihն��������������������������������������������vw�sYY�lPQ�v[\�x\^�pTU�cJI�T?=�M:5�M:5�@2O�% ������  ��  ��  ��  ��  ��  ���������>� �                                                                                             bGF W;:]BA*qXWn~feў��������������������������������������������vx�rVX�lPP�nSS�w\]�y^`�sZ[�qXW�rYW�[Hi�-'������  ��  ��  ��  ��  ��  ���������>� �                                                                                                 ^BA ^BA U87.Y=<�}edյ��������������������������������������������oq�rVV�jOO�tXY�|`b��eh��ij��ij�iTq�/)������  ��  ��  ��  ��  ��  ���������>� �                                                                                                 Y=< Y=< L.-S65*mTSn}feў��������������������������������������������oq�qUV�iMN�mQR�|`b��ik��ij�gRg�*$e�����  ��  ��  ��  ��  ��  ������c�^>h h                                                                                                         ^BA ^BA U87.Y=<�}edյ�����������������������������������ϸ�������~���rr��jj��fh��fh��gh�dO`�'!U�}���  ��  ��  ��  ��  ��  ����}�O�J>T T                                                                                                         Y=< Y=< L.-S65*mTSn}feў����������������������������������������������������z|��ce��df�dN`�'!U�~���  ��  ��  ��  ��  ��  ����}�P�K>U U                                                                                                                 ^BA ^BA U87.Y=<�}edյ����������������������������������������������������}}���uar�+%[�}�  ��  ��  ��  ��  ��  ��  ����~�Q�L>V V                                                                                                                 Y=< Y=< L.-S65*mTSn}feџ�������������������������������������������Ҿ��ɱ��˳������50e� {�  ��  ��  ��  ��  ��  ��  ����~�Q�L>V V                                                                                                                         ^BA ^BA U87.Y=<�}feյ�������������������������������������������������������f]��,)��������  ��  ��������

��P�J.V V                                                                                                                         Y=< Y=< L.-S65*mTSn}feѝ�����������������������������������������������Կ�������x��62��

����  ��  ���������n

H*		8V V                                                                                                                                 ^BA ^BA T87.Y=<�~feն�������Ϳ����������������������������������������������ID������  ��  ���������>� �                                                                                                                                         Y=< Y=< L.-S65*qXWn�jiтlk��ji���������������������������������������������IC������  ��  ���������>� �                                                                                                                                                 ^BA ^BA ^BA/^BA�\@?�Z>=�gfз���ʺ��­��Ǳ��������������������������E@��
����  ��  ���������>� �                                                                                                                                                 Y=< Y=< Y=<Y=</W:9<U87:qXXl�jiЁih�~dc�����������������������������@;|���  ��  ��  ������c�^>g g                                                                                                                                                                 ^BA ^BA ^BA.^BA�\@?�[?>�}geΰ��������������������~��>5Z�h���������y�N�I-T T                                                                                                                                                                 Y=< Y=< Y=<Y=<.Y<;;Y<;8bNLkfWT�fWS�cSO�cQM�cQN�WFE�=/7�%D�k����		{�		kmK)C

R 

R                                                                                                                                                                                 6&" 6&" 6&">6&"�7&"�7'#�7'#�7'#�9)#�=,%�2%1�G�
R�Q�Q�Q>Q Q                                                                                                             ����������  �����  ����    ���    ���    ���    ���    ���    ��      �      �      �      �      �      �      �      �      �      �  �  �  �    ���    ���    ��    ��    ��    ��   ����  ����  �  �  �  �  �  �  �  �  �  �  �  �  �  � �  � �  �� �  ��  ~  ��  ~  ��    ��    ��     ��     ���   ����   ����   ����   ����   ����   ����   ����   ����   ����   �����  �����  �����  �����  �����  �����  ������ ������ ������ ���(   0   `           $                                                                                      <,( <,( <,(�<,(�<,(�<,(�<,(�<,(�<,(�<,(�<,(�<,(<,( <,(                                                                                                                         7(# 7(#7(#g8)%�9*%z7($zF3/�M85�M85�M85�M85�M85�M85�M85�M85�F3/�7($z9*%z8)%�7(#g7(#7(#                                                                                             :+' :+':+'$6'#%A0-NG63�E30�C1.�F52�XA@�hML�hML�hLL�hLL�hLL�hLL�hML�hML�XA@�F52�C1.�E30�G63�A0-N6'#%:+'$:+':+'                                                                                 <,( <,($<,(�9*%�G52�nUV�iPP�_FE�qWY�z_b�}ac�}ac�}ac�}ac�}ac�}ac�}ac�}ac�z_b�qWY�_FE�iPP�nUV�G52�9*%�<,(�<,($<,(                                                                     9*& 9*&9*&j8)%?.*�K74�V@?�bLK�pUV�sWX�vZ\��fi��fj�cf�cf�cf�cf�cf�cf�cf�cf��fj��fi�vZ\�sWX�pUV�bLK�V@?�K74�?.*�8)%9*&j9*&9*&                                                 :+' :+' 5'#?.*OB0-�A0,�H52�aHG�tYZ�y]_�jOO�sXY��dg�}ac��mp��|~��|~��|~��|~��|~��|~��|~��|~��mp�}ac��dg�sXY�jOO�y]_�tYZ�aHG�H52�A0,�B0-�?.*O5'#:+' :+'                                         <,( <,( 9*&iB0-�W?=�[B@�aHG�x\^�sWX�kOP�x\^��dg�|`c�jOO�����������������������������������������jOO�|`c��dg�x\^�kOP�sWX�x\^�aHG�[B@�W?=�B0-�9*&i<,( <,(                                     9*& 7)$9*&iF30�R<9�`ED�cHG�dIH�lPQ�kOP�z_`�������������������������������������������������������������������������z_`�kOP�lPQ�dIH�cHG�`ED�R<9�F30�9*&i7)$9*&                         :+' :+' 5'#>-*OB0-�R;9�bGF�aFE�cHG�jON�v^]��lm����������������������������������������������������������������������������������lm�v^]�jON�cHG�aFE�bGF�R;9�B0-�>-*O5'#:+' :+'                 <,( <,( 9*&iB0-�W?=�`ED�bGF�aFE�kOP��rt�ɺ������������������������������������������������������������������������������������������ɺ���rt�kOP�aFE�bGF�`ED�W?=�B0-�9*&i<,( <,(             <,( :+'<,(iG41�R;9�_DC�gKK�x^^���������Ŵ��������������������������������������������������������������������������������������������������Ŵ����������x^_�gJK�_DC�R;9�G41�<,(i:+'<,(         <,( :+&+;,(�N96�cGG�fJJ�{`a�����������������������������������������������������ð������İ��������������ð��Ϲ����������������������������������������������{`a�fJJ�cGG�N96�;,(�:+&+<,(         <,( :+&+;,(�M85�fKJ�w[]�����������������������������������������������������XIF�VFB�WEB�WGC�YJG�ZLH�XIF�VFB�����������������������������������������������������w[]�fKJ�M85�;,(�:+&+<,(     <,( 9*&9A0,�M85�\CB�{`a�����������������������������������������Ż����������rda�./1!�1!�0�/�./ lZW��wt��wt���������������������������������������������{`b�\CB�M85�A0,�9*&9<,( <,( 9*&{B0,�ZA@�y^_���������������������������������Ϲ��ı��������~�9)%�9)%�;+'j;+' ;+'                 ;+' ;+' ;+'j:*&�:*&քqn�­��­��к����������������������������������y__�ZA@�B0,�9*&{<,( <,( 9*&{A/,�ZA?�����������������������������������������WFB�YIF�UFB�2"*2")4$ 4$  4$                  5%! 5%! 5%!3$)4$ *RA=�VEA�VEA�����������������������������������������ZA?�A/,�9*&{<,( <,(D1-�^IF���������������������������������Ծ������hVS�/ �./@0 0                                         1! 1! 1!@/ 0 �hVS�����Ծ��������������������������ȵ���yx�\FD�E1.�<,(<,(�J41�zba�����������������������������Ӿ������UD@�/ i;+' ;+'                 

S 

S 

S

S+

S+

S

S 

S                 ;+' ;+' / iUD@ݭ���Ӿ��������������������������ɲ��w]\�J52�<,(�<,(�J41�zba���������������������������������UD@�D40O5%! 5%!                 U U UjU�U�UjU U                 5%! 5%! D40OUD@ܙ���������������������������ɳ��w]\�J52�<,(�<,(�P:8��ii���������������������к������iWT�/ i(1!                     

Q 

M

Pik�z�z�k�

Pi

M

Q                     1! (/ iiWTĚ���к������������������˴���fg�Q:9�<,(�;+'�dPO�����ѻ������������������­��VEB�0 ;+' ;+'                 

S 

S 		IZOa���������a�ZO		I

S 

S                 ;+' ;+' 0 �VEB�­������������������һ������dPO�;+'�;+'��|z�������������������������­��VEA�/ ;+' ;+'                 U U 

Pia�������������a�

PiU U                 ;+' ;+' / �VEA�­���������������������������|z�;+'�;+&������������������������������rn�RA=�0 ;<,( <,(             V 

SUik���������������k�Ui

SV             <,( <,( 0 ;RA=��rn뵠��������������������������;+&�:*&��������������������������vs�:*&�4$ +;+'                     V 

S+U�y�����		��  ��  ��		������y�U�

S+V                     ;+' 4$ +:*&Ԍzw�������������������������;+'�:+'��zw����������������������vs�:*&�4$ +;+'                     V 

S+U�w�������  ��  ��������w�U�

S+V                     ;+' 3#+9)%Ԓ������������������������zw�;+'�N86��}{����������������������vs�9*&�3$ +;+'                     V 

S+U�t�����  ��  ��  ��  ������t�U�

S+V                     <,( 4#;+'ivheĒ����zw��vs��wt��vs�n\Y�;+'aFE��������������������������zw�A/,�<+'O8)%<,( <,(             V R+U�~�����  ��  ��  ��  ������~�U�R+V                         ;+' ;+' ;+'j;+'�;+'�;+'�;+'�;+'�;+'g;+' aFE�����������������������������V><�A/,�9*&i<,( <,(             V O+U�������  ��  ��  ��  ��������U�O+V                         4$  4$  4$4$ +5%!+5%!+5%!+5%!+5%!5%! aFE�����������������������������[BA�A/+�8)%;+' ;+'             S L+R���  ��  ��  ��  ��  ��  ��  ��  ����U�N+V                                                                 aFE�����������������������������[A@�G30�?.+�:+&"8)$:+'         b [+a���  ��  ��  ��  ��  ��  ��  ��  ����U�N+V                                                                 aFE�����������������������������`ED�\BA�L85�;,(�:+&#<,(         � �+����  ��  ��  ��  ��  ��  ��  ��  ����U�N+V                                                                 aFE�������������������������Ų������nTS�V=<�L85�?.*�6(#;9*& 9*& � �+����  ��  ��  ��  ��  ��  ��  ��  ����U�N+V                                                                 aFEԠ�������������������������������~fe�aDD�]CB�H41�?.*�9)%*:*&)M5 �#��������  ��  ��  ��  ��������U�N#V                                                                 aFE)oVU��wv��������������������������wy�kOP�aFE�\CB�M85�;+'�;,'�<,&i	��������  ��  ��  ��  ��������R"8V                                                                 ]BA S65{w^]�������������������������ĳ���{|�lPP�dHG�aHG�\FE�P;9�E2/�8( |9)v$n�����  ��  ��  ��  �������� �                                                                     bGF X<;ex`_�Ʒ��������������������������Ĵ���su�nSS�qUV�z^`�lPQ�W@?�H62�H62�0'f�����  ��  ��  ��  �������� �                                                                     bGF S65lRQOx`_ܴ���������������������������Ϳ���su�nRS�kPP�y^`�z_a�v\]�v\]�G:{�����  ��  ��  ��  �������� �                                                                         X<; Q43W;:i�rqĴ��������������������������������qr�mQR�mQR�y]_��ik��ik�K=n�����  ��  ��  ��  ������q{ {                                                                             aFE aFE W:9ix_^�ŷ�������������������������������wy�~ee�}cc��fi��fh�G8Y�	r���  ��  ��  ��  ����		r�JV V                                                                             \@? \@? I+*iONOx`_ܴ����������������������������������������eh��eh�G9Y�r���  ��  ��  ��  ����		r�JU U                                                                                     X<; Q43W;:i�rqĴ�������������������������������������������ZNo�o�  ��  ��  ��  ��  ����		r�JV V                                                                                         aFE aFE W:9ix`_�Ʒ���������������������������������������z��&#~�
	�� ��  ��  ������

s�IiV V                                                                                         \@? \@? I+*iONOx`_ܲ�����������������������������������ҽ������/,����  ��  ��

�����OV V                                                                                                 X<; Q43W:9i�vuħ�����������������������������������¯��;7����  ��  �������+�                                                                                                             aFE aFE aFEj`ED�`ED֢�������˶��Կ������������������73����  ��  �������+�                                                                                                             \@? \@? \@?Z>=)[?>*v]\�x`_�v\[���������������������0,r�  ��  ��  ����a�[+b                                                                                                                         X<; X<; X<;>W;:{X=<{�pn������zw��yu�yhj�5+D�p�������

PfI

Q                                                                                                                                     ;+' ;+' ;+'�;+'�;+'�;+'�;+'�<,'�$>�U�U�UU U                                                                                 �����  ��  ?�  ��  �  ��  �  �    �  �      �      �      �      �      �      �      �      �      � �   � �     �     �?�    �?�    ��    ��    ��    ��    ?��    ?��    ?��    ��   ��   ���   ���   ���   ���     ��     ��  �  ��  �  ��  �  ��  �  ��  �  ��  �  ��  �  ��  �  ��  �  ��  �  ��  �� ��  �� ��  �� ��  �� ?��  (       @                                                                                 <,(�<,(�<,(�<,(�<,(�<,(�                                                                                            <,(�<,(�<,(�bGF�bGF�bGF�bGF�bGF�bGF�<,(�<,(�<,(�                                                                        <,(�<,(��fi�bGF��fi��fi��fi��fi��fi��fi��fi��fi�bGF��fi�<,(�<,(�                                                        <,(�<,(�bGF��fi�bGF��fi��fi��fi��fi��fi��fi��fi��fi��fi��fi�bGF��fi�bGF�<,(�<,(�                                            <,(�bGF�bGF��fi�bGF��fi��fi�bGF�������������������������bGF��fi��fi�bGF��fi�bGF�bGF�<,(�                                    <,(�bGF�bGF�bGF�bGF��fi��������������������������������������������������fi�bGF�bGF�bGF�bGF�<,(�                            <,(�bGF�bGF�bGF��fi������������������������������������������������������������������fi�bGF�bGF�bGF�<,(�                    <,(�bGF�bGF��fi����������������������������������������������������������������������������������fi�bGF�bGF�<,(�                <,(�bGF��fi���������������������������������<,(�<,(�<,(�<,(�<,(�<,(����������������������������������fi�bGF�<,(�            <,(�bGF��fi�����������������������������<,(�<,(�                        <,(�<,(������������������������������fi�bGF�<,(�        <,(�bGF�������������������������<,(�<,(�                                        <,(�<,(�������������������������bGF�<,(�    <,(�bGF�������������������������<,(�                                                        <,(�������������������������bGF�<,(�<,(�bGF���������������������<,(�                            V�V�                            <,(���������������������bGF�<,(�<,(��fi�����������������<,(�                            V�����V�                            <,(������������������fi�<,(�<,(���������������������<,(�                        V���������V�                        <,(���������������������<,(�<,(�����������������<,(�                        V�����  ��  ������V�                        <,(�����������������<,(�<,(�����������������<,(�                        V���  ��  ��  ��  ����V�                        <,(�����������������<,(�bGF�����������������<,(�                        V���  ��  ��  ��  ����V�                            <,(�<,(�<,(�<,(�    bGF�����������������bGF�<,(�                    V�  ��  ��  ��  ��  ��  ��V�                                                bGF�����������������bGF�<,(�                    V�  ��  ��  ��  ��  ��  ��V�                                                bGF�����������������bGF�bGF�<,(�                ��  ��  ��  ��  ��  ��  ��V�                                                bGF���������������������bGF�bGF�<,(�            ��  ��  ��  ��  ��  ��  ��V�                                                    bGF������������������fi�bGF�bGF�<,(�<,(�        ��  ��  ��  ��  ����                                                        bGF����������������������fi�bGF��fi�bGF�<,(�<,(���  ��  ��  ��  ����                                                            bGF����������������������fi�bGF��fi��fi��fi���  ��  ��  ��  ����                                                                bGF����������������������fi�bGF��fi��fi�V�  ��  ��  ��  ��V�                                                                    bGF��������������������������fi��fi�V�  ��  ��  ��  ��V�                                                                        bGF�����������������������������V�  ��  ��  ��  ��V�                                                                            bGF�������������������������������  ��  ����                                                                                    bGF�bGF�����������������������  ��  ����                                                                                            bGF�bGF�������������V�  ��  ��V�                                                                                                    <,(�<,(�<,(�<,(�V�V�                                                            �������  ��  ?�  �  �  �  �  ���� �  � �?������������� �� p���� �� �� �� �� �� ?�� ?���?����(                                            3%  )=-)(G52�P;9�T><�T><�P;9�G52�=-)()3%              @/, <,(F30ZCB�jPQ�~df��qt��qs�~df�jPQ�ZCB�F30<,(@/,     @/+ :*&M75�_ED��jj�����˼����������˽�������jk�_ED�M75�:*&@/+ 0$J53�qYX�����������������ν����������������������qXX�J63�0$<+'WkTS�ȷ��������������|y�^MI}aRN}�nk�������������ï��kTS�<+'WUB?Ǽ�������Ϻ���wt�QA>L    E  D O>:L�wt�Ϻ����������T?<�o[Y����������wt�0 .%L Su�u�S.%L 0 �wt�����վ��mXW�������������P?;MRER Av�����v�ARDR O>:N�����������������������'%%= 

B��������BE  }nk�����|kh�������������@-*>.e D��  ��  ����9V 
 
������������_HF�C0*Wb#		��  ��  ����5V                 �rq�������������`GF�S>9�#��������� V                 `ED����������������|b`�B5z�  ������                     sZY Y<;������������˸��eW������		zu�                         sZY ]BA����ȹ��������������'�                             J,+ ?! t[ZV��}Ɍ{{� ����Gd                     �  �  �                           ?   ?  �?  �?  �?               [remap]

path="res://.godot/exported/133200997/export-35ff2bbe3bf1c2421cbc160bbcbbc8db-SpringControl.scn"
      [remap]

path="res://.godot/exported/133200997/export-108ede1a8a7450ffd81a9134cec80e29-BasicMotionPhysics.scn"
 [remap]

path="res://.godot/exported/133200997/export-f22fa40d7be8abc802cdcfb538c90ae3-SpringControlList.scn"
  [remap]

path="res://.godot/exported/133200997/export-ef1d8f9c8499bcdb48634226fefdd4f3-ModuleControlBase.scn"
  list=Array[Dictionary]([{
"base": &"CPMOSCModule",
"class": &"BasicPhysics",
"icon": "",
"language": &"GDScript",
"path": "res://modules/BasicMotionPhysics/BasicMotionPhysics.gd"
}, {
"base": &"Node",
"class": &"CPMOSCManager",
"icon": "",
"language": &"GDScript",
"path": "res://core/CPMOSCManager.gd"
}, {
"base": &"Node",
"class": &"CPMOSCModule",
"icon": "",
"language": &"GDScript",
"path": "res://core/CPMOSCModule.gd"
}, {
"base": &"PanelContainer",
"class": &"ModuleControlBase",
"icon": "",
"language": &"GDScript",
"path": "res://core/ModuleControlBase.gd"
}, {
"base": &"Node",
"class": &"OSCClient",
"icon": "res://addons/godOSC/images/OSCClient.svg",
"language": &"GDScript",
"path": "res://addons/godOSC/scripts/OSCClient.gd"
}, {
"base": &"Node",
"class": &"OSCMessage",
"icon": "res://addons/godOSC/images/OSCMessage.svg",
"language": &"GDScript",
"path": "res://addons/godOSC/scripts/OSCMessage.gd"
}, {
"base": &"Node",
"class": &"OSCReceiver",
"icon": "res://addons/godOSC/images/OSCReceiver.svg",
"language": &"GDScript",
"path": "res://addons/godOSC/scripts/OSCReceiver.gd"
}, {
"base": &"Node",
"class": &"OSCServer",
"icon": "res://addons/godOSC/images/OSCServer.svg",
"language": &"GDScript",
"path": "res://addons/godOSC/scripts/OSCServer.gd"
}, {
"base": &"ModuleControlBase",
"class": &"SpringControl",
"icon": "",
"language": &"GDScript",
"path": "res://modules/BasicMotionPhysics/SpringControl.gd"
}])
         �PNG

   IHDR           szz�   sRGB ���  IDATX�ŗ?h�@�?	o��B#(L��K�	t�ᐵ��RJ�]C���`h�]�f�!��@<2X�up�z�?��~`���}�{w�ݳ��t{\|�2� ���Ug�����?�ۻ{~v��o;� � �v^>�^�2c �}��q�Ⱦ�j��4͞'�k��<�M�h�᾽��^��?v��+��|� �O����l�{.�d�/��"�%����`��I���|��V��>��V����h����
 �U ������ ~�� ��8]��@�s@f~}s����1���D�|����U��}#��S�����|�\��J[��B2���%ёo�ˋS�E����t{��o������6����QȘ��H�9yj�����.�$M-:�!c��t�46&�n�i�l`U��H�(37�<m`Ut�m(��QfnZ=��4�hb.ʢ�ϟ� ]Hra�����U��u��"FY�� 67<|��A�{.޾{_RdLs�%��!n��*
��x� @�$��au�����!�@d �Dc�\�A��T5֙kdjǨ'�f	L��`�G�5� �`��u}�)sJ�@޼�W��1JiP��-VD���ī�j�j���s���/U�YS�$H    IEND�B`�              ��{\�W(   res://addons/godOSC/images/OSCClient.svg��I��I)   res://addons/godOSC/images/OSCMessage.svg�*&Ȟz�W*   res://addons/godOSC/images/OSCReceiver.svg�^z�h.(   res://addons/godOSC/images/OSCServer.svg_��Y7�s   res://core/CPMOSCManager.tscnIIgHz1�!   res://core/LoadedModuleEntry.tscnu)���-u,!   res://core/ModuleControlBase.tscn�e�~a�#&   res://core/ModuleControlContainer.tscn�k�+�5{   res://core/ModuleExporter.tscn�M��>##[   res://core/PCKTester.tscn��K��
,8   res://modules/BasicMotionPhysics/BasicMotionPhysics.tscn�r��=Hx3   res://modules/BasicMotionPhysics/SpringControl.tscn,IA@-��E7   res://modules/BasicMotionPhysics/SpringControlList.tscnh>[�ݔO+   res://modules/EquippedGear/EquppedGear.tscn��mq�`Cp-   res://modules/TheBlinker/BlinkerControls.tscn�
���pg7(   res://modules/TheBlinker/TheBlinker.tscn�q�#-z4   res://samples/HeldItemDetector/HeldItemDetector.tscn��jՀ�o6   res://samples/HeldItemDetector/IsHoldingIndicator.tscn��/�q��Z   res://icon.png               ECFG      application/config/name      
   CompassOSC     application/config/description<      4   Modular OSC software for Customizable Player Models.   application/config/version         0.1.2.0    application/run/main_scene(         res://core/CPMOSCManager.tscn      application/config/features$   "         4.2    Forward Plus    "   application/boot_splash/show_image              application/boot_splash/fullsize          "   application/boot_splash/use_filter             application/config/icon         res://icon.png  &   application/config/windows_native_icon         res://icon.ico     autoload/Logging         *res://Logging.gd   "   display/window/size/viewport_width         #   display/window/size/viewport_height      X     editor_plugins/enabled,   "         res://addons/godOSC/plugin.cfg              