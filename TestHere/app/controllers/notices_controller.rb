class NoticesController < InheritedResources::Base

	def index
		@message_occurences = {}
    @message_occurences.default = 0

    Notice.each do |notice|
      message = notice.message.split('Exception: ').first
      @message_occurences[message] += 1
    end
  end

end