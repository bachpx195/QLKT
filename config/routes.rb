Rails.application.routes.draw do

  namespace :admin do
    resources :config_categories do
      collection do
        get 'duplicate', to: 'config_categories#duplicate', as: 'duplicate'
        get 'search', to: 'config_categories#search', as: 'search'
        get 'search_form', to: 'config_categories#search_form', as: 'search_form'
      end
    end
  end
  devise_for :users, class_name: "Admin::User", path: '', path_names: {sign_in: 'login', sign_out: 'logout'}
  namespace :admin do
    resources :room_statistics do
      collection do
        get 'search', to: 'room_statistics#search', as: 'search'
        get 'search_form', to: 'room_statistics#search_form', as: 'search_form'
      end
    end

    resources :reports do
      collection do
        get 'detail', to: 'reports#detail', as: 'detail'
      end
    end
    resources :feedbacks do
      collection do
        get 'duplicate', to: 'feedbacks#duplicate', as: 'duplicate'
        get 'search', to: 'feedbacks#search', as: 'search'
      end
    end
    resources :configs do
      collection do
        get 'duplicate', to: 'configs#duplicate', as: 'duplicate'
        get 'search', to: 'configs#search', as: 'search'
        get 'search_form', to: 'configs#search_form', as: 'search_form'
        post 'save', to: 'configs#save', as: 'save'
      end
    end
    resources :room_devices do
      collection do
        get 'duplicate', to: 'room_devices#duplicate', as: 'duplicate'
        get 'search', to: 'room_devices#search', as: 'search'
        get 'room_form_new', to: 'room_devices#room_form_new', as: 'room_form_new'
        get ':id/room_form_edit', to: 'room_devices#room_form_edit', as: 'room_form_edit'
        delete ':id/room_form_destroy', to: 'room_devices#room_form_destroy', as: 'room_form_destroy'
      end
    end
    resources :payment_bills do
      collection do
        get 'duplicate', to: 'payment_bills#duplicate', as: 'duplicate'
        get 'search', to: 'payment_bills#search', as: 'search'
      end
    end
    resources :bill_details do
      collection do
        get 'duplicate', to: 'bill_details#duplicate', as: 'duplicate'
        get 'search', to: 'bill_details#search', as: 'search'
      end
    end
    resources :bills do
      collection do
        get 'duplicate', to: 'bills#duplicate', as: 'duplicate'
        get 'search', to: 'bills#search', as: 'search'
        get 'search_form', to: 'bills#search_form', as: 'search_form'
        get 'agreements', to: "bills#agreements", as: 'agreements'
        get 'export', to: "bills#export", as: 'export'
        get 'export-all', to: "bills#export_all", as: 'export_all'
        get 'print/:bill_id', to: "bills#print", as: 'print'
        get 'print_all', to: "bills#print_all", as: 'print_all'
        post 'exported', to: "bills#exported", as: 'exported'
        put 'exported', to: "bills#exported"
        patch 'exported', to: "bills#exported"
      end
    end
    resources :electricity_waters do
      collection do
        get 'duplicate', to: 'electricity_waters#duplicate', as: 'duplicate'
        get 'search', to: 'electricity_waters#search', as: 'search'
        get 'room/:room_id/year/:year/month/:month/start_electricity/:start_electricity/start_water/:start_water/edit', to: 'electricity_waters#edit_by_conditions', as: 'edit_by_conditions'
      end
    end
    resources :agreement_services do
      collection do
        get 'duplicate', to: 'agreement_services#duplicate', as: 'duplicate'
        get 'search', to: 'agreement_services#search', as: 'search'
      end
    end
    resources :agreement_renters do
      collection do
        get 'duplicate', to: 'agreement_renters#duplicate', as: 'duplicate'
        get 'search', to: 'agreement_renters#search', as: 'search'
      end
    end
    resources :agreements do
      collection do
        get 'duplicate', to: 'agreements#duplicate', as: 'duplicate'
        get 'search', to: 'agreements#search', as: 'search'
        get 'render-form', to: 'agreements#renter_form', as: 'renter_form'
        get ':id/agreement_form_edit', to: 'agreements#agreement_form_edit', as: 'agreement_form_edit'
        get 'agreement_form_new', to: 'agreements#agreement_form_new', as: 'agreement_form_new'
        get 'agreements_by_room', to: 'agreements#agreements_by_room', as: 'agreements_by_room'
        delete ':id/agreement_form_destroy', to: 'agreements#agreement_form_destroy', as: 'agreement_form_destroy'
        post 'render-form', to: 'agreements#renter_create', as: 'renter_create'
      end
    end
    resources :renters do
      collection do
        get 'duplicate', to: 'renters#duplicate', as: 'duplicate'
        get 'search', to: 'renters#search', as: 'search'
        get 'new-ajax-form', to: 'renters#new_ajax_form', as: 'new_ajax_form'
        get 'edit-ajax-form/:id', to: 'renters#edit_ajax_form', as: 'edit_ajax_form'
        get 'renters_in_room/:id', to: 'renters#renters_in_room', as: 'renters_in_room'
        get 'edit-ajax-form-renters-in-room/:id', to: 'renters#edit_ajax_form_renters_in_room', as: 'edit_ajax_form_renters_in_room'
      end
    end
    resources :services do
      collection do
        get 'duplicate', to: 'services#duplicate', as: 'duplicate'
        get 'search', to: 'services#search', as: 'search'
        get 'search_form', to: 'services#search_form', as: 'search_form'

      end
    end
    resources :rooms do
      collection do
        get 'duplicate', to: 'rooms#duplicate', as: 'duplicate'
        get 'search', to: 'rooms#search', as: 'search'
        get ':id/devices', to: 'rooms#devices', as: 'devices'
      end
    end
    resources :buildings do
      collection do
        get 'duplicate', to: 'buildings#duplicate', as: 'duplicate'
        get 'search', to: 'buildings#search', as: 'search'
      end
    end
    resources :group_permissions do
      collection do
        get 'duplicate', to: 'group_permissions#duplicate', as: 'duplicate'
        get 'search', to: 'group_permissions#search', as: 'search'
      end
    end
    resources :users do
      collection do
        get 'duplicate', to: 'users#duplicate', as: 'duplicate'
        get 'search', to: 'users#search', as: 'search'
      end
    end
    resources :functions do
      collection do
        get 'duplicate', to: 'functions#duplicate', as: 'duplicate'
        get 'search', to: 'functions#search', as: 'search'
      end
    end
    resources :permissions do
      collection do
        get 'duplicate', to: 'permissions#duplicate', as: 'duplicate'
        get 'search', to: 'permissions#search', as: 'search'
      end
    end
    resources :groups do
      collection do
        get 'duplicate', to: 'groups#duplicate', as: 'duplicate'
        get 'search', to: 'groups#search', as: 'search'
      end
    end

    resources :dashboard do
      collection do
        get 'post', to: 'dashboard#post', as: 'post'
        get 'start', to: 'dashboard#start', as: 'start'
        get 'callback', to: 'dashboard#callback', as: 'callback'
        get 'electricity_water', to: 'dashboard#electricity_water', as: 'electricity_water'
        get 'agreement', to: 'dashboard#agreement', as: 'agreement'

      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "admin/dashboard#index"
end
