module Config
  module Admin
    class ExpenseConceptsController < ApplicationController
      before_action :set_object, only: %i[destroy]
    
      add_breadcrumb "Config", :config_production_root_path
      add_breadcrumb "Admin"
      add_breadcrumb "Coneptos de gastos", :config_admin_expense_concepts_path
      
      def index
        @concepts = ExpenseConcept.paginate(page: params[:page], per_page: 25)
        @concept = ExpenseConcept.new()

        filter_by_query if params[:query].present?
      end

      def create
        @concept = ExpenseConcept.new(conept_params)
        if @concept.save
          flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Concepto creado correctamente"
          redirect_to config_admin_expense_concepts_path
        else
          @concept = ExpenseConcept.new(conept_params)
          render :index
        end
      end

      def destroy
        @concept.destroy
      end

      private

      def filter_by_query
        query = Regexp.escape(params[:query])
        
        @concepts = @concepts.where("name ~* ?", query)
      end

      def conept_params
        params.require(:expense_concept).permit(:name)
      end

      def set_object
        @concept = ExpenseConcept.find(params[:id])
      end
    end
  end
end