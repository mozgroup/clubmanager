# == Schema Information
#
# Table name: messages
#
#  id                   :integer          not null, primary key
#  author_id            :integer
#  send_to              :string(255)      default("")
#  copy_to              :string(255)      default("")
#  blind_copy_to        :string(255)      default("")
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
  attr_accessible :blind_copy_to, :body, :copy_to, :importance, :send_to, :sent_at, :status, :subject, :author_id

  belongs_to :author, class_name: 'User', foreign_key: :author_id

  delegate :full_name, to: :author, prefix: true, allow_nil: true

  StatusSent = 'sent'
  StatusDraft = 'draft'
  StatusTrash = 'trash'
  Important = 'important'

  scope :belonging_to, lambda { |user| where('author_id = :id', id: user.id) }
  scope :drafts, where('status = :s', s: StatusDraft)
  scope :sent, where('status = :s', s: StatusSent)
  scope :trash, where('status = :s', s: StatusTrash)

#  def deliver
#    @recipients = recipients
#    raise Exceptions::NoRecipients if @recipients.empty?
#
#    self.save! if self.new_record?
#
#    self.envelopes.create(recipient_id: self.author_id, delivered_at: Time.zone.now, author_flag: true)
#
#    @recipients.each do |recipient|
#      recip_name = recipient.split(' ', 2)
#      user = User.find_by_first_name_and_last_name(recip_name[0], recip_name[1])
#      if user
#        self.envelopes.create(recipient_id: user.id, delivered_at: Time.zone.now)
#      end
#    end
#
#    self.status = StatusSent
#    self.sent_at = Time.zone.now
#    self.save!
#  end
#
#  def reply(all_flag = nil)
#    raise Exceptions::MessageNotSent unless self.status == StatusSent
#
#    new_send_to = self.author_full_name
#    new_copy_to = all_flag.blank? ? "" : reply_copy_to
#    new_subject = "Re: #{self.subject}"
#    new_body = "<br /><div class=\"left-border grey\">On #{self.sent_at.strftime("%m/%d/%Y %I:%M %p")} #{author_full_name} wrote: <br /><br />#{self.body}</div>"
#
#    Message.new(send_to: new_send_to, copy_to: new_copy_to, subject: new_subject, body: new_body)
#  end
#
#  def forward
#    raise Exceptions::MessageNotSent unless self.status == StatusSent
#
#    new_subject = "Fwd: #{self.subject}"
#    new_msg_hdr = "<br /><br />--------Original Message--------<br /><b>Subject:</b> #{self.subject}<br /><b>Date:</b> #{self.sent_at.strftime('%a, %-d %b %Y %H:%M')}<br /><b>To:</b> #{self.send_to}<br/>" + (self.copy_to.blank? ? "" : "<b>Cc:</b> #{self.copy_to}<br />") + "<br /><br />" 
#    new_body = new_msg_hdr + self.body
#
#    Message.new(subject: new_subject, body: new_body)
#  end
#
#  protected
#
#    def reply_copy_to
#      (self.send_to.split(/,\s*/) + self.copy_to.split(/,\s*/)).join(', ')
#    end
#
#    def recipients
#      self.send_to.split(/,\s*/) + self.copy_to.split(/,\s*/) + self.blind_copy_to.split(/,\s*/)
#    end
end
