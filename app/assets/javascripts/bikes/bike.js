var bikeCache = []

class Bike {
	constructor(bike) {
		this.id = bike.id
		this.color = bike.color
		this.disciplines = bike.discplines
		this.frame = bike.frame
		this.manufacturer = bike.manufacturer
		this.part_number = bike.part_number
		this.price = bike.price
		this.quantity = bike.quantity
		this.rating = bike.rating
		this.reviews = Bike.createReviews(bike.reviews)
		this.size = bike.size
		this.year = bike.year

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

	static createReviews(reviews) {
		return reviews.map( function(r) {
			return new Review(r)
		})
	}

	fullName() {
		return `${this.year} ${this.manufacturer} ${this.frame}`
	}
}