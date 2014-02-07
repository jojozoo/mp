# module Paperclip
#   class Cropper < Thumbnail
#     def transformation_command
#       if crop_command
#         crop_command + super.join(' ').sub(/ -crop \S+/, '').split(' ')
#       else
#         super
#       end
#     end
#     def crop_command
#       target = @attachment.instance
#       if !target.x.blank? && !target.y.blank? && !target.w.blank? && !target.h.blank?
#         ["-crop", "#{target.w}x#{target.h}+#{target.x}+#{target.y}"]
#       end  
#     end

#   end
# end