module GitHub
  module Resources
    module Responses
      URL_OPTIONS = {
          :base_api_url => "https://github.example.com/api/v3",
          :base_url => "https://github.example.com"
      }

      def self.options_to_output(options, keys_to_use)
        keys_to_use.map { |k| k.to_sym }.each_with_object(Hash.new) { |k, output| output[k] = options[k] }
      end

      def self.pre_receive_environment_download(options = {})
        options = URL_OPTIONS.merge(
            :id => 3,
            :downloaded_at => '2016-05-26T07:42:53-05:00',
            :state => 'success',
            :message => nil
        ).merge options
        options[:url] = "#{options[:base_api_url]}/admin/pre-receive-environments/#{options[:id]}/downloads/latest"
        options_to_output options, %w(url state downloaded_at message)
      end

      def self.pre_receive_environment(options = {})
        options = URL_OPTIONS.merge(
            :id => 1,
            :name => 'Default',
            :image_url => 'githubenterprise://internal',
            :created_at => '2016-05-20T11:35:45-05:00',
            :hooks_count => 1,
            :download_options => {},
            :default_environment => true
        ).merge options
        options.update(
            :url => "#{options[:base_api_url]}/admin/pre-receive-environments/#{options[:id]}",
            :html_url => "#{options[:base_url]}/admin/pre_receive_environments/#{options[:id]}",
            :download => pre_receive_environment_download(options.merge options[:download_options])
        )
        options_to_output options, %w(id name image_url url html_url default_environment created_at hooks_count download)
      end

      def self.pre_receive_script_repository(options = {})
        options = URL_OPTIONS.merge(
            :id => 595,
            :full_name => "ExampleOrg/hooks",
        ).merge options
        options[:url] ||= "#{options[:base_api_url]}/repos/#{options[:full_name]}"
        options[:html_url] ||= "#{options[:base_url]}/#{options[:script_repository][:full_name]}"
        options_to_output options, %w(id full_name url html_url)
      end

      def self.pre_receive_hook(options = {})
        options = URL_OPTIONS.merge(
            :id => 1,
            :name => 'Check Commits',
            :script => 'scripts/commmit_check.sh',
            :script_repository => {
                :id => 595,
                :full_name => "DevIT/hooks"
            },
            :environment => PRE_RECEIVE_ENVIRONMENT,
            :enforcement => "disabled",
            :allow_downstream_configuration => false
        ).merge options
        options[:script_repository][:url] ||=
            "#{options[:base_api_url]}/repos/#{options[:script_repository][:full_name]}"
        options[:script_repository][:html_url] ||=
            "#{options[:base_url]}/#{options[:script_repository][:full_name]}"
        options_to_output(options, %w(id name enforcement script script_repository environment allow_downstream_configuration))
      end

      def self.pre_receive_hook_repo(options = {})
        options = URL_OPTIONS.merge(
            :id => 42,
            :name => "Check Commits",
            :enforcement => "disabled",
            :configuration_url => "/orgs/octocat/pre-receive-hooks/42"
        ).merge options
        options[:configuration_url] = "#{options[:base_api_url]}#{options[:configuration_url]}"
        options_to_output(options, %w(id name enforcement configuration_url))
      end

      def self.pre_receive_hook_org(options = {})
        options = URL_OPTIONS.merge(
            :id => 42,
            :name => "Check Commits",
            :enforcement => "disabled",
            :configuration_url => "/admin/pre-receive-hooks/42",
            :allow_downstream_configuration => true
        ).merge options
        options[:configuration_url] = "#{options[:base_api_url]}#{options[:configuration_url]}"
        options_to_output(options, %w(id name enforcement configuration_url allow_downstream_configuration))
      end

      PRE_RECEIVE_ENVIRONMENT ||= pre_receive_environment ({
          :id => 2,
          :name => "DevTools Hook Env",
          :image_url => "https://my_file_server/path/to/devtools_env.tar.gz",
          :default_environment => false
      })

      PRE_RECEIVE_ENVIRONMENT_CREATE ||= PRE_RECEIVE_ENVIRONMENT.merge ({
          "download": pre_receive_environment_download(:id => 2, :state => 'not_started', :downloaded_at => nil)
      })

      PRE_RECEIVE_ENVIRONMENTS ||= [
          pre_receive_environment(:download_options => {:state => 'not_started'}, :hooks_count => 14),
          PRE_RECEIVE_ENVIRONMENT
      ]

      PRE_RECEIVE_ENVIRONMENT_DOWNLOAD ||=
          pre_receive_environment_download :state => 'not_started',
                                           :downloaded_at => nil

      PRE_RECEIVE_ENVIRONMENT_DOWNLOAD_2 ||= pre_receive_environment_download

      PRE_RECEIVE_HOOK ||= pre_receive_hook
      PRE_RECEIVE_HOOKS ||= [pre_receive_hook]
      PRE_RECEIVE_HOOK_UPDATE ||= pre_receive_hook :allow_downstream_configuration => true, :environment => pre_receive_environment

      PRE_RECEIVE_HOOK_REPO ||= pre_receive_hook_repo

      PRE_RECEIVE_HOOKS_REPO ||= [pre_receive_hook_repo]

      PRE_RECEIVE_HOOK_REPO_UPDATE ||= pre_receive_hook_repo :enforcement => "enabled",
          :configuration_url => "/repos/octocat/hello-world/pre-receive-hooks/42"

      PRE_RECEIVE_HOOK_ORG ||= pre_receive_hook_org
      PRE_RECEIVE_HOOKS_ORG ||= [pre_receive_hook_org]
      PRE_RECEIVE_HOOK_ORG_UPDATE ||= pre_receive_hook_org :enforcement => "enabled",
          :configuration_url => "/orgs/octocat/pre-receive-hooks/42",
          :allow_downstream_configuration => false

    end
  end
end
