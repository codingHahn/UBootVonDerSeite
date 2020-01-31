extends LineEdit

func _on_playercount_lineedit_text_changed(new_text):
	if(int(new_text) > 4):
		set_text("4");
