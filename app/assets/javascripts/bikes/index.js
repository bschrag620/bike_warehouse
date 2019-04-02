console.log('loading index.js')

var direction = 'asc'
var category = 'manufacturer'

$(document).ready(function() {
	console.log('index loaded');
	loadBikesTable();
})

function createTd(obj, field) {
	td = document.createElement('td')
	td.innerText = obj[field]
	return td
}

function loadBikesTable() {
	data = {category: category, direction: direction}
	table = $('#bikes-table')
	$.get('/bikes.json', data, (resp) => {

	}).done((bikes) => {
		bikes.forEach( (bike) => {
			tr = document.createElement('tr')
			// set some attributes for the row
			$(tr).attr('data-id', bike.id)
			
			tr.append(createTd(bike, 'manufacturer_name'))
			tr.append(createTd(bike, 'frame_name'))
			tr.append(createTd(bike, 'size'))
			tr.append(createTd(bike, 'components'))
			tr.append(createTd(bike, 'discipline_names'))
			tr.append(createTd(bike, 'quantity'))
			td = createTd(bike, 'rating')
			if (td.innerText === '0') {
				td.innerText = 'No reviews'
			}
			tr.append(td)
			tr.append(createTd(bike, 'price'))
			table.append(tr)
		})	
	})
}




