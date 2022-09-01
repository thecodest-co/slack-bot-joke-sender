require 'httparty'
require 'interactor'
require_relative 'download_joke'
require_relative 'adjust_joke'
require_relative 'send_message'

class SendJoke
  include Interactor::Organizer

  organize DownloadJoke, AdjustJoke, SendMessage
end