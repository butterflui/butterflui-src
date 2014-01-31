


function Graph(type,id,prev){
	var that = this;

	this.canvas = document.createElement('canvas');
	this.canvas.setAttribute("id", id);

	switch(type){
		case "Bar Graph":
		this.prevsrc = '/modules/balken_prev.pde';
		this.src = '/modules/balken2/balken2.pde';
		break;
		case "Toggle Graph":
		this.prevsrc = '/modules/balken_prev.pde';
		this.src = '/modules/balken2/balken2.pde';
		break;
		case "Circle Graph":
		this.prevsrc = '/modules/balken_prev.pde';
		this.src = '/modules/balken2/balken2.pde';
		break;
		case "Line Graph":
		this.prevsrc = '/modules/balken_prev.pde';
		this.src = '/modules/balken2/balken2.pde';
		break;

	}
	
	this.id = id;
	if (prev){
		this.pInstance = Processing.loadSketchFromSources(this.canvas, [this.prevsrc]);
		this.canvas.className = "GraphPreview";
		return this.canvas;
	}else{
		
		this.pInstance = Processing.loadSketchFromSources(this.canvas, [this.src]);
		this.canvas.setAttribute("class", "GraphCanvas");
		$('#stage').append(this.canvas);
	}

	
	disableDblClick(this.canvas);
	$(this.canvas).click(function(event) {
		event.preventDefault();
		event.stopPropagation();
		setActiveGraph(this);
	});


}




