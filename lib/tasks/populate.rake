# frozen_string_literal: true

namespace :db do
  desc 'Seed fake data'

  task populate: :environment do
    # Don't change the order
    create_users
    create_doctors
    create_pharmacists
    create_medical_records_for_users
    share_some_records_with_doctors
    share_some_records_with_pharmacists
  end

  private

  def create_users
    puts 'Creating users'
    20.times do
      user = User.create(person_params)
      user.confirm
    end
    puts 'Created 20 users'
  end

  def create_doctors
    puts 'Creating doctors'
    10.times do
      doctor = Doctor.create(person_params)
      doctor.confirm
    end
    puts 'Created 20 doctors'
  end

  def create_pharmacists
    puts 'Creating pharmacists'
    10.times do
      pharmacist = Pharmacist.create(person_params)
      pharmacist.confirm
    end
    puts 'Created 20 pharmacists'
  end

  def create_medical_records_for_users
    puts 'Creating medical records'
    User.all.each do |user|
      rand(1..5).times do
        user.medical_records.create(medical_record_params)
      end
    end
    puts 'Medical records created'
  end

  def share_some_records_with_doctors
    puts 'Sharing records with doctors'
    MedicalRecord.all.each do |mr|
      Doctor.all.each do |doc|
        ShareRecord.create(share_record_params(mr, doc))
      end
    end
    puts 'Shared records with doctors'
  end

  def share_some_records_with_pharmacists
    puts 'Sharing records with pharmacists'
    MedicalRecord.all.each do |mr|
      Pharmacist.all.each do |doc|
        ShareRecord.create(share_record_params(mr, doc))
      end
    end
    puts 'Shared records with pharmacists'
  end

  def person_params
    { name: Faker::Name.name, email: Faker::Internet.safe_email, password: 'password' }
  end

  def medical_record_params
    { name: Faker::GameOfThrones.unique.character, notes: Faker::Hobbit.quote,
        prescriptions_attributes: prescriptions_attributes }
  end

  def prescriptions_attributes
    array = []
    rand(1..5).times { array << prescriptions }
    array
  end

  def prescriptions
    { name: Faker::Space.star_cluster, dosage: Faker::Number.between(1, 5),
        dosage_unit: %w[ml tablespoon tablet mg sachet].sample, morning: random_bool,
        afternoon: random_bool, night: random_bool, time: %w[before_food after_food].sample }
  end

  def share_record_params(mr, doc)
    { medical_record: mr, user: mr.user, shareable: doc, action: %i[requested granted shared].sample,
        shared: random_bool, created_by: %w[User Doctor Pharmacist].sample }
  end

  def random_bool
    [true, false].sample
  end
end
