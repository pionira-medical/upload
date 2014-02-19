ActiveAdmin.register Order do
  menu priority: 2
  permit_params :order_number, :security_key, :description, :admin_user_id,
                user_attributes: [:gender, :academic_title, :first_name, :last_name, :email],
                addresses_attributes: [:title, :gender, :academic_title, :first_name, :last_name, :email, :phone, :hospital, :department, :street_1, :street_2, :zip, :city, :country, :reference]

  index do
    column :order_number
    column :created_at
    default_actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs 'Content' do
      f.input :order_number
      f.input :security_key
      f.input :description
      f.input :admin_user_id, as: :hidden, value: current_admin_user.id
    end
    f.inputs 'Contact', for: [:user, f.object.build_user] do |uf|
        uf.input :gender
        uf.input :academic_title
        uf.input :first_name
        uf.input :last_name
        uf.input :email
    end
    f.inputs do
      f.has_many :addresses, allow_destroy: true, new_record: true do |af|
        af.input :title
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
      row 'Customer' { |o| "#{o.user.academic_title} #{o.user.first_name} #{o.user.last_name}" }
      row 'E-Mail' { |o| o.user.email }
      row 'Admin' { |o| o.admin_user.email }
    end
    active_admin_comments
  end
end
