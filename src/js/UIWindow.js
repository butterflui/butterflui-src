function getUIWindow() {

	var UIWindow = $("<div/>", {"class":"UIWindow Window"});

	UIWindow.load('src/html/UIWindow.html', function(){
		$('.UIWindow').tabs();
		$('#ArduinoIDE').tabs();
		$('.UIWindow').draggable();
		
		var myCodeMirror = CodeMirror($('#sketch_01').get(0), {
			mode:  "text/x-c++src",
			lineNumbers: "true",
			theme: "default",
			value: "int analogInputsToReport = 0;\nfor (var i = Things.length - 1; i >= 0; i--) {Things[i]};\n\nif (true) {};"
		});
		$('.CodeMirror').resizable();
		$('.CodeMirror').mousedown(function () {
			
			$('.UIWindow').draggable('disable');
		});

		$('.CodeMirror').mouseup(function () {
			
			$('.UIWindow').draggable('enable');
		});

		$(UIWindow).click(function(event){
			event.preventDefault();
			event.stopPropagation();
		});
		disableDblClick(UIWindow);
	});

	$('#stage').append(UIWindow);
	

	
}