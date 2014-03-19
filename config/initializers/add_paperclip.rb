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
            ori = style && style == :original
            Digest::MD5.hexdigest(ori ? obj.id.to_s + hex + "server" : hex + obj.id.to_s)
        end
    end
end