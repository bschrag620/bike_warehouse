let direction = 1
let category = 'price'
let bikeId;


function init() {
	// if we are on the bikes index page, load this stuff
	if ($('.bikes.index').length > 0) {
		retrieveBikes(loadBikesTable);
		addListenersToHeaders();
	}

	// else, if we are on the bikes show page, load this stuff
	else if ($('.bikes.show').length > 0) {
		retrieveBike(loadBikeDetails);
		hijackFormSubmit();
	}
}

// bikes index code
function addListenersToHeaders() {
	tableHeaders = $('th').toArray()
	tableHeaders.forEach( (th) => {
		// make the header appear clickable				
		$(th).css('cursor', 'pointer')

		th.addEventListener('click', () => {
			loadBikesTable(th.innerText.toLowerCase())
			direction *= -1
		})
	})
}

function addListenerToRow(row) {
	// change cursor hover state
	$(row).css('cursor', 'pointer')
	row.addEventListener('click', function() {
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
	Bike.emptyCache();
	bikes.forEach( (bike) => new Bike(bike))
}

function retrieveBikes(callback) {
	$.get('/bikes.json', (resp) => {
	}).done((bikes) => { 
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
	$('h1#full_name').text(bike.fullName())
	$('#components').text(`Components: ${bike.components}`)
	$('#size').text(`Size: ${bike.size}`)
	$('#disciplines').text(`Discplines: ${bike.discplineNames()}`)
	$('#color').text(`Color: ${bike.color}`)
	$('#part_number').text(`Part number: ${bike.part_number}`)
	bike.quantity === 0 ? qty_available = 'Sold out' : qty_available = bike.quantity
	$('#qty_available').text(`Qty available: ${qty_available}`)
	$('#price').text(`$${bike.price}`)

	loadReviews();
}

function hijackFormSubmit() {
	$("#new_review").submit(function(e) {
		e.preventDefault();
		
		let data = $(this).serialize();

		$.post('/reviews', data).done( (resp) => {
			review = new Review(resp)
			prependReviewBlock(review)
		})
	})
}


// using prepend to place newest comments at the top
function prependReviewBlock(review) {
	const reviewsDiv = $('#reviews')

	const newReviewDiv = document.createElement('div')

	$(newReviewDiv).html(`
			<div class='username'><b>Username: </b>${review.username}</div>
			<div class="rating"><b>Rating: </b>${review.rating}</div>
			<div class="comment"><b>Comment: ${review.comment}</b></div>
			<div class="date"><i>${review.readableTime()}</i></div>
		`)

	reviewsDiv.prepend('<hr>')
	reviewsDiv.prepend(newReviewDiv)		
}

function loadReviews() {
	$('#reviews').text('')

	bike.reviews.forEach( (review) => {
		prependReviewBlock(review)		
	})
}


// conditional to catch if the page has already loaded
// occassionally when the page is cached, it seems to 
// miss the document.ready() call

// if readyState is already complete, run init()

//if (document.readyState == 'complete') {
//	console.log('document loaded')
//	init();
//} else if (document.readyState == 'loading') {
//	console.log('document is loading...')
//}

//$(window).load(function() {
//	console.log('document ready')
//	init()
//})