extends HBoxContainer
class_name MealItem

signal edit_requested(item)
signal feed_requested(item)

@export var clock_icon   : Texture2D
@export var warning_icon : Texture2D
@export var fed_icon     : Texture2D

const WARNING_WINDOW : = 60 * 60

@export var meal_name : String = ""
@export var hour      : int    = 12
@export var min       : int    = 0
@export var notes     : String = ""

@onready var name_lbl = $NameLabel
@onready var time_lbl = $TimeLabel
@onready var edit_btn = $EditButton
@onready var feed_btn = $FeedButton
@onready var status_icon = $StatusIcon

var fed := false

func _ready():
	_update_labels()
	edit_btn.pressed.connect(_on_edit_btn_pressed)
	feed_btn.pressed.connect(_on_feed_btn_pressed)
	_update_icon()
	
func _process(delta):
	if not fed:
		_update_icon()
	
func _update_icon() -> void:
	if fed:
		status_icon.texture = fed_icon
		return

	var secs_left = _seconds_until_meal()

	if secs_left > WARNING_WINDOW:
		status_icon.texture = clock_icon
	else:
		status_icon.texture = warning_icon

func _on_edit_btn_pressed():
	emit_signal("edit_requested", self)

func _on_feed_btn_pressed():
	fed = true
	_update_icon()
	emit_signal("feed_requested", self)

func _update_labels():
	name_lbl.text = meal_name
	time_lbl.text = "%02d:%02d" % [hour, min]

func set_data(new_name:String, new_hour:int, new_min:int, new_notes:String) -> void:
	meal_name = new_name
	hour      = new_hour
	min       = new_min
	notes     = new_notes
	_update_labels()

func _seconds_until_meal() -> int:
	var now = Time.get_time_dict_from_system()
	var now_secs  = now.hour * 3600 + now.minute * 60 + now.second
	var meal_secs = hour * 3600 + min * 60
	return meal_secs - now_secs
