console.log('loading index.js')

var direction = 1
var category = 'price'
var bikeCache = []

class Bike {
	constructor(bike) {
		bikeCache.push(bike)
		console.log(`${bike.id} added to cache, length: `, Object.keys(bikeCache).length)
	}

	static sortBy(fieldName) {
		category = fieldName
		return bikeCache.sort( (a, b) => {
			let comparator = 0;
			if (a[fieldName] < b[fieldName]) {
				comparator = 1
			} else if (a[fieldName] > b[fieldName]) {
				comparator = -1
			}

			return direction * comparator
		 })
	}
}

$(document).ready(function() {
	console.log('index loaded');
	retrieveBikes(loadBikesTable);
	addListenersToHeaders();
})

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
		bikesToCache(bikes);
		if (callback) {
			callback();
		}
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




