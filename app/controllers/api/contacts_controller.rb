class Api::ContactsController < ApplicationController
  def show_contact
    # get data from db
    # show to user
    @contact = Contact.first
    render 'show.json.jb'
  end

  def every_contact
    @contacts = Contact.all
    
    render 'index.json.jb'
  end
end
