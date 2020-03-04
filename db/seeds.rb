10.times do
  the_first_name = Faker::Name.first_name
  the_last_name = Faker::Name.last_name

  contact = Contact.new(first_name: the_first_name, last_name: the_last_name, email: "#{the_first_name}.#{the_last_name}@gmail.com", phone_number: Faker::PhoneNumber.cell_phone)
  contact.save
end