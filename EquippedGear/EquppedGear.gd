extends CPMOSCModule

var should_send = true
var since_last = 0.0

var head_prev = null
var body_prev = null
var legs_prev = null
var feet_prev = null

var head = null
var body = null
var legs = null
var feet = null

func _process(delta):
	since_last += delta
func on_message_received(address, arguments):
	match address:
		"/cpm/armor/helmet/id":
			var current = get_item_name(arguments[0])
			should_send = current != head or since_last >= 1.0
			head_prev = head
			head = current
			if should_send:
				if head_prev:
					send_message("head/" + head_prev, false)
				send_message("head/" + head, true)
		"/cpm/armor/chestplate/id":
			var current = get_item_name(arguments[0])
			should_send = current != body or since_last >= 1.0
			body_prev = body
			body = current
			if should_send:
				if body_prev:
					send_message("body/" + body_prev, false)
				send_message("body/" + body, true)
		"/cpm/armor/leggings/id":
			var current = get_item_name(arguments[0])
			should_send = current != legs or since_last >= 1.0
			legs_prev = legs
			legs = current
			if should_send:
				if legs_prev:
					send_message("legs/" + legs_prev, false)
				send_message("legs/" + legs, true)
		"/cpm/armor/boots/id":
			var current = get_item_name(arguments[0])
			should_send = current != feet or since_last >= 1.0
			feet_prev = feet
			feet = current
			if should_send:
				if feet_prev:
					send_message("feet/" + feet_prev, false)
				send_message("feet/" + feet, true)
		"/cpm/gameTime":
			since_last = 0.0

func get_item_name(id : String) -> String:
	var source = id.split(":")[0]
	var item_name = id.trim_prefix(source + ":")
	
	return item_name
