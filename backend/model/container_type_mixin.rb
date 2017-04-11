module ContainerTypeMixin

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

    def create_from_json(json, opts = {})
      unless json['type']
        # Derive the container's type from the Container Profile if possible

        if json['container_profile']
          container_profile_id = JSONModel.parse_reference(json['container_profile']['ref'])[:id]
          container_profile = ContainerProfile.get_or_die(container_profile_id)

          # More sophisticated logic could go here...
          if container_profile.name == 'Box'
            json['type'] = 'box'
          end
        end

        super
      end
    end
  end

end
