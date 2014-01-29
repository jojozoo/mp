MIME::Types['image/pjpeg'][0].extensions = 'jpg'
MIME::Types['application/octet-stream'][0].extensions = []
# Paperclip.options[:swallow_stderr] = false

module Paperclip
    module Interpolations
        def random(attachment, style)
            Digest::MD5.hexdigest(attachment.instance.id.to_s)[0..9]
            # ":random.#{@ext}#{'.:style.jpg' if style && style != :original}"
        end
    end
end

def Paperclip.generate_image_meta_info(instance, attachment, column = nil)
    instance.send "#{column}_info=", (Paperclip::Geometry.from_file(attachment.path).to_s rescue '');
end

def Paperclip.generate_exif(instance, attachment, column = nil)
    attachment.rewind
    instance.send "#{column}_exif=", begin
        hash = case attachment.original_filename
        when /\.(jpg|jpeg)$/i
            # to_hash方法已包含所有拍摄信息
            EXIFR::JPEG.new(attachment).to_hash
        when /\.(tif|tiff)$/i
            tiff = EXIFR::TIFF.new(attachment)
            tiff.to_hash.merge(:width => tiff.width, :height => tiff.height)
        else
            {}
        end

        hash.each {|k,v| hash[k] = case v; when Rational; v.to_f; when EXIFR::TIFF::Orientation; v.to_i; else; v; end }
        hash
    rescue
        {}
    end.to_json
end











