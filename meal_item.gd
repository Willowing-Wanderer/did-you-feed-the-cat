extends HBoxContainer
class_name MealItem

signal edit_requested(item)
signal feed_requested(item)

@export var meal_name : String = ""
@export var hour      : int    = 12
@export var min       : int    = 0
@export var notes     : String = ""

@onready var name_lbl = $NameLabel
@onready var time_lbl = $TimeLabel
@onready var edit_btn = $EditButton
@onready var feed_btn = $FeedButton

func _ready():
	_update_labels()
	edit_btn.pressed.connect(_on_edit_btn_pressed)
	feed_btn.pressed.connect(_on_feed_btn_pressed)

func _on_edit_btn_pressed():
	emit_signal("edit_requested", self)

func _on_feed_btn_pressed():
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
