class StoriesController < ApplicationController
  before_filter :authenticate, only: [:new, :create, :edit, :update, :destroy]
  respond_to :html, :js
  
  def index
    @search = Story.search do
      fulltext params[:search]
      paginate page: params[:page], per_page: 5
      facet :event_month
      facet :event_year
      with(:event_month, params[:month]) if params[:month].present?
      with(:event_year, params[:year]) if params[:year].present?
      order_by(:event_date,:asc) if params[:search].blank? or params[:event_month].blank?
    end
    @stories = @search.results
    @years = @search.facet(:event_year).rows.sort {|top,bottom| bottom.value.to_i <=> top.value.to_i }
    if params[:search].blank?
      @stories = Story.paginate(page: params[:page], per_page: 5)
    end
  end
  
  def show
    @story = Story.find(params[:id])
  end
  
  def show_visuals
    @visuals = Story.find_by_id(params[:id]).visuals
    @visual = @visuals[params[:visual_id].to_i] || @visual[0]
    respond_with @visuals, @visual
  end
  
  def show_video
    @story = Story.find_by_id(params[:id])
    @video_url = @story.video
    @video_source = @story.video_source
    
    respond_with @video_url, @video_source
  end

  def new
    @story = Story.new
    3.times {@story.visuals.build}
  end

  def edit
    @story = Story.find(params[:id])
    3.times {@story.visuals.build}
  end

  def create
    @story = Story.new(params[:story])
    
    if @story.save
      redirect_to root_path, notice: 'Story is successfully created.'
    else
      render new_story_path
    end
  end

  def update
    @story = Story.find(params[:id])

    if @story.update_attributes(params[:story])
      redirect_to root_path, notice: 'Story was successfully updated.'
    else
      render edit_story_path(@story)
    end
  end

  def destroy
    story = Story.find_by_id(params[:id])
    story.destroy
    redirect_to root_path, notice: "Story is successfully deleted."
  end
end





