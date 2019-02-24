# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
dura_ace = "Dura Ace"
ultegra = "Ultegra"
sram_red = "SRAM Red"

road = Discipline.create(:name => "road")
mtb = Discipline.create(:name => 'mtb')
aero = Discipline.create(:name => "aero")
tt = Discipline.create(:name => 'tt')

Bike.create(:year => 2018, :size => 56, :manufacturer => "Specialized", :color => "white", :components => dura_ace, :frame => "Venge", :discipline_ids => [1, 3], :price => "8000")
Bike.create(:year => 2018, :size => 56, :manufacturer => "Specialized", :color => "white", :components => dura_ace, :frame => "Venge", :discipline_ids => [1, 3], :price => "8000")
Bike.create(:manufacturer => "Trek", :color => "blue")
