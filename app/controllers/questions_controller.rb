class QuestionsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    redirect_to "/", notice: 'You are not authorized to access that page.' unless current_user && current_user.admin?
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    redirect_to "/", notice: 'You are not authorized to access that page.' unless current_user && current_user.admin?
  end

  # GET /questions/new
  def new
    @question = Question.new
    @categories = Category.all
    @correct_answer = Answer.new
    3.times { @question.answers.build(:is_correct => false) }
    render :layout => false
  end

  # GET /questions/1/edit
  def edit
    redirect_to "/", notice: 'You are not authorized to access that page.' unless current_user && current_user.admin?
    @correct_answer = Answer.new
  end

  # POST /questions
  # POST /questions.json
  def create
    @category = Category.find(params[:category_id])
    @question = @category.questions.create(question_params)
    redirect_to category_path(@category)
    return

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    redirect_to "/", notice: 'You are not authorized to access that page.' unless current_user && current_user.admin?
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to admin_dashboard_path, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create_user_question
    category = Category.find(params[:question][:category_id])
    user_question = category.questions.create(:title => params[:question][:title], :user_submitted => true)
    user_question.answers.create(:title =>  params[:answer][:title], :is_correct => true)
    user_question.answers.create(:title =>  params[:question][:answers_attributes]['0'][:title], :is_correct => false)
    user_question.answers.create(:title =>  params[:question][:answers_attributes]['1'][:title], :is_correct => false)
    user_question.answers.create(:title =>  params[:question][:answers_attributes]['2'][:title], :is_correct => false)

    user_question.save

    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Question was successfully submitted.' }
      format.json { head :no_content }
    end

  end

  def rate_current_question

    if !current_user.active_player.current_question.nil?

        question = current_user.active_player.current_question
        question.update_attribute(:rating, question.rating + params[:difficulty].to_i)
        question.update_attribute(:times_rated, question.times_rated + 1)
        overall_difficulty = question.calculate_difficulty_rating
        question.update_attribute(:average_difficulty_rating, overall_difficulty)
    end
    render nothing: true
  end

  def save_user_question()
    @question_to_save = Question.find(params[:id])
    @question_to_save.update_attribute(:user_submitted, :false)
    redirect_to admin_dashboard_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :rating)
    end
end
