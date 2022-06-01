require 'turnip/node/base'
require 'turnip/node/tag'
require 'turnip/node/scenario_group_definition'
require 'turnip/node/rule'

module Turnip
  module Node
    #
    # @note Feature metadata generated by Gherkin
    #
    #     {
    #       type: :Feature,
    #       tags: [], # Array of Tag
    #       location: { line: 10, column: 3 },
    #       language: 'en',
    #       keyword: 'Feature',
    #       name: 'Feature name',
    #       description: 'Feature description',
    #       children: [], # Array of Background, Scenario and Scenario Outline
    #     }
    #
    class Feature < ScenarioGroupDefinition
      include HasTags

      def language
        @raw[:language]
      end

      def children
        @children ||= @raw[:children].map do |child|
          unless child[:background].nil?
            next Background.new(child[:background])
          end

          unless child[:scenario].nil?
            klass = child.dig(:scenario, :examples).nil? ? Scenario : ScenarioOutline
            next klass.new(child[:scenario])
          end

          unless child[:rule].nil?
            next Rule.new(child[:rule])
          end
        end.compact
      end

      def rules
        @rules ||= children.select do |c|
          c.is_a?(Rule)
        end
      end

      def metadata_hash
        super.merge(:type => Turnip.type, :turnip => true)
      end
    end
  end
end