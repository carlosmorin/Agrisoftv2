module Commercial
  module Config
    class DeliveryTypesController < ApplicationController
      before_action :set_object, only: %i[edit update destroy]

      add_breadcrumb "Commercial", :commercial_root_path
      add_breadcrumb "Configuración", :commercial_config_root_path

      def index
        add_breadcrumb "Tipos de entrega"

        @delivery_types = DeliveryType.all
        @delivery_type = DeliveryType.new
        
        search if params[:q].present?
        @delivery_types = @delivery_types.paginate(page: params[:page], per_page: 25)
      end

      def create
        @delivery_type = DeliveryType.new(delivery_type_params)
        @delivery_type.save
        msg = "<i class='fas fa-check-circle mr-2'></i> Tipo de entrega creada correctamente"
        flash[:notice] = msg
        redirect_to commercial_config_delivery_types_path
      end

      def update
        @delivery_type.update(delivery_type_params)
        msg = "<i class='fas fa-check-circle mr-2'></i> Tipo de actualizada correctamente"
        flash[:notice] = msg
        redirect_to commercial_config_delivery_types_path
      end

      private

      def delivery_type_params
        params.require(:delivery_type).permit(:id, :name)
      end

      def set_object
        @delivery_type = DeliveryType.find(params[:id])
      end

      def search
        query = Regexp.escape(params[:q])

        @delivery_types = @delivery_types.where("name ~* ?", query)
      end
    end
  end
end