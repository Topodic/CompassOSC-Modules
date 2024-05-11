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

var previous_tags = {
	"head": [],
	"body": [],
	"legs": [],
	"feet": [],
	"main_hand": [],
	"off_hand": []
}

var current_tags = {
	"head": [],
	"body": [],
	"legs": [],
	"feet": [],
	"main_hand": [],
	"off_hand": []
}

var dirty_tags = {
	"head": false,
	"body": false,
	"legs": false,
	"feet": false,
	"main_hand": false,
	"off_hand": false
}

func _process(delta):
	since_last += delta
func on_message_received(address, arguments):
	match address:
		"/cpm/armor/helmet/id":
			handle_part("head", arguments)
		"/cpm/armor/helmet/tags":
			if dirty_tags["head"]:
				handle_tags("head", arguments)
		"/cpm/armor/chestplate/id":
			handle_part("body", arguments)
		"/cpm/armor/chestplate/tags":
			if dirty_tags["body"]:
				handle_tags("body", arguments)
		"/cpm/armor/leggings/id":
			handle_part("legs", arguments)
		"/cpm/armor/leggings/tags":
			if dirty_tags["legs"]:
				handle_tags("legs", arguments)
		"/cpm/armor/boots/id":
			handle_part("feet", arguments)
		"/cpm/armor/boots/tags":
			if dirty_tags["feet"]:
				handle_tags("feet", arguments)
		"/cpm/held_item/id":
			handle_part("main_hand", arguments)
		"/cpm/held_item/tags":
			if dirty_tags["main_hand"]:
				handle_tags("main_hand", arguments)
		"/cpm/off_hand/id":
			handle_part("off_hand", arguments)
		"/cpm/off_hand/tags":
			if dirty_tags["off_hand"]:
				handle_tags("off_hand", arguments)
			
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
		dirty_tags[part_name] = true
		if previous[part_name]:
			send_message(part_name + "/" + previous[part_name].replace(":", "/"), false)
			send_message(part_name + "/" + get_item_name(previous[part_name]), false)
		send_message(part_name + "/" + current[part_name].replace(":", "/"), true)
		send_message(part_name + "/" + get_item_name(current[part_name]), true)

func handle_tags(part_name : String, arguments):
	dirty_tags[part_name] = false
	previous_tags[part_name] = current_tags[part_name]
	current_tags[part_name] = arguments
	for tag in previous_tags[part_name]:
		var t = tag.replace(":", "/").replace("$", "").replace("#", "")
		send_message(part_name + "/tag/" + t, false)
	for tag in current_tags[part_name]:
		var t = tag.replace(":", "/").replace("$", "").replace("#", "")
		send_message(part_name + "/tag/" + t, true)
