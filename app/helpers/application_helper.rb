module ApplicationHelper
    
    def bulma_class_for(flash_type)
        case flash_type
        when :notice
            "is-success"
        when :alert
            "is-warning"
        else
            flash_type.to_s
        end
    end
end
