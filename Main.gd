extends Control

func _ready():
	$MenuButtonFile.get_popup().add_item("Open File")
	$MenuButtonFile.get_popup().add_item("Save As File")
	$MenuButtonFile.get_popup().add_item("Quit")
	
	$MenuButtonFile.get_popup().connect("id_pressed", self, "_on_item_file_pressed")
	
	$MenuButtonHelp.get_popup().add_item("About")
	
	$MenuButtonHelp.get_popup().connect("id_pressed", self, "_on_item_help_pressed")

func _on_item_file_pressed(id):
	var item_name = $MenuButtonFile.get_popup().get_item_text(id)
	if item_name == 'Open File':
		$OpenFileDialog.popup()
	
	elif item_name == 'Save As File':
		$SaveFileDialog.popup()
	
	elif item_name == 'Quit':
		get_tree().quit()
	
	print(item_name + " pressed")

func _on_item_help_pressed(id):
	var item_name = $MenuButtonHelp.get_popup().get_item_text(id)
	if item_name == 'About':
		$AboutDialog.popup()
	
	print(item_name + " pressed")


func _on_OpenFileDialog_file_selected(path):
	print(path)
	var f =File.new()
	f.open(path, 1)
	$TextEdit.text = f.get_as_text()
	f.close()

func _on_SaveFileDialog_file_selected(path):
	print(path)
	var f = File.new()
	f.open(path, 2)
	f.store_string($TextEdit.text)
	f.close()


func _on_Button_About_Ok_pressed():
	$AboutDialog.hide()
