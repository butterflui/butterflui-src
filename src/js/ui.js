//Open New Graph Menue Listener
newGraphMenue.listen();

setMode("work");
ModeSelectListener();

try{
var socket = io.connect('http://localhost');
  socket.on('analogRead', function (data) {
   //console.log(data);
    arduinoPorts = data;
  });
}
catch(err){
	//say(err);
}


proofFirstUse();



$('#toggleConsole').click(function(){
	
	if($('.Console').length !== 0){
		$('.Console').remove();
		$('#toggleConsole img').attr('src', 'img/icon_console.png');

	}else{
	getConsole();
	$('#toggleConsole img').attr('src', 'img/icon_console_activ.png');
}
});


$('#toggleUIWindow').click(function(){
	
	if($('.UIWindow').length !== 0){
		$('.UIWindow').remove();
		$('#toggleUIWindow img').attr('src', 'img/icon_arduino.png');
		$('#toggleVars img').attr('src', 'img/icon_variable.png');
		$('#toggleSettings img').attr('src', 'img/icon_setting.png');

	}else{
	getUIWindow();
	$('#toggleUIWindow img').attr('src', 'img/icon_arduino_activ.png');
	$('#toggleVars img').attr('src', 'img/icon_variable_activ.png');
	$('#toggleSettings img').attr('src', 'img/icon_setting_activ.png');
}
});

//setActiveWindow('.UIWindow');


disableDblClick("#eingabe");




function ModeSelectListener() {
	
	$('#ModeSelect a').click(function(){
		setMode(this);
	});

}







