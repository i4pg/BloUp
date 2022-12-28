class Text < ApplicationRecord
  has_one :article, as: :articleble, dependent: :destroy
end
