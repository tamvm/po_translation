require "po/version"
require "po/mechanize_helper"
require "po/google_translator"

require 'get_pomo'
require "active_support/core_ext"
require "htmlentities"

module Po
  class PoTranslation
    class << self
      def standarize(msgid, translated_str)
        return translated_str if translated_str.blank?
        translated_str = HTMLEntities.new.encode(translated_str.gsub("% s", "%s").gsub("\" ", "\"").gsub(/(\w) ([:"\.\?])"$\n/, "\1\2\"").strip)
        if msgid[0] == msgid[0].upcase
          translated_str = translated_str.capitalize
        end
      end

      def translate(input_file, output_path=nil)
        puts "--- #{input_file}"
        translations = GetPomo::PoFile.parse(File.read(input_file))
        translations.each_with_index do |translation, index|
          next if translation.msgid.blank? || translation.msgid.match(/["']/)

          msgstr = standarize(translation.msgid, GoogleTranslator.translate(translation.msgid))
          next if msgstr.blank?

          translation.msgstr = msgstr
          puts translation.msgstr
          if index % 20 == 0
            puts index
            sleep 2
          end
        end

        unless output_path
          output_path = File.dirname(input_file)
        end
        File.write(File.join(output_path, "#{File.basename(input_file, ".*")}-trans.po"), GetPomo::PoFile.to_text(translations))
      end
    end
  end
end
