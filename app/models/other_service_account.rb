class OtherServiceAccount < ApplicationRecord
  enum provider: {
    facebook: 1
  }
end
