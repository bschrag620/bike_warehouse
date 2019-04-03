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