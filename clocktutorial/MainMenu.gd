extends Node2D

class mealTracker:
	var hour
	var minute
	var day_or_night #am or pm
	var instructions
	

var currentTime = Time.get_time_dict_from_system()
@onready var line_edit_hour: LineEdit = $LineEditHour
@onready var line_edit_minute: LineEdit = $LineEditminute
@onready var line_edit_AMPM: LineEdit = $LineEditAMPM
@onready var label: Label = $Label
@onready var currMeal = mealTracker.new()
#var appointmentName

func _ready():
	line_edit_hour.text_submitted.connect(_on_LineEditHour_text_entered)
	line_edit_minute.text_submitted.connect(_on_LineEditMinute_text_entered)
	line_edit_AMPM.text_submitted.connect(_on_LineEditAMPM_text_entered)
	$SecondArm.rotation  = currentTime.second * (TAU / 60.0)
	$MinuteArm.rotation  = currentTime.minute * (TAU / 60.0)
	$HourArm.rotation  = currentTime.hour * (TAU / 12.0)
	


func _process(_delta):
	pass
	#var currentTime = Time.get_time_dict_from_system()
	#$SecondArm.rotation  = currentTime.second * (TAU / 60.0)
	#$MinuteArm.rotation  = currentTime.minute * (TAU / 60.0)
	#$HourArm.rotation  = currentTime.hour * (TAU / 12.0)


func _on_button_pressed() -> void:
	#pass # Replace with function body.
	#get_tree().change_scene_to_file("res://SecondScene.tscn")
	label.text = (currMeal.hour + currMeal.minute)
	

func _on_LineEditHour_text_entered(new_text: String) -> void:
	#label.text = new_text
	currMeal.hour = new_text
	print(currMeal.hour)
	
func _on_LineEditMinute_text_entered(new_text: String) -> void:
	currMeal.minute = new_text
	
func _on_LineEditAMPM_text_entered(new_text: String) -> void:
	currMeal.day_or_night = new_text
	
