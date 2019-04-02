console.log('loading index.js')

var direction = 'asc'
var category = 'manufacturer'

bikeCache = []

class Bike {
	constructor(bike) {
		this.frame_name = bike.frame_name
		this.size = bike.size
		this.components = bike.components
		this.quantity = bike.quantity
		this.rating = bike.rating
		this.price = bike.price
		bikeCache.push(bike)
		console.log(`${bike.id} added to cache, length: `, Object.keys(bikeCache).length)
	}
}

$(document).ready(function() {
	console.log('index loaded');
	retrieveBikes();
	addListenersToHeaders();
})

function swapDirection() {
	if (direction === 'asc') {
		direction = 'desc'
	} else {
		direction = 'asc'
	}
}

function addListenersToHeaders() {
	tableHeaders = $('th').toArray()
	tableHeaders.forEach(function(th) {
		// make the header appear clickable				
		$(th).css('cursor', 'pointer')

		th.addEventListener('click', function() {
			url = '/bikes/sort/' + th.innerText.toLowerCase() + '/' + direction
			data = {category: th.innerText.toLowerCase(), direction: direction}
			retrieveBikes(data);
			swapDirection();
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

function retrieveBikes(data = {category: category, direction: direction}) {
	$.get('/bikes.json', data, (resp) => {
	}).done((bikes) => bikesToCache(bikes))
}

function emptyTable() {
	$('tr').slice(1).remove()
}

function loadBikesTable(bikes) {
	table = $('#bikes-table')

	// empty the table 
	emptyTable();

	bikes.forEach( (bike) => {
		tr = document.createElement('tr')

		// set some attributes for the row
		$(tr).attr('data-id', bike.id)
		addListenerToRow(tr)
		tr.append(createTd(bike, 'manufacturer_name'))
		tr.append(createTd(bike, 'frame_name'))
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




