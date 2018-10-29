module ApplicationHelper
    
    def bulma_class_for(flash_type)
        case flash_type
        when "success"
            "is-info"
        when "notice"
            "is-success"
        when "alert"
            "is-warning"
        when "error"
            "is-danger"
        else
            flash_type.to_s
        end
    end
end
