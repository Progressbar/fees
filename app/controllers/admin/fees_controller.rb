module Admin
  class FeesController < Admin::BaseController
    crudify :fee, :xhr_paging => true
    
    layout proc{ |c| c.request.xhr? ? false : 'admin' }

    def index
      if params[:search]
        @fees = Fee.search(params[:search], params[:page], current_user)
      else
        @fees = Fee.mine(params[:page], current_user)
      end

      render(:partial => 'fees') if request.xhr?
    end

    def paired
      if current_user.has_role?(:superuser)
        @fees = Fee.paired
        @fees = @fees.paginate({:page => params[:page]})

        render(request.xhr? ? {:partial => 'fees' } : {:action => 'index'})
      else
        redirect_to :action => 'index'
      end
    end

    def unpaired
      if current_user.has_role?(:superuser)
        @fees = Fee.unpaired
        @fees = @fees.paginate({:page => params[:page]})
      
        render(request.xhr? ? {:partial => 'fees' } : {:action => 'index'})
      else
        redirect_to :action => 'index'
      end
    end
  end
end