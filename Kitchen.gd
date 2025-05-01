extends Control
@onready var meals_container = $MealsContainer
@onready var add_btn = $MealsContainer/AddMealButton
@onready var modal = $MealDialog as AcceptDialog

@onready var name_edit = $MealDialog/Content/NameRow/name_edit as LineEdit
@onready var hour_spin = $MealDialog/Content/TimeRow/hour_spin as SpinBox
@onready var min_spin = $MealDialog/Content/TimeRow/min_spin as SpinBox
@onready var notes_edit = $MealDialog/Content/notes_edit as TextEdit

var editing_item: MealItem = null
var meal_item_scene: PackedScene = preload("res://MealItem.tscn")

func _ready():
	add_btn.pressed.connect(_on_add_meal_pressed)
	modal.confirmed.connect(_on_meal_dialog_confirmed)

func _on_add_meal_pressed():
	_open_meal_dialog()

func _open_meal_dialog(initial_data := {}):
	name_edit.text  = initial_data.get("meal_name", "")
	hour_spin.value = initial_data.get("hour", 12)
	min_spin.value  = initial_data.get("min", 0)
	notes_edit.text = initial_data.get("notes", "")
	modal.popup_centered(Vector2(400, 300))

func _on_meal_dialog_confirmed():
	var mName  = name_edit.text
	var mHour  = hour_spin.value
	var mMinute  = min_spin.value
	var mNotes = notes_edit.text

	if editing_item:
		editing_item.set_data(mName, mHour, mMinute, mNotes)
		editing_item = null
	else:
		var item = meal_item_scene.instantiate() as MealItem
		meals_container.add_child(item)
		item.set_data(mName, mHour, mMinute, mNotes)
		item.edit_requested.connect(_on_item_edit_requested)
		item.feed_requested.connect(_on_item_feed_requested)
	modal.hide()

func _on_item_edit_requested(item: MealItem):
	editing_item = item
	_open_meal_dialog({
		"meal_name": item.meal_name,
		"hour":      item.hour,
		"min":       item.min,
		"notes":     item.notes
	})

func _on_item_feed_requested(item: MealItem):
	print("Feeding cats at meal: %s at %02d:%02d" % [item.meal_name, item.hour, item.min])
