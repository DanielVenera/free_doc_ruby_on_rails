# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

Expertise.destroy_all
Appointment.destroy_all
Doctor.destroy_all
Patient.destroy_all
Specialty.destroy_all
City.destroy_all

#SPECIALTIES : 
#With this array below we create a table with each row = 1 specialty from the array
#For each table I gave a count (here z), in order to have the id beginning at 0 (with my previous seeds tests, the ids did not refresh at 1)
specialties_array = ["ALLERGY & IMMUNOLOGY", "ANESTHESIOLOGY", "DERMATOLOGY", "DIAGNOSTIC RADIOLOGY", "NEUROLOGY", "OPHTHALMOLOGY", "PEDIATRICS"]
z = 0
specialties_array.each do |specialty|
    z += 1
    Specialty.create(id: z, name: specialty)
end

#CITIES : 
#The use of the faker gem in order to have random  adresses 
#I separate this loop from doctors and patients in order to have 20 cities before selecting them for each doctors and patients
a = 0
20.times do 
    a += 1
    City.create(id: a, name: Faker::Address.city)
end

#DOCTORS AND PATIENTS : 
#I randomize the city 
b = 0
20.times do
    b += 1
    Doctor.create(id: b, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, zip_code: Faker::Address.zip_code, city: City.find(rand(1..20)))
    Patient.create(id: b, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, city: City.find(rand(1..20)))
end

#APPOINTMENT
# I randomize the date and hour (it's a bit strange to have an appointment at 10:48 but the faker gem did not have the 30 minutes interval possibility)
# I randomize the patient and doctor
#
#EXPERTISES
# I randomize the doctor and the specialty
c = 0
20.times do 
    c += 1
    Appointment.create(id: c, date: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :short), doctor: Doctor.find(rand(1..20)), patient: Patient.find(rand(1..20)), city: City.find(rand(1..20)))
    Expertise.create(id: c, doctor: Doctor.find(rand(1..20)), specialty: Specialty.find(rand(1..specialties_array.size)))
end

puts "load of cities, specialties, doctors (without the column specialty), patients, appointments and expertises (the join table between doctors and specialties)"