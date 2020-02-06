class Specialty < ApplicationRecord
    has_many :expertises
    has_many :doctors, through: :expertises
end
