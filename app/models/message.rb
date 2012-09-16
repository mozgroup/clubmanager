# == Schema Information
#
# Table name: messages
#
#  id                   :integer          not null, primary key
#  author_id            :integer
#  send_to              :string(255)
#  copy_to              :string(255)
#  blind_copy_to        :string(255)
#  subject              :string(255)
#  body                 :text
#  status               :string(255)      default("draft")
#  importance           :string(255)      default("normal")
#  sent_at              :datetime
#  read_receipt_request :boolean          default(FALSE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Message < ActiveRecord::Base
  attr_accessible :blind_copy_to, :body, :copy_to, :importance, :send_to, :sent_at, :status, :subject

  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :envelopes

  delegate :full_name, to: :author, prefix: true

  def deliver
    @recipients = recipients
    raise Exceptions::NoRecipients if @recipients.empty?

#   @recipients.each do |recipient|
#     user = User.find_by_first_name_and_last_name(recipient.split(' ',2))
#     if user
#       self.envelopes.create(recipient_id: user.id)
#     end
#   end

    self.save!

  end

  protected

    def recipients
      self.send_to.split(/,\s*/) + self.copy_to.split(/,\s*/) + self.blind_copy_to.split(/,\s*/)
    end
end
