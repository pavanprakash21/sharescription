# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    data = {}
    doc_hash(data)
    pharma_hash(data)
    render json: data
  end

  private

  # TODO: Add a better search / data rendering format. Maybe use trigram search on keypress to reduce the number of data
  # This doesn't scale well when there are 1000s of users
  def doc_hash(data)
    Doctor.all.each do |doc|
      data["#{doc.name} (#{doc.email})"] = { id: doc.id, class: doc.class.name, name: doc.name }
    end
  end

  def pharma_hash(data)
    Pharmacist.all.map do |pharma|
      data["#{pharma.name} (#{pharma.email})"] = { id: pharma.id, class: pharma.class.name, name: pharma.name }
    end
  end
end
