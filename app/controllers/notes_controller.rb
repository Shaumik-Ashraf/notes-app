class NotesController < ApplicationController
  before_action :authenticate_user!, except: %i[ index ]
  before_action :set_note, only: %i[ show edit update destroy ]

  # GET /notes
  def index
    @notes = []
    flash.now.alert = "No users in database. Please create a user from console." if User.count == 0

    if user_signed_in?
      @notes = Note.where(user: current_user).order(updated_at: :desc)
    end
  end

  # GET /notes/1
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  def create
    @note = Note.new(note_params.merge({ user: current_user }))

    if @note.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @note, notice: "Note was successfully created." }
      end
    else
      render :new, status: :unprocessable_content
    end
  end

  # PATCH/PUT /notes/1
  def update
    if @note.update(note_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to notes_path, notice: "Note was successfully updated.", status: :see_other }
      end
    else
      render :edit, status: :unprocessable_content
    end
  end

  # DELETE /notes/1
  def destroy
    @note.destroy!
    redirect_to notes_path, notice: "Note was permanently deleted."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find_by(id: params.expect(:id), user: current_user)
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.expect(note: [ :body ])
    end
end
