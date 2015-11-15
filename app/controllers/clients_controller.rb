class ClientsController < ApplicationController
  unloadable

  def index
    render :json => Client.search(params[:term]).map{|c| {label: c.name, value: c.id}}
  end

  def show
    render :json => {:label => Client.find(params[:id]).name}
  end

end
