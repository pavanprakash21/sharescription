# frozen_string_literal: true

class UsersController < ApplicationController
  # List of users to be shown to the docs or pharmas
  def index
    @users = User.order(name: :asc).limit(100)
  end
end
