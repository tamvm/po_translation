require "mechanize"
require "active_support/core_ext"
# require File.expand_path(File.join(File.dirname(__FILE__), "mechanize_helper.rb"))
include Po::MechanizeHelper

module Po
  module GoogleTranslator
    def self.translate(str)
      str = str.strip
      return "" if str.blank?
      params = {
        "client" => "t",
        "sl" => "en",
        "tl" => "vi",
        "hl" => "en",
        "sc" => "2",
        "ie" => "UTF-8",
        "oe" => "UTF-8",
        "oc" => "1",
        "otf" => "2",
        "ssel" => "3",
        "tsel" => "6",
        "q" => str
      }
      result = agent.get("http://translate.google.com.vn/translate_a/t", params)
      json = JSON(result.body.match(/^\[(\[\[.*?\]\])/)[1])
      json[0][0]
    end
  end
end
