class Machinery < ApplicationRecord
  before_validation :generate_qr_token, on: :create

  validates :qr_token, presence: true, uniqueness: true

  private

  def generate_qr_token
    self.qr_token ||= SecureRandom.hex(10)  # ejemplo: "a93fbc12e7fa8c2c35b7"
  end
end
