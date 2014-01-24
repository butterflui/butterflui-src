function newGraphMenu(e) {


	/////////////////////////////////////////////////////////////////////
	// Variables and Html Windows
	var toggleWindow2 = 0;
	var GraphMenue = $("<div/>", {"class":"ListWindow Variables"});

	GraphMenue.load('src/html/VariableList.html', function(){
		$('.VariablesAccord').accordion({collapsible:true, active:false});
		$(GraphMenue).click(function(event){
		event.preventDefault();
		event.stopPropagation();
	});
		$('.Variables a').click(function(event) {
			OnClickGraphMenue(event, this);
		});
	}
		);


	var ArdView = $("<div/>",{"class":"Arduino ListWindow"});
	var ArdViewIn = $('<ul><li class ="inaktive"></li><li class ="inaktive"></li> <li><a href="#"></a></li> <li><a href="#"></a></li> <li><a href="#"></a></li> <li><a href="#"></a></li> <li><a href="#"></a></li> <li><a href="#"></a></li> <li class="divide"><a href="#"></a></li> <li><a href="#"></a></li> <li><a href="#"></a></li> <li><a href="#"></a></li> <li><a href="#"></a></li> <li><a href="#"></a></li> <li class ="inaktive"></li> <li class ="inaktive"></li> <li class ="inaktive"></li> <li class ="inaktive"></li> </ul> <ul class="PinName"> <li>0</li> <li>1</li> <li>2</li> <li>3</li> <li>4</li> <li>5</li> <li>6</li> <li>7</li> <li class="divide">8</li> <li>9</li> <li class="lessSpace">10</li> <li class="lessSpace">11</li> <li class="lessSpace">12</li> <li class="lessSpace">13</li> </ul> <div class="processor"></div> <ul> <li><a href="#"></a></li> <li><a href="#"></a></li> <li><a href="#"></a></li> <li><a href="#"></a></li> <li><a href="#"></a></li> <li><a href="#"></a></li> <li class ="inaktive divide"></li> <li class ="inaktive"></li> <li class ="inaktive"></li> <li class ="inaktive"></li> <li class ="inaktive"></li> <li class ="inaktive"></li> <li class ="inaktive"></li> <li class ="inaktive"></li> </ul>');
	$(ArdViewIn).appendTo(ArdView);

	var canvas = $('<canvas/>');
	// var code = $('window').get('../modules/balken_prev.pde');
	// var p = Processing.loadSketchFromSources(canvasRef, '/modules/balken_prev.pde');

	var GraphView = $('<div class="GraphSelect ListWindow"></div>');
	var canvasPrev = document.createElement('canvas');
	var p = Processing.loadSketchFromSources(canvasPrev, ['/modules/balken_prev.pde']);
	canvasPrev.className = "GraphPreview";
	var GraphViewIn = $('<ul> <li><a href="">Bar Graph</a></li> <li><a href="">Toggle Graph</a></li> <li><a href="">Circle Graph</a></li> <li><a href="">Line Graph</a></li> </ul>');
	$(canvasPrev).appendTo(GraphView);
	$(GraphViewIn).appendTo(GraphView);

	
	
	$("#stage").append(GraphMenue);
	
	$(GraphMenue).offset({top:e.pageY, left:e.pageX});

	

	
	/////////////////////////////////////////////////////////////////////
	//close ListWindow by single click on Stage
	closeWindowHandler(GraphMenue);

	/////////////////////////////////////////////////////////////////////
	//open second Window
	function OnClickGraphMenue(event,that) {
		
		$(that).toggleClass('active');


			/////////////////////////////////////////////////////////////////////
			//removes 2nd window if nothing is selected
			if ($(".ListWindow .active").length === 0) {
				$(ArdView).remove();
				$(GraphView).remove();
				toggleWindow2 = 0;
			}

			/////////////////////////////////////////////////////////////////////
			//Open Graphmenue by selecting Variables
			if($(that).attr('class') == "ListWindowVar active"){


				switch(toggleWindow2)
				{
					case 0:
					showGraphView(event,e.pageX+$(GraphMenue).width()+1,e.pageY);
					toggleWindow2 = 1;

					break;

					case 1:
					
					break;

					case 2:
					$(ArdView).remove();
					$(".ListWindowArd").removeClass('active');
					showGraphView(event,e.pageX+$(GraphMenue).width()+1,e.pageY);
					toggleWindow2 = 1;
					break;
				}

			}


			/////////////////////////////////////////////////////////////////////
			//Open Arduino Overview by selecting Arduino
			if($(that).attr('class') == "ListWindowArd active"){
				switch(toggleWindow2)
				{
					case 0:
					showArdView(event,e.pageX+$(GraphMenue).width()+1,e.pageY);
					toggleWindow2 = 2;
					break;

					case 1:
					$(GraphView).remove();
					$(".ListWindowVar").removeClass('active');
					showArdView(event,e.pageX+$(GraphMenue).width()+1,e.pageY);
					toggleWindow2 = 2;
					break;

					case 2:
					break;
				}
			
		}
		
	}

	disableDblClick(GraphMenue);

	/////////////////////////////////////////////////////////////////////
	//Show Graph Selector Window
	function showGraphView(e, positionX, positionY) {
		
		
		
		$("#stage").append(GraphView);
		$(GraphView).offset({left:positionX, top:positionY});

		closeWindowHandler(GraphView);
		
	}
	/////////////////////////////////////////////////////////////////////
	//Show Arduino Pin Selector Window
	function showArdView(e, positionX, positionY) {
		
		$("#stage").append(ArdView);
		$(ArdView).offset({left:positionX, top:positionY});

		closeWindowHandler(ArdView);
		
	}


	/////////////////////////////////////////////////////////////////////
	// Remove Window if click on stage
	function closeWindowHandler (windowId) {

		$("#stage").click(function(event) {
		$(windowId).remove();
	});
	}
}