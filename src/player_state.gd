extends RefCounted
class_name State2

var enter: Callable = empty
var exit: Callable = empty
var process: Callable = empty
var input: Callable = empty

func empty(..._arg):
	pass
