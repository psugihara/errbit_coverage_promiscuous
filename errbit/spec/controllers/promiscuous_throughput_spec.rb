require 'spec_helper'

describe NoticesController do

  let(:app) { Fabricate(:app) }

  context 'notices API' do
    before do
      @xml = Rails.root.join('spec','fixtures','promiscuous_test_notice.xml').read
      @app = App.find_by_api_key!('02720f964fc41d023ddd1afb33f150da')
      App.stub(:find_by_api_key!).and_return(@app)
      # @notice = App.report_error!(@xml)
    end

    it "generate notices" do
      App.should_receive(:report_error!).with(@xml).and_return(@notice)
      request.should_receive(:raw_post).and_return(@xml)
      post :create, :format => :xml
      response.should be_success
      # Same RegExp from Airbrake::Sender#send_to_airbrake (https://github.com/airbrake/airbrake/blob/master/lib/airbrake/sender.rb#L53)
      # Inspired by https://github.com/airbrake/airbrake/blob/master/test/sender_test.rb
      response.body.should match(%r{<id[^>]*>#{@notice.id}</id>})
      response.body.should match(%r{<url[^>]*>(.+)#{locate_path(@notice.id)}</url>})
    end

    it "generates a notice from xml in a data param [POST]" do
      App.should_receive(:report_error!).with(@xml).and_return(@notice)
      post :create, :data => @xml, :format => :xml
      response.should be_success
      # Same RegExp from Airbrake::Sender#send_to_airbrake (https://github.com/airbrake/airbrake/blob/master/lib/airbrake/sender.rb#L53)
      # Inspired by https://github.com/airbrake/airbrake/blob/master/test/sender_test.rb
      response.body.should match(%r{<id[^>]*>#{@notice.id}</id>})
      response.body.should match(%r{<url[^>]*>(.+)#{locate_path(@notice.id)}</url>})
    end

    it "generates a notice from xml [GET]" do
      App.should_receive(:report_error!).with(@xml).and_return(@notice)
      get :create, :data => @xml, :format => :xml
      response.should be_success
      response.body.should match(%r{<id[^>]*>#{@notice.id}</id>})
      response.body.should match(%r{<url[^>]*>(.+)#{locate_path(@notice.id)}</url>})
    end

  end
end