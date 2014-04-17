class Upload < ActiveRecord::Base
    belongs_to :order
    has_attached_file :attachment
    do_not_validate_attachment_file_type :attachment
end
