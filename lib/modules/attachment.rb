module Attachment
  def self.[](attachments)
    Module.new do
      extend ActiveSupport::Concern

      included do
        attachments.each do |attachment|
          has_one_attached attachment

          define_method "#{attachment}_file=" do |file|
            return if file.blank?

            eval "#{attachment}.attach(
              io: file[:tempfile],
              filename: file[:filename],
              content_type: file[:type],
              )"
          end
        end
      end
    end
  end
end
