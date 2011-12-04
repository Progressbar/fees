class FeesController < ApplicationController

  def index
    render :text => 0
  end  
  
  def create
    response = {'status' => false}
    fp = params[:fee]
    fp[:user] = User.find_by_progressbar_uid(fp[:vs].to_i)

    fee = Fee.new(fp)
    
    if fee.valid?
      response['status'] = fee.save!
    else
      response['errors'] = fee.errors
    end

    render :text => response.to_json
  end
  
end
