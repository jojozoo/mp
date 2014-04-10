MIME::Types['image/pjpeg'][0].extensions = 'jpg'
MIME::Types['application/octet-stream'][0].extensions = []
# Paperclip.options[:swallow_stderr] = false

module Paperclip
    module Interpolations
        def random(attachment, style)
            Digest::MD5.hexdigest(attachment.instance.id.to_s)[0..9]
            # ":random.#{@ext}#{'.:style.jpg' if style && style != :original}"
        end

        def randomp(attachment, style)
            obj = attachment.instance
            hex = obj.is_a?(Image) ? obj.hex.to_s : 'mp_server' # 别的类用不到randomp
            ori = style && style.to_sym == :original
            Digest::MD5.hexdigest(ori ? obj.id.to_s + hex + "server" : hex + obj.id.to_s)
        end
    end
end

# default url
module Paperclip
  class UrlGenerator
    def for(style_name, options)
      escape_url_as_needed(
        timestamp_as_needed(
          @attachment_options[:interpolator].interpolate(most_appropriate_url(style_name), @attachment, style_name),
          options
      ), options)
    end

    private

    def most_appropriate_url style_name
      if @attachment.original_filename.nil?
        default_url
      else
        if @attachment.instance.is_a?(Image) and style_name.to_sym.eql?(:original)
          "/system/:class/:id/:updated_at/:id_partition/:style/:random.:extension"
        else
          @attachment_options[:url]
        end
      end
    end

  end
end
