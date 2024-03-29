class PagesController < ApplicationController
  def index
    @pages = Page.all
  end

  def show
    @page = Page.find(params[:id])  
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      @page.publish(render_to_string 'page') if @page.published
      redirect_to page_path(@page), :notice => "Page successfully created"
    else
      redirect_to new_page_path, :error => "Please review the errors in the form submission"
    end
  end

  def publish
    @page = Page.get(params[:id])
    @page.publish(render_to_string 'page')
    respond_to do |format|
      format.html { redirect_to page_path(@page) }
      format.js
    end
  end
  
  def unpublish
    @page = Page.get(params[:id])
    @page.unpublish
    respond_to do |format|
      format.html { redirect_to page_path(@page) }
      format.js
    end
  end
end
