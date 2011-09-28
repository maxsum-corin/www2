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
      redirect_to page_path(@page), :notice => "Page successfully created"
    else
      redirect_to new_page_path, :error => "Please review the errors in the form submission"
    end
  end

  def publish
    @page = Page.find(params[:id])
    @page.publish
    respond_to do |format|
      format.html { redirect_to page_path(@page) }
      format.js
    end
  end
end
