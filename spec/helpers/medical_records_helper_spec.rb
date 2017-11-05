# frozen_string_literal: true

# Specs in this file have access to a helper object that includes
# the MedicalRecordsHelper. For example:
#
# describe MedicalRecordsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe MedicalRecordsHelper, type: :helper do
  describe 'creates a sentence from prescription' do
    it 'concats to how we like' do
      pres = create :prescription, name: 'Palomar 4', dosage: 2, dosage_unit: 'tablet', night: true,
        time: :before_food
      expect(helper.prescription_to_sentence(pres)).to eq('Palomar 4 - 2 tablets to be taken on night before food')
    end
  end

  describe 'creates array of sentences from medical record' do
    it 'concats to how we like' do
      medical_record = create :medical_record
      create :prescription, name: 'Palomar 4', medical_record: medical_record
      expect(helper.prescriptions_sentences_from(medical_record).first).to include 'Palomar'
    end

    it 'renders no prescription found if no prescriptions' do
      medical_record = create :medical_record
      expect(helper.prescriptions_sentences_from(medical_record).first).to include 'No prescriptions found'
    end
  end

  describe 'gives visibility filter' do
    it 'visibility icon' do
      medical_record = build :medical_record
      doctor = build :doctor
      expect(helper.dorp_visibility_icon(medical_record, doctor)).to eq 'visibility_off'
    end

    it 'request icon' do
      medical_record = build :medical_record
      doctor = build :doctor
      expect(helper.dorp_request_icon(medical_record, doctor)).to eq false
    end
  end
end
