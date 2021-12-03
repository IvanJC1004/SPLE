extends Control

export var typeQ = 1

var answers = []

func _on_AcceptButton_pressed():
	updateVariables()
	Server.UpdateQuiz(answers)
	print(answers)
	queue_free()
	
func updateVariables():
	answers.append($NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/AQQ1A1and2/CheckBoxAQQ1A1.pressed)
	answers.append($NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/AQQ1A1and2/CheckBoxAQQ1A2.pressed)
	answers.append($NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/AQQ1A3and4/CheckBoxAQQ1A3.pressed)
	answers.append($NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/AQQ1A3and4/CheckBoxAQQ1A4.pressed)
	answers.append($NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/AQQ2A1and2/CheckBoxAQQ2A1.pressed)
	answers.append($NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/AQQ2A1and2/CheckBoxAQQ2A2.pressed)
	answers.append($NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/AQQ2A3and4/CheckBoxAQQ2A3.pressed)
	answers.append($NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/AQQ2A3and4/CheckBoxAQQ2A4.pressed)
	answers.append($NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/AQQ3A1and2/CheckBoxAQQ3A1.pressed)
	answers.append($NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/AQQ3A1and2/CheckBoxAQQ3A2.pressed)
	answers.append($NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/AQQ3A3and4/CheckBoxAQQ3A3.pressed)
	answers.append($NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/AQQ3A3and4/CheckBoxAQQ3A4.pressed)
	answers.append(typeQ)

func typeQuiz():
	$NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/Title.text = tr("QUIZ"+str(typeQ))
	$NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/Question1.text = tr("QUESTIONQ"+str(typeQ)+"Q1")
	$NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/AQQ1A1and2/AQQ1A1.text = tr("ANSWERQ"+str(typeQ)+"Q1A1")
	$NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/AQQ1A1and2/AQQ1A2.text = tr("ANSWERQ"+str(typeQ)+"Q1A2")
	$NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/AQQ1A3and4/AQQ1A3.text = tr("ANSWERQ"+str(typeQ)+"Q1A3")
	$NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/AQQ1A3and4/AQQ1A4.text = tr("ANSWERQ"+str(typeQ)+"Q1A4")
		
	$NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/Question2.text = tr("QUESTIONQ"+str(typeQ)+"Q2")
	$NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/AQQ2A1and2/AQQ2A1.text = tr("ANSWERQ"+str(typeQ)+"Q2A1")
	$NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/AQQ2A1and2/AQQ2A2.text = tr("ANSWERQ"+str(typeQ)+"Q2A2")
	$NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/AQQ2A3and4/AQQ2A3.text = tr("ANSWERQ"+str(typeQ)+"Q2A3")
	$NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/AQQ2A3and4/AQQ2A4.text = tr("ANSWERQ"+str(typeQ)+"Q2A4")
		
	$NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/Question3.text = tr("QUESTIONQ"+str(typeQ)+"Q3")
	$NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/AQQ3A1and2/AQQ3A1.text = tr("ANSWERQ"+str(typeQ)+"Q3A1")
	$NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/AQQ3A1and2/AQQ3A2.text = tr("ANSWERQ"+str(typeQ)+"Q3A2")
	$NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/AQQ3A3and4/AQQ3A3.text = tr("ANSWERQ"+str(typeQ)+"Q3A3")
	$NinePatchRect/NinePatchRect/NinePatchRect/VBoxContainer/AQQ3A3and4/AQQ3A4.text = tr("ANSWERQ"+str(typeQ)+"Q3A4")

