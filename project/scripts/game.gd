extends Control


const InputResponse = preload("res://scenes/input_response.tscn")


@export var max_lines_remembered := 30


@onready var history_rows: VBoxContainer = $Background/MarginContainer/Rows/GameInfo/Scroll/HistoryRows
@onready var scroll: ScrollContainer = $Background/MarginContainer/Rows/GameInfo/Scroll
@onready var scrollbar = scroll.get_v_scroll_bar()


func _ready() -> void:
	scrollbar.connect("changed",handle_scrollbar_changed)
	
	
func handle_scrollbar_changed():
	scroll.scroll_vertical = scrollbar.max_value # Bring scrollbar to bottom	


func _on_input_text_submitted(new_text: String) -> void:
	if new_text.is_empty(): # Handle empty lines.
		return	
	var input_response = InputResponse.instantiate()
	input_response.set_text(new_text, "This is where a response would go.")
	history_rows.add_child(input_response)
	
	# Cleans up old submitted text
	if history_rows.get_child_count() > max_lines_remembered:
		var rows_to_forget = history_rows.get_child_count() - max_lines_remembered
		for i in range(rows_to_forget):
			history_rows.get_child(i).queue_free()
