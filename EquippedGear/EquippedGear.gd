extends CPMOSCModule

var should_send = true
var since_last = 0.0

var previous = {
	"head": null,
	"body": null,
	"legs": null,
	"feet": null,
	"main_hand": null,
	"off_hand": null
}

var current = {
	"head": null,
	"body": null,
	"legs": null,
	"feet": null,
	"main_hand": null,
	"off_hand": null
}

func _process(delta):
	since_last += delta
func on_message_received(address, arguments):
	match address:
		"/cpm/armor/helmet/id":
			handle_part("head", arguments)
		"/cpm/armor/chestplate/id":
			handle_part("body", arguments)
		"/cpm/armor/leggings/id":
			handle_part("legs", arguments)
		"/cpm/armor/boots/id":
			handle_part("feet", arguments)
		"/cpm/held_item/id":
			handle_part("main_hand", arguments)
		"/cpm/off_hand/id":
			handle_part("off_hand", arguments)
			
		"/cpm/gameTime":
			since_last = 0.0

func get_item_name(id : String) -> String:
	var source = id.split(":")[0]
	var item_name = id.trim_prefix(source + ":")
	
	return item_name

func handle_part(part_name : String, arguments):
	var _cur = arguments[0]
	should_send = _cur != current[part_name] or since_last >= 1.0
	previous[part_name] = current[part_name]
	current[part_name] = _cur
	if should_send:
		if previous[part_name]:
			send_message(part_name + "/" + previous[part_name].replace(":", "/"), false)
			send_message(part_name + "/" + get_item_name(previous[part_name]), false)
		send_message(part_name + "/" + current[part_name].replace(":", "/"), true)
		send_message(part_name + "/" + get_item_name(current[part_name]), true)
