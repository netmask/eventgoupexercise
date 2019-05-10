json.extract! group_event, :id, :status, :title,
              :description,
              :name,
              :location,
              :days,
              :starts_at,
              :ends_at,
              :created_at,
              :updated_at

json.url group_event_url(group_event, format: :json)
