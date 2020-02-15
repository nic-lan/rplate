# frozen_string_literal: true

module RPlate
  module Commands
    class Generate
      class StoreEntity
        class AskOverwrite
          LAYOUT = "------------------------\n"

          def self.confirm?(filename)
            return true unless File.exist?(filename)

            HighLine.agree(
              "#{LAYOUT}#{filename} already exists.\nOverwrite?"
            )
          end
        end
      end
    end
  end
end
