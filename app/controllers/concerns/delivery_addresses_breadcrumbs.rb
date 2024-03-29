# frozen_string_literal: true

module DeliveryAddressesBreadcrumbs
  extend ActiveSupport::Concern

  included do
    add_breadcrumb 'CRM', :crm_root_url
    add_breadcrumb 'Clientes', :crm_clients_url
  end

  def build(action_name)
    case action_name
    when 'new', 'create'
      breadrcumbs_new
    when 'edit', 'update'
      breadrcumbs_edit
    end
  end

  def breadrcumbs_new
    add_breadcrumb @client.name.upcase, crm_client_path(@client, tab: :addresses)
    add_breadcrumb 'Direcciones de entrega', crm_client_path(@client, tab: :addresses)
    add_breadcrumb 'Nuevo'
  end

  def breadrcumbs_edit
    add_breadcrumb @client.name.upcase, crm_client_path(@client, tab: :contacts)
    add_breadcrumb 'Direcciones de entrega', crm_client_path(@client, tab: :addresses)
    add_breadcrumb @address.name.upcase
    add_breadcrumb 'Editar'
  end

  def set_client
    client_id = params[:client_id].present? ?
      params[:client_id] : @address.client_id
    @client = Client.find(client_id)
  end

  def set_breadcrumb
    build(action_name)
  end
end
