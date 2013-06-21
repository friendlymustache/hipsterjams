class VideosController < ApplicationController
  # GET /videos
  # GET /videos.json
  def index
    @video = Video.find(1)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @videos }
    end
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @video = Video.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @video }
    end
  end

  # GET /videos/new
  # GET /videos/new.json
  def new
    @popularity = params[:popularity].to_i      
    @video = Video.new
    
    adjectives = ["indie", "underground", "experimental"]
    
    if @popularity == 10
      adjectives += ["mumford and sons", "fleet foxes", "vampire weekend", "sigur ros"]
    end
    genres = ["electronica", "folk", "folk rock", "jazz"]
    random = rand(genres.length)
    random2 = rand(adjectives.length)
    @search_string = adjectives[random2]+"+"+genres[random]
 
    
    @youtube_url = "http://www.youtube.com/results?search_type=videos&search_query="+
    @search_string+"&filters=video&search_sort=video_view_count&alt=json-in-script&format=5&callback=setVideo"
   
   if @popularity <= 7 # if popularity threshold is less than or equal to 7
     unless @popularity == 7 || @popularity == 6
      @start_index = "3"
     else
       @start_index = "1"
     end
     @max_results = (10+(7-@popularity)*3) # more max results so more low-view videos
     @search_string += "+-top ten list" # don't include videos with "top ten"     
   end
  
   if @popularity <= 4
       @start_index = "5"       
       @max_results = (20+(4-@popularity)*5) #even more max results       
   end
   
   if @popularity <= 2
       @search_string += "+-best_of" #don't include videos with "best of"     
   end
     
   if @popularity >=8 #if popularity is 8, 9, 10
     @start_index = "1"
     @max_results = (2+(10-@popularity)*2)
   end
   
   @max_results = @max_results.to_s
   
   # max views in order of increasing popularity (0-10):
   # 2, 4, 6, 10, 13, 16, 20, 25, 30, 35

        
    @search_url = 'https://gdata.youtube.com/feeds/api/videos?q='+@search_string+'&orderby=viewCount&start-index='+@start_index+
    '&max-results='+@max_results+'&v=2&alt=json-in-script&format=5&callback=setVideo'
    # between the ' after search_string and the &: +-best of+-top ten
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @video }
      format.js # new.js.erb finds a new random youtube video and sends a post request to create
    end
  end

  # GET /videos/1/edit
  def edit
    @video = Video.find(params[:id])
  end

  # POST /videos
  # POST /videos.json
  def create
    identifier = params[:identifier]
    video = Video.find_by_name(params[:name])
    if video == nil
      @video = Video.new(:hipster => 0, :identifier => identifier, :name => params[:name]) #have to figure out how to find video name
    else
      @video = Video.new({:hipster => "save should fail"})
    end

    respond_to do |format|
      if @video.save
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /videos/1
  # PUT /videos/1.json
  def update
    @video = Video.find(params[:id])

    respond_to do |format|
      if @video.update_attributes(params[:video])
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    respond_to do |format|
      format.html { redirect_to videos_url }
      format.json { head :no_content }
    end
  end
  
  def hipster
    @video = Video.find(params[:id])
    is_hipster = params[:hipsterness]
    user_voted = params[:voted]
    if user_voted != "true"
      if is_hipster == "true"
        @video.hipster+=1
      else
        @video.hipster-=1
      end    
    
    else
      if is_hipster == "true"
        @video.hipster+=2
      else
        @video.hipster-=2
      end      
    end

    respond_to do |format| 
      if @video.save
        format.html { redirect_to root_path }
        # format.js { redirect_to new_video_path+"?popularity="+params[:popularity] }
        format.js {redirect_to root_path}
      else
        format.html {redirect_to root_path, notice: "There was an error saving your vote"}
        format.js {redirect_to root_path}
      end
    end
  end
end
