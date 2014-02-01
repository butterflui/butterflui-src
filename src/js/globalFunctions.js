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

///////////////////////////////////////////////////////////////////////////////
// Graph Object

function setActiveGraph(that){
	activeGraph.id = $(that).attr('id');
	activeGraph.pInstance = Processing.getInstanceById(activeGraph.id);
	
	activeGraph.X = that.pageX;
	activeGraph.Y = that.pageY;	
	getGraphProperties(activeGraph.pInstance);
	changeActiveGraph();

	

}

function resetActiveGraph(){
	activeGraph = new Object();
	changeActiveGraph();
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


//////////Getter - Setter ///////////////////////

 function getGraphProperties(pInstance) {

	if (pInstance) {
	activeGraph.properties = {};
	activeGraph.properties.thres = pInstance.getThres();
	activeGraph.properties.name = pInstance.getName();
	activeGraph.properties.min = pInstance.getMin();
	activeGraph.properties.max = pInstance.getMax();
	activeGraph.properties.ticks = pInstance.getTicks();
	activeGraph.properties.scale = pInstance.getScale();
	say(activeGraph.properties);
	};
 }

 function setGraphProperties(pInstance) {

	pInstance.setProperties(activeGraph.properties);

 }

///////////////////////////////////////////////////////////////////////////////
// Mode Select

function setMode (mode) {


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
		$('#stage').bind("click",function () {
			resetActiveGraph();
		});
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