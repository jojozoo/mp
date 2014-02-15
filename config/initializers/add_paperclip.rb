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
            Digest::MD5.hexdigest('hi' + attachment.instance.id.to_s)
            # ":random.#{@ext}#{'.:style.jpg' if style && style != :original}"
        end
    end
end