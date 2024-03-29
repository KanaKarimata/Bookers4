class NoticeEventsMailer < ApplicationMailer
  def sent_notification(member, event)
    @group = event[:group]
    @title = event[:title]
    @body = event[:body]
    
    @mail = NoticeEventsMailer.new()
    mail (
      from: ENV['MAIL_ADDRESS']
      to: member.email,
      subject: 'New Event Notice!'
    )
  end
  
  def self.send_notifications_to_group(event)
    group = event[:group]
    group.users.each do |member|
      NoticeEventsMailer.sent_notification(member, event).deliver_now
    end
  end
  
end
