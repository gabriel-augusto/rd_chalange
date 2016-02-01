class SegmentsController < ApplicationController
  before_action :set_segment, only: [:show, :edit, :update, :destroy, :build_query]

  def index
    begin
      logger.debug "Trying to get the Segment tables from the database"
      @segments = Segment.all
      logger.info "Success getting all the segments from the database"
      logger.debug "Rendering the Segments index view"
    rescue ActiveRecord::RecordNotFound
      # If there are an error and the projects are unreachable,
      # Returns to home, and show an error message
      logger.error "Error getting the Segments table from database"
      logger.debug "Redirecting to the root path"
      format.html { redirect_to root_path, notice: 'Something comes wrong. Please, try again' }
    end
  end

  def show
    logger.debug "Trying to show a segment with id: #{ @segment.id }"
  end

  def new
    begin
      logger.debug "Trying to construct a new Segment object."
      @segment = Segment.new
      logger.info "Success constructing a new Segment object."
    rescue
      # If there are an error and there is no way to create a
      # segment, returns to home and display an error message.
      logger.error "Error cronstructing a new Segment object."
      redirect_to root_path, notice: 'Something comes wrong. Please, try again'
    end
  end

  def edit
    logger.debug "Trying to edit a segment with id: #{ @segment.id }"
  end

  def create
    # Create a new segment with given params
    logger.debug "Trying to create a new segment with given params"
    @segment = Segment.new(segment_params)

    respond_to do |format|
      if @segment.save
        @segment.update_contacts
        # If it is ok, go to the segments page and display a success message
        logger.info "Success creating and saving a new Segment in the database, id: #{ @segment.id }"
        format.html { redirect_to @segment, notice: 'Segment was successfully created.' }
        format.json { render :show, status: :created, location: @segment }
      else
        # If something comes wrong, go to the form again
        logger.error "Error trying to save the Segment in the database"
        logger.debug "Object's params:\n" + params.inspect # Returns a list of entered params
        format.html { render :new }
        format.json { render json: @segment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    logger.debug "Trying to update a segment with id: #{ @segment. id }"
    respond_to do |format|
      if @segment.update(segment_params)
        @segment.update_contacts
        # If it is ok, go to the segment page and display a success message
        logger.info "Success saving modifications to Segment, id: #{ @segment.id }"
        format.html { redirect_to @segment, notice: 'Segment was successfully updated.' }
        format.json { render :show, status: :ok, location: @segment }
      else
        # If something comes wrong, go to the form again
        logger.error "Error trying to save the modifyed Segment in the database"
        logger.debug "Object's params:\n" + params.inspect # Returns a list of entered params
        format.html { render :edit }
        format.json { render json: @segment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    logger.info "Destroying segment, id: #{ @segment.id }"
    @segment.destroy
    respond_to do |format|
      format.html { redirect_to segments_url, notice: 'Segment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_segment
      @segment = Segment.find(params[:id])
    end

    def segment_params
      params.require(:segment).permit(
          :title,
          groups_attributes: [
              :_destroy,
              :id,
              :segment_id,
              text_queries_attributes: [
                  :_destroy,
                  :id,
                  :group_id,
                  :contact_argument,
                  :value_to_compare
              ],
              numeric_queries_attributes: [
                  :_destroy,
                  :id,
                  :group_id,
                  :contact_argument,
                  :min_value,
                  :max_value
              ]
          ]
      )
    end
end
