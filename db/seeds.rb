# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
trek = Manufacturer.create(:name => "Trek")
specialized = Manufacturer.create(:name => "Specialized")

road = Discipline.create(:name => "road")
mtb = Discipline.create(:name => 'mtb')
aero = Discipline.create(:name => "aero")
endurance = Discipline.create(:name => "endurance")
tt = Discipline.create(:name => 'tt')


venge = specialized.frames.build(:name => "Venge")
venge.disciplines << [road, aero]
venge.save
tarmac = specialized.frames.build(:name => "Tarmac")
tarmac.disciplines << [road]
tarmac.save
madone = trek.frames.build(:name => "Madone")
madone.disciplines << [road, aero]
madone.save
domane = trek.frames.build(:name => "Domane")
domane.disciplines << [road, endurance]
domane.save

dura_ace = "Dura Ace"
ultegra = "Ultegra"
sram_red = "SRAM Red"

Bike.create(:year => 2018, :size => 56, :frame_id => venge.id, :color => "white", :components => dura_ace, :price => "8000")
Bike.create(:year => 2018, :size => 57, :frame_id => venge.id, :color => "white", :components => dura_ace, :price => "8000")
Bike.create(:year => 2018, :size => 57, :frame_id => venge.id, :color => "white", :components => dura_ace, :price => "8000")
Bike.create(:year => 2016, :size => 58, :frame_id => madone.id, :color => "blue", :components => ultegra, :price => "5000")
Bike.create(:year => 2016, :size => 56, :frame_id => domane.id, :color => "blue", :components => ultegra, :price => "5000")
password = BCrypt::Password.create("password")
admin = User.create(:username => 'admin', :email => 'brad.schrag@gmail.com', :password_digest => password, :is_admin => true, :password_digest_confirmation => password)
brad = User.create(:username => 'brad', :email => 'brad.schrag@gmail.com', :password_digest => password, :password_digest_confirmation => password)

brad.shipping_addresses.build(:street_address_1 => '555 Bruce Wayne Way', :city => 'Gotham', :state => 'NY', :zip => '55555', :default => true, :user_id => brad.id)
brad.save
