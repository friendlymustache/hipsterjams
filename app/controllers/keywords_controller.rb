class KeywordsController < ApplicationController

def index
  @keywords = Keyword.all
  respond_to do |format|
    format.html
    format.js
  end
end



def new
  @keyword = Keyword.new
  respond_to do |format|
    format.html
    format.js
  end  
end


def create
  @keyword = Keyword.new(params[:keyword])
  if @keyword.save
    @keyword_saved = true
    respond_to do |format|
      format.html {redirect_to root_path, notice: "Keyword saved"}
      format.js 
    end
    
  else
    @keyword_saved = false
    respond_to do |format|
      format.html {redirect_to root_path, notice: "Errors occurred while saving your keyword"}
      format.js   
    end
  end
end



















end