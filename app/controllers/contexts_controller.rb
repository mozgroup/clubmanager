class ContextsController < TasksBaseController

  def index
    @contexts = Context.by_name
  end

  def show
    @context = Context.find params[:id]
  end

  def search
    contexts = Context.name_search params[:term]

    respond_to do |format|
      format.json { render json: contexts.collect { |c| c.name } }
    end
  end

end
