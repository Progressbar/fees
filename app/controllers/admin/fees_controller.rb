module Admin
  class FeesController < Admin::BaseController

    crudify :fee

    def index
      if params[:search]
        @fees = Fee.search(params[:search], params[:page], current_user)
      else
        @fees = Fee.mine(params[:page], current_user)
      end
      
      render(:layout => false, :partial => 'fees') if request.xhr?
    end
  end
end
