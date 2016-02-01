class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy, :update_segments]

  def index
    begin
      logger.debug "Trying to get the Contact tables from the database"
      @contacts = Contact.all
      logger.info "Success getting all the contacts from the database"
      logger.debug "Rendering the Contacts index view"
    rescue ActiveRecord::RecordNotFound => e
      # If there are an error and the projects are unreachable,
      # Returns to home, and show an error message
      logger.error "Error getting the Contacts table from database"
      logger.debug "Redirecting to the root path"
      format.html { redirect_to root_path, notice: 'Something comes wrong. Please, try again' }
    end
  end

  def show
    logger.debug "Trying to show a contact with id: #{ @contact.id }"
  end

  def new
    begin
      logger.debug "Trying to construct a new Contact object."
      @contact = Contact.new
      logger.info "Success constructing a new Contact object."
    rescue
      # If there are an error and there is no way to create a
      # contact, returns to home and display an error message.
      logger.error e.to_s # Print the error in the log level.
      logger.error "Error cronstructing a new Contact object."
      redirect_to root_path, notice: 'Something comes wrong. Please, try again'
    end
  end

  def edit
    logger.debug "Trying to edit a contact with id: #{ @contact.id }"
  end

  def create
    # Create a new contact with given params
    logger.debug "Trying to create a new contact with given params"
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        update_segments
        # If it is ok, go to the contacts page and display a success message
        logger.info "Success creating and saving a new Contact in the database, id: #{ @contact.id }"
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        # If something comes wrong, go to the form again
        logger.error "Error trying to save the Contact in the database"
        logger.debug "Object's params:\n" + params.inspect # Returns a list of entered params
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    logger.debug "Trying to update a contact with id: #{ @contact. id }"
    respond_to do |format|
      if @contact.update(contact_params)
        update_segments
        # If it is ok, go to the contact page and display a success message
        logger.info "Success saving modifications to Contact, id: #{ @contact.id }"
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        # If something comes wrong, go to the form again
        logger.error "Error trying to save the modifyed Contact in the database"
        logger.debug "Object's params:\n" + params.inspect # Returns a list of entered params
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    logger.info "Destroying contact, id: #{ @contact.id }"
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def update_segments
      segments = Segment.all
      segments.each do |segment|
        segment.update_contacts
      end
    end

    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:name, :email, :date_of_birth, :state, :position)
    end
end
