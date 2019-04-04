class Review {
	constructor(review) {
		this.id = review.id
		this.username = review.username
		this.rating = review.rating
		this.comment = review.comment
		this.time = review.updated_at
	}

	readableTime() {
		let minutes = this.time.split(':')[1]
		let hours = this.time.split(':')[0].split('T')[1]
		let year = this.time.split(':')[0].split('T')[0].split('-')[0]
		let month = this.time.split(':')[0].split('T')[0].split('-')[1]
		let day = this.time.split(':')[0].split('T')[0].split('-')[2]
		return `Comment left at ${hours}:${minutes} on ${month}/${day}/${year}`
	}
}