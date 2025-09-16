extends Control

const Response = preload("res://scenes/response.tscn")
const InputResponse = preload("res://scenes/input_response.tscn")
@export var max_lines_remembered := 30
@onready var command_processor: Node = $CommandProcessor
@onready var history_rows: VBoxContainer = $Background/MarginContainer/Rows/GameInfo/Scroll/HistoryRows
@onready var scroll: ScrollContainer = $Background/MarginContainer/Rows/GameInfo/Scroll
@onready var scrollbar = scroll.get_v_scroll_bar()


func _ready() -> void:
	scrollbar.connect("changed",handle_scrollbar_changed)
	var starting_message = Response.instantiate()
	starting_message.text = "You find yourself in a house with no memory of how you got there. You need to find your way out. You can type 'help' to see your available commands."
	add_response_to_game(starting_message)
	
	
func handle_scrollbar_changed():
	scroll.scroll_vertical = scrollbar.max_value # Bring scrollbar to bottom	


func _on_input_text_submitted(new_text: String) -> void:
	if new_text.is_empty(): # Handle empty lines.
		return	
	var input_response = InputResponse.instantiate()
	var response = command_processor.process_command(new_text)
	input_response.set_text(new_text, response)
	add_response_to_game(input_response)
	
func add_response_to_game(response: Control):
	history_rows.add_child(response)
	delete_history_beyond_limit()
			
func delete_history_beyond_limit():
	# Cleans up old submitted text
	if history_rows.get_child_count() > max_lines_remembered:
		var rows_to_forget = history_rows.get_child_count() - max_lines_remembered
		for i in range(rows_to_forget):
			history_rows.get_child(i).queue_free()				
