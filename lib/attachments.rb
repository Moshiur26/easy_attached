module Attachments
  def self.[](attachments)
    Module.new do
      extend ActiveSupport::Concern

      included do
        attachments.each do |attachment|
          has_many_attached attachment

          define_method "#{attachment}_file=" do |files|
            return if files.blank?

            eval "#{attachment}.attach(files.map do |file|
                {
                  io: file[:tempfile],
                  filename: file[:filename],
                  content_type: file[:type],
                }
              end)"
          end
        end
      end
    end
  end
end
