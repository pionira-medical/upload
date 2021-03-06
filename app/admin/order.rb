ActiveAdmin.register Order do
  menu priority: 2
  permit_params :order_number, :security_key, :aasm_state, :description, :admin_user_id,
                user_attributes: [:id, :gender, :academic_title, :first_name, :last_name, :email, :phone, :password],
                addresses_attributes: [:id, :title, :gender, :academic_title, :first_name, :last_name, :email, :phone, :hospital, :department, :street_1, :street_2, :zip, :city, :country, :reference]

  controller do
    defaults :finder => :find_by_order_number
  end

  index do
    column :order_number
    column :contact do |order| "#{order.user.academic_title} #{order.user.first_name} #{order.user.last_name}" end
    column :aasm_state
    column :admin do |order| "#{order.admin_user.email}" end
    column :created_at
    default_actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs 'Content' do
      f.input :order_number, :input_html => { :readonly => true }
      f.input :security_key, :input_html => { :readonly => true }
      f.input :aasm_state, as: :select, collection: [:waiting_for_upload, :waiting_for_review, :in_production, :invoiced]
      f.input :description
      f.input :admin_user_id, as: :hidden, value: current_admin_user.id
    end
    f.inputs 'Contact', for: [:user, f.object.user || f.object.build_user] do |uf|
      uf.input :gender
      uf.input :academic_title
      uf.input :first_name
      uf.input :last_name
      uf.input :email
      uf.input :phone
      uf.input :password, as: :hidden, value: f.object.security_key
    end
    f.inputs do
      f.has_many :addresses do |af|
        af.input :title, as: :select, collection: ['Rechnungsadresse', 'Lieferadresse', 'Sonstiges']
        af.input :academic_title
        af.input :first_name
        af.input :last_name
        af.input :gender
        af.input :hospital
        af.input :department
        af.input :street_1
        af.input :street_2
        af.input :zip
        af.input :city
        af.input :country, as: :string
        af.input :email
        af.input :phone
        af.input :reference
      end
    end
    f.actions
  end

  show do
    attributes_table do
      row :order_number
      row :security_key
      row :description
      row :aasm_state
      row 'Customer' do |o| "#{o.user.academic_title} #{o.user.first_name} #{o.user.last_name}" end
      row 'E-Mail' do |o| o.user.email end
      row 'Phone' do |o| o.user.phone end
      row 'Admin' do |o| o.admin_user.email end
    end
    panel("Addresses") do
      attributes_table_for(order.addresses) do
        row :title
        row :academic_title
        row :first_name
        row :last_name
        row :gender
        row :hospital
        row :department
        row :street_1
        row :street_2
        row :zip
        row :city
        row :country
        row :email
        row :phone
        row :reference
      end
    end
    active_admin_comments
  end
end
