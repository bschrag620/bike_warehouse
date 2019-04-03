var direction = 1
var category = 'price'
var bikeId;

$(document).ready(function() {
	
	// if we are on the bikes index page, load this stuff
	if ($('.bikes.index').length > 0) {
		retrieveBikes(loadBikesTable);
		addListenersToHeaders();
	}

	// else, if we are on the bikes show page, load this stuff
	else if ($('.bikes.show').length > 0) {
		console.log('on bikes show page...')
		retrieveBike(loadBikeDetails);
	}
})


// bikes index code
function addListenersToHeaders() {
	tableHeaders = $('th').toArray()
	tableHeaders.forEach(function(th) {
		// make the header appear clickable				
		$(th).css('cursor', 'pointer')

		th.addEventListener('click', function() {
			loadBikesTable(th.innerText.toLowerCase())
			direction *= -1
		})
	})
}

function addListenerToRow(row) {
	// change cursor hover state
	$(row).css('cursor', 'pointer')
	row.addEventListener('click',function() {
		url = '/bikes/' + $(this).data('id')
		window.location = url
	})
}

function createTd(obj, field) {
	td = document.createElement('td')
	td.innerText = obj[field];
	return td
}

function bikesToCache(bikes) {
	bikes.forEach( (bike) => new Bike(bike))
}

function retrieveBikes(callback) {
	$.get('/bikes.json', (resp) => {
	}).done((bikes) => { 
		debugger
		bikesToCache(bikes);
		callback();
	})
}

function emptyTable() {
	$('tr').slice(1).remove()
}

function loadBikesTable(fieldName=category) {
	table = $('#bikes-table')

	// empty the table 
	emptyTable();

	Bike.sortBy(fieldName).forEach( (bike) => {
		tr = document.createElement('tr')
		// set some attributes for the row
		$(tr).attr('data-id', bike.id)
		addListenerToRow(tr)
		tr.append(createTd(bike, 'manufacturer'))
		tr.append(createTd(bike, 'frame'))
		tr.append(createTd(bike, 'size'))
		tr.append(createTd(bike, 'components'))
		tr.append(createTd(bike, 'quantity'))
		td = createTd(bike, 'rating')
		if (td.innerText === '0') {
			td.innerText = 'No reviews'
		}
		tr.append(td)
		tr.append(createTd(bike, 'price'))
		table.append(tr)
	})	
}



// bikes show code

function retrieveBike(callback) {
	bikeId = $('.bikes.show').attr('id')
	$.get(`/bikes/${bikeId}.json`, (resp) => {
	}).done( (bike) => {
		callback(bike); 
	});
}

function loadBikeDetails(bikeDetails) {
	bike = new Bike(bikeDetails)
	$('.bike.show').attr('id', bike.id)
	$('h1#full_name').text(bike.full_name)
	$('#components').text(`Components: ${bike.components}`)
	$('#size').text(`Size: ${bike.size}`)
	$('#color').text(`Color: ${bike.color}`)
	$('#part_number').text(`Part number: ${bike.part_number}`)
	qty_available = bike.quantity
	if (qty_available === 0) { qty_available = 'Sold out'}
	$('#qty_available').text(`Qty available: ${qty_available}`)
	$('#price').text(`$${bike.price}`)
}