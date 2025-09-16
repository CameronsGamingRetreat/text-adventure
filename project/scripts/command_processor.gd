extends Node

func process_command(input: String) -> String:
	var words = input.split(" ", false, 0) # Take input and split on empty space. 
	if words.size() == 0: # If user doesnt enter any word, raise error.
		return "Error: no words were parsed"
	var first_word = words[0].to_lower() # Get first word in 0 index, and make lowercase.
	var second_word = "" 
	if words.size() > 1: # If user has entered more than one word, get second word.
		second_word = words[1].to_lower()
	match first_word: 
		"go": # If go, return the result of go function with second word.
			return go(second_word)
		"help":
			return help()	
		_:
			return "Nothing happens."	
			
func go(second_word: String) -> String:
	if second_word == "": # If empty, ask user for more details.
		return "Go where?"
	return "You go %s." % second_word
			
func help() -> String:
	return "You can use these commands: go [location], help"
