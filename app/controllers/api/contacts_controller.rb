class Api::ContactsController < ApplicationController
  def index
    @contacts = Contact.all
    render 'index.json.jb'
  end

  def show
    @contact = Contact.find(params[:id])
    render 'show.json.jb'
  end

  def create
    results = Geocoder.search(params[:address])
    latitude = results.first.coordinates[0]
    longitude = results.first.coordinates[1]

    @contact = Contact.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      middle_name: params[:middle_name],
      bio: params[:bio],
      address: params[:address],
      latitude: latitude,
      longitude: longitude
    )
    @contact.save 
    render 'show.json.jb'
  end

  def update
    @contact = Contact.find(params[:id])
    @contact.update(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      bio: params[:bio],
      middle_name: params[:middle_name]
    )
    @contact.save 
    render 'show.json.jb'
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    render json: {message: "contact removed"}
  end
end
