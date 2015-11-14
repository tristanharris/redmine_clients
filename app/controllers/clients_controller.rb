class ClientsController < ApplicationController
  unloadable

  def index
    render :json => Client.search(params[:term]).map{|c| {label: c.name, value: c.id}}
  end

end
