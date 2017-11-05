# frozen_string_literal: true

module MedicalRecordsHelper
  # Since js uses a for loop, we provide an array of sentences to render
  def prescriptions_sentences_from(medical_record)
    array = []
    if medical_record.prescriptions.size.positive?
      medical_record.prescriptions.each { |prescription| array << prescription_to_sentence(prescription) }
    else
      array << 'No prescriptions found for this medical record'
    end
    array
  end

  # This method converts the attrs from the prescriptions into a easy, human readable sentence.
  # This method has been broken down to several methods to reduce the ABC size.
  def prescription_to_sentence(prescription)
    prescription.name.humanize + ' - ' + dosage_to_sentence(prescription) + ' to be taken on ' +
      bool_to_sentence(prescription) + ' ' + time_to_sentence(prescription)
  end

  # Following method returns the boolean text if true, nil otherwise
  # TODO: Change this to something more semantic than a ternary operator
  def bool_to_text(prescription, bool)
    prescription.public_send(bool) == true ? bool : nil
  end

  # Get the array of valid time booleans to convert them into a sentence.
  # Must reject empty strings since the result would be "morning, '', and night" which looks weird
  def bool_to_sentence(prescription)
    array = %W[#{bool_to_text(prescription, 'morning')}
               #{bool_to_text(prescription, 'afternoon')}
               #{bool_to_text(prescription, 'night')}]
    array.reject(&:empty?).to_sentence
  end

  # Returns the pluralized version of the dosage with appropriate units
  def dosage_to_sentence(prescription)
    pluralize(prescription.dosage, prescription.dosage_unit)
  end

  # Get the final part of the sentence
  def time_to_sentence(prescription)
    prescription.time.humanize(capitalize: false)
  end

  def dorp_visibility_icon(record, current_resource)
    record.share_records.exists?(shareable: current_resource, shared: true) ? 'visibility' : 'visibility_off'
  end

  def dorp_request_icon(record, current_resource)
    record.share_records.exists?(shareable: current_resource)
  end
end
