class Api::ContactsController < ApplicationController
  def index
    p "*" * 88
    p current_user
    p "*" * 88
    if current_user 
      # all the contacts
      # but only MY contacts
      # and only in a certain group

      group = Group.find_by(name: params[:category_name])
      work_people = group.contacts
      my_work_people = work_people.where(user_id: current_user.id)

      @contacts = my_work_people
    else 
      @contacts = []
    end
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
      longitude: longitude,
      user_id: current_user.id
    )
    if @contact.save 
      render 'show.json.jb'
    else
      render json: {errors: @contact.errors.full_messages}
    end
  end

  def update
    @contact = Contact.find(params[:id])
    @contact.first_name = params[:first_name] || @contact.first_name
    @contact.last_name = params[:last_name] || @contact.last_name
    @contact.email = params[:email] || @contact.email
    @contact.phone_number = params[:phone_number] || @contact.phone_number
    @contact.bio = params[:bio] || @contact.bio
    @contact.middle_name = params[:middle_name] || @contact.middle_name
    if @contact.save
      render 'show.json.jb'
    else
      render json: {errors: @contact.errors.full_messages}
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    render json: {message: "contact removed"}
  end
end
