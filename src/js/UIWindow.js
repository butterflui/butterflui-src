function getUIWindow() {

	var UIWindow = $("<div/>", {"class":"UIWindow Window"});

	UIWindow.load('src/html/UIWindow.html', function(){
		$('.UIWindow').tabs({"active":0});
		$('.UIWindow').on( "tabsactivate", function( event, ui ) {
			if($(ui.newTab).text() == "Settings")
				setMode('setup');
			else if(ModeRead != "work") setMode('work');
		} );
		$('#ArduinoIDE').tabs();
		$('.UIWindow').draggable();
		proofSettingProperties();
		
		
				
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
			//event.preventDefault();
			event.stopPropagation();
		});

		$('#inspector > ul > li > a').click(function(event) {
			event.stopPropagation();
			event.preventDefault();
			var next = $(this).next();
			$(next).toggleClass('InspectorContentActive');
		});

		$('.InspectorCheckbox').change(function(event) {
			checkboxChanged(event, this);
		});

		$('#nameInput').keyup(function(event) {
			inputFieldChange(event,this);
			say('nameChanged');
		});

		$('#thresValInput').keyup(function(event) {
			inputFieldChange(event,this);
		});

		

		disableDblClick(UIWindow);
	});

	$('#stage').append(UIWindow);

	
	

	
}