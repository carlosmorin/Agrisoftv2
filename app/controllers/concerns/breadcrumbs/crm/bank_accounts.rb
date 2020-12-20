# frozen_string_literal: true

module Breadcrumbs::Crm
  module BankAccounts
    extend ActiveSupport::Concern

    included do
      add_breadcrumb 'CRM', :crm_root_path
      add_breadcrumb 'Clientes', :crm_clients_path
    end

    def build(action_name)
      case action_name
      when 'new', 'create'
        breadrcumbs_new
      when 'edit', 'update'
        breadrcumbs_edit
      when 'show'
        breadrcumbs_show
      end
    end

    def breadrcumbs_new
      add_breadcrumb @client.name.upcase, crm_client_path(@client, tab: :bank_accounts)
      add_breadcrumb 'Cuentas', crm_client_path(@client, tab: :bank_accounts)
      add_breadcrumb 'Nueva'
    end

    def breadrcumbs_edit
      add_breadcrumb @client.name.upcase, crm_client_path(@client, tab: :bank_accounts)
      add_breadcrumb 'Cuentas', crm_client_path(@client, tab: :bank_accounts)
      add_breadcrumb 'Editar'
    end

    def breadrcumbs_show
      add_breadcrumb @client.name.upcase, crm_client_path(@client, tab: :bank_accounts)
      add_breadcrumb 'Cuentas', crm_client_path(@client, tab: :bank_accounts)
      add_breadcrumb 'Detalle'
    end

    def set_client
      client_id = params[:client_id].present? ? params[:client_id] : @bank_account.accountable_id
      @client = Client.find(client_id)
    end

    def build_breadcrumbs
      build(action_name)
    end
  end
end
