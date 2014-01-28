//Open New Graph Menue Listener
newGraphMenue.listen();

ModeSwitcher("work");
ModeSelectListener();

$('.testCanvas').draggable();
$('#eingabe').draggable();



getUIWindow();


disableDblClick("#eingabe");





function disableDblClick(elementName) {
	$(elementName).dblclick(function(event) {
		event.preventDefault();
		event.stopPropagation();
	});
}







function ModeSelectListener() {
	
	$('#ModeSelect a').click(function(){
		ModeSwitcher(this);
	});

}

function ModeSwitcher (mode) {


	if (typeof mode == "object") {
		var that = mode;
		$('#ModeSelect a').removeClass('activ');
		$(that).addClass('activ');
	}

	if (typeof mode == "string") {
	switch (mode){
		case "work":
		$('#ModeSelect a').removeClass('activ');
		$('#ModeSelect li:first-child a').addClass('activ');
		break;

		case "setup":
		$('#ModeSelect a').removeClass('activ');
		$('#ModeSelect li:last-child a').addClass('activ');
		break;
	}
	}
}

function ModeRead () {
	return $('#ModeSelect .activ').attr('title');
}