function getUIWindow() {

	var UIWindow = $("<div/>", {"class":"UIWindow Window"});

	UIWindow.load('src/html/UIWindow.html', function(){
		$('.UIWindow').tabs();
		$('#ArduinoIDE').tabs();
		$('.UIWindow').draggable();
		$(UIWindow).click(function(event){
			event.preventDefault();
			event.stopPropagation();
		});
		disableDblClick(UIWindow);
	});

	$('#stage').append(UIWindow);

	
}