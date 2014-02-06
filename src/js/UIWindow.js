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
			theme: "default",
			value: ""
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
			setActiveWindow('.UIWindow');
		});
		$('#playArduino').mouseover(function(){

			$('#playArduino').css('background-image','');

		});
		$('#playArduino').click(function(){
			$('#playArduino').css('background-image','url("../img/compile_loading.png")');

			var t = setTimeout(function(){setPlay();},2000);

			function setPlay(){
				var text = $('#monitorText').html();
				$('#playArduino').css('background-image','url("../img/compile_play.png")');
				$('#monitorText').html(text+'<br/>Sketch_01 is up and running');
			}

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
		setActiveWindow('.UIWindow');
	});

	$('#stage').append(UIWindow);
	
	
	

	
}


function getConsole() {

	var console = $("<div/>", {"class":"Console Window"});
	console.load('src/html/Console.html', function(){
	$('.Console').tabs({"active":0});
	$('.Console').draggable();
	$('#monitorContent').resizable();
	

	$(console).click(function(event){
			//event.preventDefault();
			event.stopPropagation();
			setActiveWindow('.Console');
		});

	disableDblClick(console);

	setActiveWindow('.Console');

	});


	$('#stage').append(console);
}