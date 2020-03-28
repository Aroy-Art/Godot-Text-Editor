extends Control

var app_name = "Text Editor"
var current_file = "Untitled"

func _ready():
	OS.set_window_title(app_name + " - " + current_file)
	$MenuButtonFile.get_popup().add_item("New")
	$MenuButtonFile.get_popup().add_item("Open")
	$MenuButtonFile.get_popup().add_item("Save")
	$MenuButtonFile.get_popup().add_item("Save As File")
	$MenuButtonFile.get_popup().add_item("Quit")
	
	$MenuButtonFile.get_popup().connect("id_pressed", self, "_on_item_file_pressed")
	
	$MenuButtonHelp.get_popup().add_item("Source Code")
	$MenuButtonHelp.get_popup().add_item("About")
	
	$MenuButtonHelp.get_popup().connect("id_pressed", self, "_on_item_help_pressed")

func _on_item_file_pressed(id):
	var item_name = $MenuButtonFile.get_popup().get_item_text(id)
	if item_name == 'New':
		new_file()
	elif item_name == 'Open':
		$OpenFileDialog.popup()
	elif item_name == 'Save':
		save_file()
	elif item_name == 'Save As File':
		$SaveFileDialog.popup()
	elif item_name == 'Quit':
		get_tree().quit()
	print(item_name + " pressed")

func _on_item_help_pressed(id):
	var item_name = $MenuButtonHelp.get_popup().get_item_text(id)
	if item_name == 'About':
		$AboutDialog.popup()
	elif item_name == 'Source Code':
		OS.shell_open("https://github.com/EDUDD22/Godot-Text-Editor")
	print(item_name + " pressed")

#Updateing the window title
func update_window_title():
	OS.set_window_title(app_name + " - " + current_file)

func new_file():
	current_file = "Untitled"
	update_window_title()
	$TextEdit.text = ''

func save_file():
	var path = current_file
	if path == 'Untitled':
		$SaveFileDialog.popup()
	else:
		print(path)
		var f = File.new()
		f.open(path, 2)
		f.store_string($TextEdit.text)
		current_file = path
		f.close()
		update_window_title()

func _on_OpenFileDialog_file_selected(path):
	print(path)
	var f =File.new()
	f.open(path, 1)
	$TextEdit.text = f.get_as_text()
	current_file = path
	f.close()
	update_window_title()

func _on_SaveFileDialog_file_selected(path):
	print(path)
	var f = File.new()
	f.open(path, 2)
	f.store_string($TextEdit.text)
	current_file = path
	f.close()
	update_window_title()

func _on_Button_About_Ok_pressed():
	$AboutDialog.hide()
