# frozen_string_literal: true

module Crm
  module Config
    class ExpensesController < ApplicationController
      before_action :set_object, only: %i[show edit update destroy]
      add_breadcrumb 'CRM', :crm_root_path
      add_breadcrumb 'Configuración', :crm_config_root_path
      add_breadcrumb 'Gastos', :crm_config_expenses_path

      def index
        @expenses = Expense.paginate(page: params[:page], per_page: 25)
        @expense = Expense.new

        search if params[:q].present?
       end

      def edit
        add_breadcrumb 'Editar'
      end

      def show
        add_breadcrumb 'Detalle'
      end

      def create
        @expense = Expense.new(expense_params)
        if @expense.save
          flash[:notice] = "<i class='fas fa-check-circle mr-2'></i>Gasto creado"
          redirect_to crm_config_expenses_path
        else
          render :index
        end
      end

      def update
        if @expense.update(expense_params)
          flash[:notice] = "<i class='fas fa-check-circle mr-2'></i>Gasto Actualizado"
          redirect_to crm_config_expenses_path
        else
          render :edit
        end
      end

      def destroy
        @expense.destroy
      end

      private

      def search
        q = Regexp.escape(params[:q])

        @expenses = @expenses.where('name ~* ?', q)
      end

      def expense_params
        params.require(:expense).permit(:name)
       end

      def set_object
        @expense = Expense.find(params[:id])
       end
    end
  end
end
