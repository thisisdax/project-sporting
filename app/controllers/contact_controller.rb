class ContactController < ApplicationController
  before_action :authenticate_user!
  def new
    render '/contacts/new'
  end
end
