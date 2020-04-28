module Config
  class TaxesController < ApplicationController
  	before_action :set_object, only: %i[edit update destroy]
    add_breadcrumb "Config"
    add_breadcrumb "Impuestos", :config_taxes_path

  	def index
  		@taxes = Tax.paginate(page: params[:page], per_page: 16)
      search if params[:q].present?
  	end

  	def new
      add_breadcrumb "Nuevo"
      @tax = Tax.new
  	end

    def edit
      add_breadcrumb "Editar"
    end

    def create
      @tax = Tax.new(tax_params)
      respond_to do |format|
        if @tax.save
          format.html { redirect_to config_taxes_url, notice: 'Impuesto creado' }
          format.json { render :show, status: :created, location: @tax }
        else
          format.html { render :new }
          format.json { render json: @tax.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      if @tax.update(tax_params)
        flash[:notice] = "Impuesto actualizado"
        redirect_to config_taxes_url
      else
        render :edit
      end
    end

    def destroy
      @tax.destroy
    end
  	
    private
    
    def search
      q = Regexp.escape(params[:q])
    
      @taxes = @taxes.where("concat(name, ' ', value) ~* ?", q)
    end
  	
    def tax_params
      params.require(:tax).permit(:name, :value)
    end

    def set_object
      @tax = Tax.find(params[:id])
    end
  end
end