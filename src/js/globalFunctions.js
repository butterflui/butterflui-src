function generateUUID() {

	
		// http://www.ietf.org/rfc/rfc4122.txt
		var s = [];
		var hexDigits = "0123456789abcdef";
		for (var i = 0; i < 36; i++) {
			s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
		}
		s[14] = "4";  // bits 12-15 of the time_hi_and_version field to 0010
		s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1);  // bits 6-7 of the clock_seq_hi_and_reserved to 01
		s[8] = s[13] = s[18] = s[23] = "-";
		
		var uuid = s.join("");
		return uuid;

	}


function disableDblClick(elementName) {
	$(elementName).dblclick(function(event) {
		event.preventDefault();
		event.stopPropagation();
	});
}

function FirstUse(bool){
	
	var t = setTimeout(function(){
		$('.infoBlend').addClass('transparent');
	},5000);
		
}
///////////////////////////////////////////////////////////////////////////////
// Global Window Actions

function setActiveWindow(selector){

	if(activeWindow.Class) {
		inactiveWindow.Class = activeWindow.Class;
		
	}

	activeWindow.Class = selector;

	
	

	var activeEl = selector+">ul>li";
	$(activeEl).css('background-color','');

	

	if(inactiveWindow.Class) {
		
		if(inactiveWindow.Class !== activeWindow.Class) {
			var inactiveEl = inactiveWindow.Class+">ul>li";
			
			$(inactiveEl+'.ui-tabs-active').css('background-color','#9B9B9B');
			
		}
	}

}
///////////////////////////////////////////////////////////////////////////////
// Graph Object

function setActiveGraph(that){
	activeGraph.id = $(that).attr('id');
	activeGraph.pInstance = Processing.getInstanceById(activeGraph.id);
	var pos = $(that).position();
	activeGraph.X = pos.left;
	activeGraph.Y = pos.top;
	getGraphProperties(activeGraph.pInstance);
	changeActiveGraph();
	setSettingProperties();
	proofSettingProperties();
	

}

function resetActiveGraph(){
	activeGraph = new Object();
	changeActiveGraph();
	proofSettingProperties();
}


function changeActiveGraph() {
	if (activeGraph.id) {
		$('.GraphCanvas').addClass('passiv');
		var id = '#'+activeGraph.id;
		$(id).removeClass('passiv');
		
		
	}else{
		$('.GraphCanvas').removeClass('passiv');
	}
	
	
	
}


function bindArduinoInput(that, vari){
	
	var id = $(that).attr('id');
	var pInstance = Processing.getInstanceById(id);
	var value;

	var t = setInterval(function(){
		//say(arduinoPorts);
		value = arduinoPorts.values[vari];

		pInstance.setValue(value);


	},1);

}
///////////////////////////////////////////////////////////////////////////////
// Setup Window

function proofSettingProperties() {
	if (activeGraph.id) {
		if (ModeRead() == "setup") {
			$('#Settings>div').css('visibility', 'visible');
			$('#settingsHelp').css('display', 'none');
		
		}
	}else {
		$('#SettingsVariables').css('visibility', 'hidden');
		$('#inspector').css('visibility', 'hidden');
		$('#settingsHelp').css('display', 'block');
	
	}
}



function setSettingProperties() {

	$('.InspectorCheckbox[name=name]').prop("checked", true);
	$('.InspectorCheckbox[name=thres]').prop("checked", true);
	$('.InspectorCheckbox[name=range]').prop("checked", activeGraph.scale);
	$('.InspectorCheckbox[name=min]').prop("checked", activeGraph.min);
	$('.InspectorCheckbox[name=max]').prop("checked", activeGraph.max);
	$('.InspectorCheckbox[name=dial]').prop("checked", activeGraph.ticks);

	$('#nameInput').val(activeGraph.name);
	$('#thresValInput').val(activeGraph.thres);

	$('#footerX').text('X:'+activeGraph.X);
	$('#footerY').text('Y:'+activeGraph.Y);
	$('#footerGraph').text(activeGraph.name);

}



function checkboxChanged(event, that){
		if (activeGraph.id) {
		
		var elName = $(that).attr('name');
		var checked = that.checked;

		

		switch(elName) {
			case 'name':
				
			break;

			case 'thres':
				
			break;

			case 'range':
				activeGraph.scale = checked;
				
			break;

			case 'min':
				activeGraph.min = checked;
				
			break;

			case 'max':
				activeGraph.max = checked;
				
			break;

			case 'dial':
				activeGraph.ticks = checked;
				
			break;
		}

		
		setGraphProperties(activeGraph.pInstance);

		}

	}


function inputFieldChange(event, that) {
	if (activeGraph.id) {
		
		var elName = $(that).attr('name');
		var input = $(that).val();

		switch (elName) {
			case 'nameInput':
			activeGraph.name = input;
			break;

			case 'thresInput':
			activeGraph.thres = input;
			break;
		}

		setGraphProperties(activeGraph.pInstance);


	}
}


//////////Getter - Setter ///////////////////////

 function getGraphProperties(pInstance) {

	if (pInstance) {
	
	activeGraph.thres = pInstance.getThres();
	activeGraph.name = pInstance.getName();
	activeGraph.min = pInstance.getMin();
	activeGraph.max = pInstance.getMax();
	activeGraph.ticks = pInstance.getTicks();
	activeGraph.scale = pInstance.getScale();
	//say(activeGraph);
	}
 }

 function setGraphProperties(pInstance) {

	pInstance.setProperties(activeGraph);

 }

///////////////////////////////////////////////////////////////////////////////
// Mode Select

function setMode (mode) {
	setActiveWindow('.UIWindow');

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
	if(ModeRead()==='setup'){
		
		$('.UIWindow').tabs({'active':2});
		$('.GraphCanvas').addClass('passiv');
		$('#stage').bind("click",function () {
			setMode("work");
		});
		$('.GraphCanvas').draggable({ disabled: false });

		


	if (activeGraph.id) {
		$('.GraphCanvas').addClass('passiv');
		var id = '#'+activeGraph.id;
		$(id).removeClass('passiv');
	}

	}else{
		$('.UIWindow').tabs({'active':0});
		$('.GraphCanvas').removeClass('passiv');
		resetActiveGraph();
		

		$('.GraphCanvas').draggable({ disabled: true });
	}
}

function ModeRead () {
	return $('#ModeSelect .activ').attr('title');
}


///////////////////////////////////////////////////////////////////////////////
// Print to Console

function say (argument) {
	console.log(argument);
}


function animate() {
	this.rValue = Math.random()*1024;

}

var run = setInterval(animate,10);